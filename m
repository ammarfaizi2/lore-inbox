Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVCSK66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVCSK66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 05:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVCSK65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 05:58:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65204 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262443AbVCSK5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 05:57:02 -0500
Date: Sat, 19 Mar 2005 11:56:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-ram: update video.txt with more systems
Message-ID: <20050319105647.GA1485@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This updates video.txt documentation. Please apply,
								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean/Documentation/power/video.txt	2005-03-19 00:31:02.000000000 +0100
+++ linux/Documentation/power/video.txt	2005-03-14 08:59:32.000000000 +0100
@@ -32,7 +32,7 @@
   acpi_sleep=s3_bios,s3_mode is needed.
 
 (5) radeon systems, where X can soft-boot your video card. You'll need
-  patched X, and plain text console (no vesafb or radeonfb), see
+  new enough X, and plain text console (no vesafb or radeonfb), see
   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. Actually you
   should probably use vbetool (6) instead.
 
@@ -64,11 +64,14 @@
 ------------------------------------------------------------------------------
 Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
 Acer TM 242FX			vbetool (6)
+Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6)
 Acer TM 4052LCi		        s3_bios (2)
 Acer TM 636Lci			s3_bios vga=normal (2)
 Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back
 Acer TM 660			??? (*)
-Acer TM 800			vga=normal, X patches, see webpage (5)
+Acer TM 800			vga=normal, X patches, see webpage (5) or vbetool (6)
+Acer TM 803			vga=normal, X patches, see webpage (5) or vbetool (6)
+Acer TM 803LCi			vga=normal, vbetool (6)
 Arima W730a			vbetool needed (6)
 Asus L2400D                     s3_mode (3)(***) (S1 also works OK)
 Asus L3800C (Radeon M7)		s3_bios (2) (S1 also works OK)
@@ -76,8 +79,9 @@
 Athlon64 desktop prototype	s3_bios (2)
 Compal CL-50			??? (*)
 Compaq Armada E500 - P3-700     none (1) (S1 also works OK)
+Compaq Evo N620c		vga=normal, s3_bios (2)
 Dell 600m, ATI R250 Lf		none (1), but needs xorg-x11-6.8.1.902-1
-Dell D600, ATI RV250            vga=normal (**), or try vbestate (6)
+Dell D600, ATI RV250            vga=normal and X, or try vbestate (6)
 Dell Inspiron 4000		??? (*)
 Dell Inspiron 500m		??? (*)
 Dell Inspiron 600m		??? (*)
@@ -85,11 +89,12 @@
 Dell Inspiron 8500		??? (*)
 Dell Inspiron 8600		??? (*)
 eMachines athlon64 machines	vbetool needed (6) (someone please get me model #s)
-HP NC6000			s3_bios, may not use radeonfb (2)
+HP NC6000			s3_bios, may not use radeonfb (2); or vbetool (6)
 HP NX7000			??? (*)
 HP Pavilion ZD7000		vbetool post needed, need open-source nv driver for X
 HP Omnibook XE3	athlon version	none (1)
-HP Omnibook XE3GC w/S3 Savage/IX-MV  none (1)
+HP Omnibook XE3GC		none (1), video is S3 Savage/IX-MV
+IBM TP T20, model 2647-44G	none (1), video is S3 Inc. 86C270-294 Savage/IX-MV, vesafb gets "interesting" but X work.
 IBM TP A31 / Type 2652-M5G      s3_mode (3) [works ok with BIOS 1.04 2002-08-23, but not at all with BIOS 1.11 2004-11-05 :-(]
 IBM TP R32 / Type 2658-MMG      none (1)
 IBM TP R40 2722B3G		??? (*)
@@ -97,20 +102,22 @@
 IBM TP R51			??? (*)
 IBM TP T30	236681A		??? (*)
 IBM TP T40 / Type 2373-MU4      none (1)
-IBM TP T40p			??? (*)
-IBM TP T41p			none (1)
+IBM TP T40p			none (1)
+IBM TP R40p			s3_bios (2)
+IBM TP T41p			s3_bios (2), switch to X after resume
 IBM TP T42			??? (*)
 IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
 IBM TP X20			??? (*)
 IBM TP X30			??? (*)
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
-IBM TP X40			??? (*)
+IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)
 Medion MD4220			??? (*)
 Samsung P35			vbetool needed (6)
 Sharp PC-AR10 (ATI rage)	none (1)
 Sony Vaio PCG-F403		??? (*)
 Sony Vaio PCG-N505SN		??? (*)
 Sony Vaio vgn-s260		X or boot-radeon can init it (5)
+Toshiba Libretto L5		none (1)
 Toshiba Satellite 4030CDT	s3_mode (3)
 Toshiba Satellite 4080XCDT      s3_mode (3)
 Toshiba Satellite 4090XCDT      ??? (*)
@@ -121,14 +128,6 @@
 (*) from http://www.ubuntulinux.org/wiki/HoaryPMResults, not sure
     which options to use. If you know, please tell me.
 
-(**) Text console is "strange" after resume. Backlight is switched on again
-     by the X server. X server is:
-     | X Window System Version 6.8.1.904 (6.8.2 RC 4)
-     | Release Date: 2 February 2005
-     | X Protocol Version 11, Revision 0, Release 6.8.1.904
-     | Build Operating System: SuSE Linux [ELF] SuSE
-     as present in SUSE 9.3preview3.
-
 (***) To be tested with a newer kernel.
 
 (****) Not with SMP kernel, UP only.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
