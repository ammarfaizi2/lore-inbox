Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUJEOuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUJEOuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUJEOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 10:50:14 -0400
Received: from dialpool3-18.dial.tijd.com ([62.112.12.18]:49540 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S269040AbUJEOuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 10:50:09 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: fix suspending with mysqld
Date: Tue, 5 Oct 2004 16:46:34 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041004122422.GA2601@elf.ucw.cz> <200410042109.58519.lkml@kcore.org> <20041004222647.GA4723@openzaurus.ucw.cz>
In-Reply-To: <20041004222647.GA4723@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051646.35311.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 00:26, Pavel Machek wrote:
> Hi!
>
> > > mysqld does signal calls in pretty tight loop, and swsusp is not able
> > > to stop processes in such case. This should fix it. Please apply,
> >
> > I applied your patch to 2.6.9-rc3. Unfortunately, now the system doesn't
> > suspend anymore, it comes back almost immediately:
>
> And it did work before that patch? I fail to see how this patch could have
> broken anything.

Suspending worked (besides mysql, which I had to kill manually). With this 
patch it doesn't.

Jan

-- 
BOFH excuse #418:

Sysadmins busy fighting SPAM.
