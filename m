Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFPAXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTFPAXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:23:12 -0400
Received: from vcgwp1.bit-drive.ne.jp ([211.9.32.211]:17550 "HELO
	vcgwp1.bit-drive.ne.jp") by vger.kernel.org with SMTP
	id S263131AbTFPAXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:23:06 -0400
To: mikpe@csd.uu.se
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hyoshiok@miraclelinux.com
Subject: Re: [Perfctr-devel] perfctr-2.5.5 released
In-Reply-To: <200306152229.h5FMTa93026063@harpo.it.uu.se>
References: <200306152229.h5FMTa93026063@harpo.it.uu.se>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Cuyahoga Valley)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20030616091846G.hyoshiok@miraclelinux.com>
Date: Mon, 16 Jun 2003 09:18:46 +0900
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

I just download perfctr 2.5.5 and see the difference
between 2.5.4 and 2.5.5 but I could not find code
changes except the changelog and todo.

$ diff -u perfctr-2.5.4 perfctr-2.5.5
diff -u perfctr-2.5.4/CHANGES perfctr-2.5.5/CHANGES
--- perfctr-2.5.4/CHANGES       2003-06-01 21:32:45.000000000 +0900
+++ perfctr-2.5.5/CHANGES       2003-06-16 07:11:23.000000000 +0900
@@ -1,4 +1,4 @@
-$Id: CHANGES,v 1.106 2003/06/01 12:32:45 mikpe Exp $
+$Id: CHANGES,v 1.107 2003/06/15 22:11:23 mikpe Exp $
 
                        CHANGES
                        =======
@@ -6,6 +6,15 @@
 [High-level changes in reverse chronological order. Detailed
  driver changes are in linux/drivers/perfctr/RELEASE-NOTES.]
 
+Version 2.5.5, 2003-06-15
+- Updates for driver model changes in kernel 2.5.71.
+- Minor updates to the library's event descriptions for Pentium 4.
+- Now supports SuSE's 2.4.19.SuSE-206 kernel for SLES 8 users.
+  Autodetection of SuSE kernel versions is not yet implemented:
+  pass "--patch=2.4.19.SuSE-206" to perfctr's update-kernel script
+  to ensure that the correct patch is applied.
+- Patch kit updates for 2.4.21 final and 2.4.20-18 RH kernels.
+
 Version 2.5.4, 2003-06-01
 - Corrected the driver's handling of OVF_PMI+FORCE_OVF counters
   on Pentium 4. This configuration didn't work at all, and
diff -u perfctr-2.5.4/TODO perfctr-2.5.5/TODO
--- perfctr-2.5.4/TODO  2003-06-01 21:27:53.000000000 +0900
+++ perfctr-2.5.5/TODO  2003-06-16 07:09:57.000000000 +0900
@@ -1,4 +1,6 @@
 Changes during perfctr-2.5:
+- SuSE kernels don't use EXTRAVERSION. Fix update-kernel to use
+  rpm to identify the exact version instead.
 - New AoS counter state layout:
        struct perfctr_cpu_user_state {
                unsigned int cstatus;
Common subdirectories: perfctr-2.5.4/etc and perfctr-2.5.5/etc
Common subdirectories: perfctr-2.5.4/examples and perfctr-2.5.5/examples
Common subdirectories: perfctr-2.5.4/linux and perfctr-2.5.5/linux
Common subdirectories: perfctr-2.5.4/patches and perfctr-2.5.5/patches
Common subdirectories: perfctr-2.5.4/usr.lib and perfctr-2.5.5/usr.lib

What's wrong? Any hints?

Regards,
  Hiro

From: mikpe@csd.uu.se
Subject: [Perfctr-devel] perfctr-2.5.5 released
Date: Mon, 16 Jun 2003 00:29:36 +0200 (MEST)
Message-ID: <200306152229.h5FMTa93026063@harpo.it.uu.se>

> Version 2.5.5 of perfctr, the Linux/x86 performance
> monitoring counters driver, is now available at the usual
> place: http://www.csd.uu.se/~mikpe/linux/perfctr/
> 
> x86-64 users please note that the 2.5.71 kernel won't
> compile on x86-64 due to incomplete 'driver model' changes.
> A patch to fix this and two other x86-64 bugs is in the
> patch-x86_64-2.5.71 file in perfctr's download directory.
> 
> Version 2.5.5, 2003-06-15
> - Updates for driver model changes in kernel 2.5.71.
> - Minor updates to the library's event descriptions for Pentium 4.
> - Now supports SuSE's 2.4.19.SuSE-206 kernel for SLES 8 users.
>   Autodetection of SuSE kernel versions is not yet implemented:
>   pass "--patch=2.4.19.SuSE-206" to perfctr's update-kernel script
>   to ensure that the correct patch is applied.
> - Patch kit updates for 2.4.21 final and 2.4.20-18 RH kernels.
> 
> / Mikael Pettersson
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by: eBay
> Great deals on office technology -- on eBay now! Click here:
> http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> _______________________________________________
> Perfctr-devel mailing list
> Perfctr-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfctr-devel
