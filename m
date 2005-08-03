Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVHDUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVHDUQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVHDUQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:16:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42886 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262659AbVHDUQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:16:34 -0400
Date: Wed, 3 Aug 2005 23:09:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks-2
Message-ID: <20050803210915.GA11196@elf.ucw.cz>
References: <200508022225.31429.kernel@kolivas.org> <42EF6DF7.6030100@punnoor.de> <200508022328.09482.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508022328.09482.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > As promised, here is an updated patch for the newly released 2.6.13-rc5.
> > > Boots and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.
> >
> > Doesn't compile for me w/ gcc 3.4.4:
> 
> Thanks for the report. Tiny change required. Here is a respun patch.

I'm not sure if you added them, but...

  CC      arch/i386/kernel/timers/timer_tsc.o
arch/i386/kernel/timers/timer_tsc.c: In function `mark_offset_tsc':
arch/i386/kernel/timers/timer_tsc.c:345: warning: `lost' might be used uninitialized in this function
arch/i386/kernel/timers/timer_tsc.c:345: warning: `delay' might be used uninitialized in this function
arch/i386/kernel/timers/timer_tsc.c:347: warning: `count' might be used uninitialized in this function

								Pavel


-- 
teflon -- maybe it is a trademark, but it should not be.
