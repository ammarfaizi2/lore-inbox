Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264328AbUDWKXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbUDWKXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264776AbUDWKXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:23:21 -0400
Received: from gprs214-93.eurotel.cz ([160.218.214.93]:21888 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264328AbUDWKXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:23:19 -0400
Date: Fri, 23 Apr 2004 12:23:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: stefandoesinger@gmx.at
Subject: Tips for S3 resume on radeon cards
Message-ID: <20040423102310.GA8358@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Stefan has pretty usefull tips for getting S3 to work on radeon
notebooks. This brings whole new class of systems to be usable for S3,
please apply.
								Pavel

--- clean/Documentation/power/video.txt	2004-02-05 01:53:53.000000000 +0100
+++ linux/Documentation/power/video.txt	2004-04-23 12:19:00.000000000 +0200
@@ -1,7 +1,7 @@
 
 		Video issues with S3 resume
 		~~~~~~~~~~~~~~~~~~~~~~~~~~~
-		     2003, Pavel Machek
+		  2003-2004, Pavel Machek
 
 During S3 resume, hardware needs to be reinitialized. For most
 devices, this is easy, and kernel driver knows how to do
@@ -15,7 +15,7 @@
 
 There are three types of systems where video works after S3 resume:
 
-* systems where video state is preserved over S3. (HP Omnibook xe3)
+* systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)
 
 * systems that initialize video card into vga text mode and where BIOS
   works well enough to be able to set video mode. Use
@@ -26,6 +26,10 @@
   point, but it happens to work on some machines. Use
   acpi_sleep=s3_bios (Athlon64 desktop system)
 
+* radeon systems, where X can soft-boot your video card. You'll need
+  patched X, and plain text console (no vesafb or radeonfb), see
+  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
+
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get hard crash during resume. Be carefull.
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
