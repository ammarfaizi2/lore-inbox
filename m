Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270657AbTG0Dd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 23:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270658AbTG0Dd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 23:33:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:2791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270657AbTG0Ddz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 23:33:55 -0400
Date: Sat, 26 Jul 2003 20:46:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] sanitize power management config menus
Message-Id: <20030726204623.47b08882.rddunlap@osdl.org>
In-Reply-To: <20030727025647.GB17724@louise.pinerecords.com>
References: <20030726200213.GD16160@louise.pinerecords.com>
	<20030726194651.5e3f00bb.rddunlap@osdl.org>
	<20030727025647.GB17724@louise.pinerecords.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 04:56:47 +0200 Tomas Szepe <szepe@pinerecords.com> wrote:

| > 3.  The help text for Software Suspend (not part of this patch)
| > really needs some help.  Would you address that or shall I?
| 
| Sure, it would be nice if you could fish out an entry from somewhere.

OK, how's this look?

--
~Randy


patch_name:	sws_help.patch
patch_version:	2003-07-26.20:32:10
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make software_suspend help readable
product:	Linux
product_versions: 2.6.0-test1
diffstat:	=
 arch/i386/Kconfig   |   30 +++++++++++++++---------------
 arch/x86_64/Kconfig |   20 ++++++++++----------
 2 files changed, 25 insertions(+), 25 deletions(-


diff -Naur ./arch/i386/Kconfig~swshelp ./arch/i386/Kconfig
--- ./arch/i386/Kconfig~swshelp	2003-07-25 10:23:11.000000000 -0700
+++ ./arch/i386/Kconfig	2003-07-26 20:30:50.000000000 -0700
@@ -824,27 +824,27 @@
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
+	  Enable the possibility of suspending the machine. It doesn't need
+	  APM. You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
+	  (patch for sysvinit is needed). 
+
+	  This creates an image which is saved in your active swap space. On
+	  the next boot, pass the 'resume=/path/to/your/swap/file' option and
+	  the kernel will detect the saved image, restore the memory from it,
+	  and then continue to run as before you suspended.
+	  If you don't want the previous state to continue, use the 'noresume'
+	  kernel option. However, note that your partitions will appear to be
+	  damaged so you must re-mkswap your swap partitions/files to use them.
 
 	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
+	  in the meantime you cannot use those swap partitions/files which were
 	  involved in suspending. Also in this case there is a risk that buffers
 	  on disk won't match with saved ones.
 
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
+	  SMP is supported ``as-is''. There's code for it but doesn't work.
+	  There have been problems reported relating to SCSI.
 
-	  This option is about getting stable. However there is still some
+	  This option is close to getting stable. However there is still some
 	  absence of features.
 
 	  For more information take a look at Documentation/swsusp.txt.
diff -Naur ./arch/x86_64/Kconfig~swshelp ./arch/x86_64/Kconfig
--- ./arch/x86_64/Kconfig~swshelp	2003-07-13 20:37:13.000000000 -0700
+++ ./arch/x86_64/Kconfig	2003-07-26 20:31:04.000000000 -0700
@@ -300,17 +300,17 @@
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspending the machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. On the next
-	  boot, pass the 'resume=/path/to/your/swap/file' option and the kernel
-	  will detect the saved image, restore the memory from
-	  it, and then continue to run as before you suspended.
+	  Enable the possibility of suspending the machine. It doesn't need
+	  APM. You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit is needed). 
+
+	  This creates an image which is saved in your active swap space. On
+	  the next boot, pass the 'resume=/path/to/your/swap/file' option and
+	  the kernel will detect the saved image, restore the memory from it,
+	  and then continue to run as before you suspended.
 	  If you don't want the previous state to continue, use the 'noresume'
-	  kernel option. However, note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
+	  kernel option. However, note that your partitions will appear to be
+	  damaged so you must re-mkswap your swap partitions/files to use them.
 
 	  Right now you may boot without resuming and then later resume but
 	  in the meantime you cannot use those swap partitions/files which were
