Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWDMOCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWDMOCE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWDMOCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:02:03 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:10392 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964939AbWDMOCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:02:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrink_all_memory tweaks (was: Re: Userland swsusp failure (mm-related))
Date: Fri, 14 Apr 2006 00:01:29 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Fabio Comolli <fabio.comolli@gmail.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <b637ec0b0604080537s55e63544r8bb63c887e81ecaf@mail.gmail.com> <200604132242.57664.kernel@kolivas.org> <200604131554.31613.rjw@sisk.pl>
In-Reply-To: <200604131554.31613.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604140001.30287.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 23:54, Rafael J. Wysocki wrote:
> On Thursday 13 April 2006 14:42, Con Kolivas wrote:
> > This is not quite right at maintaining the original semantics I was
> > proposing. Since you are iterating over all priorities, setting may_swap
> > means you will reclaim mapped ram on the earlier passes once priority
> > gets low enough.
>
> No, I won't, because I don't update zone->prev_priority which is necessary
> to trigger this.  Unless of course zone->prev_priority is already low
> enough ...

Ah yes of course, that explains why I didn't need to either :P

> > Setting vm_swappiness temporarily to 100 is unncecessary. You should set
> > may_swap to 0 and set it to 1 on passes 3+.
>
> ... which can be dealt with by setting may_swap like you're saying.
>
> I'll make this change and repost as an RFC in a separate thread.

Great

-- 
-ck
