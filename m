Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135288AbRDRUR0>; Wed, 18 Apr 2001 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDRURQ>; Wed, 18 Apr 2001 16:17:16 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:8717 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S135288AbRDRURN>; Wed, 18 Apr 2001 16:17:13 -0400
Date: Thu, 19 Apr 2001 07:30:33 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Won't Power down (Was: More about 2.4.3 timer problems)
In-Reply-To: <3ADCE83D.478F765B@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0104190718050.1106-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Andrew Morton wrote:

:viking wrote:
:> 
:> Incidentally, Andrew, thanks for that patch.
:
:My brain is fading.  Which patch was that?

Gee! 8-) and you suggested it to me!  It was the patch against 2.4.3-pre6
which corrected the system clock slowing down, due to the interrupts being
disabled for too long in framebuffer mode.  Well, it worked! I'm using it now,
and as I mentioned in the past email, my only trouble now is the non-powering
down of the machine.

Ah well, again, thanks for monitoring.And here's a few lines to add to that
patch too...your patch had neglected to turn on printk for all modules, and
when I compiled my kernel, that was fine, but my modules couldn't see
printk()!

--- linux-2.4.3-pre6/kernel/Makefile Sun Apr 15 20:00:00 2001
+++ lk/kernel/Makefile Sun Apr 15 21:00:00 2001
@@ -12,1 +12,1 @@

- export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
+ export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o printk.o

Thanks again.

-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!

