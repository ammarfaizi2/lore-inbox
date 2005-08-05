Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVHEAGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVHEAGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVHEAGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:06:15 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:57476 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262727AbVHEAGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:06:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks-2
Date: Fri, 5 Aug 2005 10:02:17 +1000
User-Agent: KMail/1.8.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <200508022225.31429.kernel@kolivas.org> <200508022328.09482.kernel@kolivas.org> <20050803210915.GA11196@elf.ucw.cz>
In-Reply-To: <20050803210915.GA11196@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051002.17344.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 07:09 am, Pavel Machek wrote:
> Hi!
>
> > > > As promised, here is an updated patch for the newly released
> > > > 2.6.13-rc5. Boots and runs fine on P4HT (SMP+SMT kernel) built with
> > > > gcc 4.0.1.
> > >
> > > Doesn't compile for me w/ gcc 3.4.4:
> >
> > Thanks for the report. Tiny change required. Here is a respun patch.
>
> I'm not sure if you added them, but...
>
>   CC      arch/i386/kernel/timers/timer_tsc.o
> arch/i386/kernel/timers/timer_tsc.c: In function `mark_offset_tsc':
> arch/i386/kernel/timers/timer_tsc.c:345: warning: `lost' might be used
> uninitialized in this function arch/i386/kernel/timers/timer_tsc.c:345:
> warning: `delay' might be used uninitialized in this function
> arch/i386/kernel/timers/timer_tsc.c:347: warning: `count' might be used
> uninitialized in this function

Indeed the goto will bypass the setting of these variables and they will be 
uninitialised. Will fix with next version, thanks.

Con
