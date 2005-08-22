Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVHVWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVHVWNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVHVWMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:12:39 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57990 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751266AbVHVWMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:12:10 -0400
Date: Mon, 22 Aug 2005 13:04:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Russell King <rmk@arm.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] drop i386-isms from arm Kconfig
Message-ID: <20050822110427.GA9168@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills i386-specific stuff from arm Kconfig. Please apply,

								Pavel

---
commit f8f646eaf5fcf751912f8d178bab6414b6abf60c
tree 8a8ce2ab26011e4bbfe21c8506b1ae8f0d383faa
parent c1ef638f735cfb1a680ddb76aa37715be5c858ce
author <pavel@amd.(none)> Mon, 22 Aug 2005 13:03:41 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 13:03:41 +0200

 arch/arm/Kconfig |   37 -------------------------------------
 1 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -637,10 +637,6 @@ config PM
 	  and the Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-	  Note that, even if you say N here, Linux on the x86 architecture
-	  will issue the hlt instruction if nothing is to be done, thereby
-	  sending the processor to sleep and saving power.
-
 config APM
 	tristate "Advanced Power Management Emulation"
 	depends on PM
@@ -652,12 +648,6 @@ config APM
 	  battery status information, and user-space programs will receive
 	  notification of APM "events" (e.g. battery status change).
 
-	  If you select "Y" here, you can disable actual use of the APM
-	  BIOS by passing the "apm=off" option to the kernel at boot time.
-
-	  Note that the APM support is almost completely disabled for
-	  machines with more than one CPU.
-
 	  In order to use APM, you will need supporting software. For location
 	  and more information, read <file:Documentation/pm.txt> and the
 	  Battery Powered Linux mini-HOWTO, available from
@@ -667,39 +657,12 @@ config APM
 	  manpage ("man 8 hdparm") for that), and it doesn't turn off
 	  VESA-compliant "green" monitors.
 
-	  This driver does not support the TI 4000M TravelMate and the ACER
-	  486/DX4/75 because they don't have compliant BIOSes. Many "green"
-	  desktop machines also don't have compliant BIOSes, and this driver
-	  may cause those machines to panic during the boot phase.
-
 	  Generally, if you don't have a battery in your machine, there isn't
 	  much point in using this driver and you should say N. If you get
 	  random kernel OOPSes or reboots that don't seem to be related to
 	  anything, try disabling/enabling this option (or disabling/enabling
 	  APM in your BIOS).
 
-	  Some other things you should try when experiencing seemingly random,
-	  "weird" problems:
-
-	  1) make sure that you have enough swap space and that it is
-	  enabled.
-	  2) pass the "no-hlt" option to the kernel
-	  3) switch on floating point emulation in the kernel and pass
-	  the "no387" option to the kernel
-	  4) pass the "floppy=nodma" option to the kernel
-	  5) pass the "mem=4M" option to the kernel (thereby disabling
-	  all but the first 4 MB of RAM)
-	  6) make sure that the CPU is not over clocked.
-	  7) read the sig11 FAQ at <http://www.bitwizard.nl/sig11/>
-	  8) disable the cache from your BIOS settings
-	  9) install a fan for the video card or exchange video RAM
-	  10) install a better fan for the CPU
-	  11) exchange RAM chips
-	  12) exchange the motherboard.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called apm.
-
 endmenu
 
 source "net/Kconfig"

-- 
if you have sharp zaurus hardware you don't need... you know my address
