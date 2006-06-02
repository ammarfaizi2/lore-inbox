Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWFBGJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFBGJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWFBGJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:09:22 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:22493 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751205AbWFBGJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:09:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 16:08:33 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000101c685d7$1bc84390$d234030a@amr.corp.intel.com> <200606021355.23671.kernel@kolivas.org> <447FBC28.8030401@yahoo.com.au>
In-Reply-To: <447FBC28.8030401@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606021608.33928.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 14:18, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Friday 02 June 2006 12:28, Con Kolivas wrote:
> >>Actually looking even further, we only introduced the extra lookup of the
> >>next task when we started unlocking the runqueue in schedule(). Since we
> >>can get by without locking this_rq in schedule with this approach we can
> >>simplify dependent_sleeper even further by doing the dependent sleeper
> >>check after we have discovered what next is in schedule and avoid looking
> >>it up twice. I'll hack something up to do that soon.
> >
> > Something like this (sorry I couldn't help but keep hacking on it).
>
> Looking pretty good.

Thanks

> Nice to acknowledge Chris's idea for 
> trylocks in your changelog when you submit a final patch.

I absolutely would and I would ask for him to sign off on it as well, once we 
agreed on a final form.

-- 
-ck
