Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136104AbRECEeN>; Thu, 3 May 2001 00:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136094AbRECEeE>; Thu, 3 May 2001 00:34:04 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:14304 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S136107AbRECEdw>; Thu, 3 May 2001 00:33:52 -0400
Message-Id: <200105030433.XAA29609@asooo.flowerfire.com>
Date: Wed, 2 May 2001 21:33:47 -0700
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v388)
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.388)
Content-Transfer-Encoding: 7bit
Subject: 2.4.5-pre1 build issue w/ potential patch and menuconfig glitch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this isn't a duplicate, but I haven't seen these issues raised 
yet on the list.

I wasn't able to choose processor types in menuconfig without the patch 
appended below.  xconfig seemed happy with the parentheses.  I wasn't 
sure how to properly escape parens (if possible) so please consider this 
my own speculative hack.

Also, I don't seem to be able to backspace in numeric fields in 
menuconfig when using xterm emulation and a terminal app that sends ^H 
(and yes, "stty erase ^H").  I don't think this started with 2.4.5-pre1, 
but before I assumed it was my terminal flaking out.  Switching to 
$term=="vt100" or switching to DEL instead of ^H in the terminal app 
fixes the problem.  It's easy to reproduce by running Gnome terminal on 
a default RH6.2 system.

Thanks much, please contact me if you have any Qs.
--
Ken.
brownfld@irridia.com

--- linux/arch/i386/config.in-DIST	Wed May  2 20:38:09 2001
+++ linux/arch/i386/config.in	Wed May  2 20:40:06 2001
@@ -33,7 +33,7 @@
  	 Pentium-Classic			CONFIG_M586TSC \
  	 Pentium-MMX				CONFIG_M586MMX \
  	 Pentium-Pro/Celeron/Pentium-II		CONFIG_M686 \
-	 Pentium-III/Celeron(Coppermine)	CONFIG_MPENTIUMIII \
+	 Pentium-III/Celeron-Coppermine		CONFIG_MPENTIUMIII \
  	 Pentium-4				CONFIG_MPENTIUM4 \
  	 K6/K6-II/K6-III			CONFIG_MK6 \
  	 Athlon/Duron/K7			CONFIG_MK7 \
