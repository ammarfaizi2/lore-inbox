Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbUKDLjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUKDLjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUKDLil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:38:41 -0500
Received: from sd291.sivit.org ([194.146.225.122]:43225 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262173AbUKDLWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:22:24 -0500
Date: Thu, 4 Nov 2004 12:22:39 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sonypi: documentation fixes
Message-ID: <20041104112238.GS3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the latest round of updates for the sonypi driver, I fergot to
send the attached patch which fixes the driver documentation.

The patch contains mostly whitespace fixes and some additional
information regarding the input layer usage.

Please apply.

Thanks,

Stelian.

===================================================================

ChangeSet@1.2351, 2004-11-02 16:38:56+01:00, stelian@popies.net
  sonypi: documentation fixes (whitespace and input)
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 sonypi.txt |   51 +++++++++++++++++++++++++++------------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

===================================================================

diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	2004-11-04 11:37:15 +01:00
+++ b/Documentation/sonypi.txt	2004-11-04 11:37:15 +01:00
@@ -1,6 +1,6 @@
 Sony Programmable I/O Control Device Driver Readme
 --------------------------------------------------
-	Copyright (C) 2001-2003 Stelian Pop <stelian@popies.net>
+	Copyright (C) 2001-2004 Stelian Pop <stelian@popies.net>
 	Copyright (C) 2001-2002 Alcôve <www.alcove.com>
 	Copyright (C) 2001 Michael Ashley <m.ashley@unsw.edu.au>
 	Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
@@ -23,16 +23,18 @@
 
 Those events (see linux/sonypi.h) can be polled using the character device node
 /dev/sonypi (major 10, minor auto allocated or specified as a option).
-
 A simple daemon which translates the jogdial movements into mouse wheel events
 can be downloaded at: <http://popies.net/sonypi/>
 
+Another option to intercept the events is to get them directly through the
+input layer.
+
 This driver supports also some ioctl commands for setting the LCD screen
-brightness and querying the batteries charge information (some more 
+brightness and querying the batteries charge information (some more
 commands may be added in the future).
 
 This driver can also be used to set the camera controls on Picturebook series
-(brightness, contrast etc), and is used by the video4linux driver for the 
+(brightness, contrast etc), and is used by the video4linux driver for the
 Motion Eye camera.
 
 Please note that this driver was created by reverse engineering the Windows
@@ -47,7 +49,7 @@
 module or sonypi.<param>=<value> on the kernel boot line when sonypi is
 statically linked into the kernel). Those options are:
 
-	minor: 		minor number of the misc device /dev/sonypi, 
+	minor: 		minor number of the misc device /dev/sonypi,
 			default is -1 (automatic allocation, see /proc/misc
 			or kernel logs)
 
@@ -59,14 +61,14 @@
 			get enabled unless you set this parameter to 1.
 			Do not use this option unless it's actually necessary,
 			some Vaio models don't deal well with this option.
-			This option is available only if the kernel is 
+			This option is available only if the kernel is
 			compiled without ACPI support (since it conflicts
-			with it and it shouldn't be required anyway if 
+			with it and it shouldn't be required anyway if
 			ACPI is already enabled).
 
-	verbose:	set to 1 to print unknown events received from the 
+	verbose:	set to 1 to print unknown events received from the
 			sonypi device.
-			set to 2 to print all events received from the 
+			set to 2 to print all events received from the
 			sonypi device.
 
 	compat:		uses some compatibility code for enabling the sonypi
@@ -75,14 +77,15 @@
 			add this option and report to the author.
 
 	mask:		event mask telling the driver what events will be
-			reported to the user. This parameter is required for some 
-			Vaio models where the hardware reuses values used in 
-			other Vaio models (like the FX series who does not
-			have a jogdial but reuses the jogdial events for
+			reported to the user. This parameter is required for
+			some Vaio models where the hardware reuses values
+			used in other Vaio models (like the FX series who does
+			not have a jogdial but reuses the jogdial events for
 			programmable keys events). The default event mask is
-			set to 0xffffffff, meaning that all possible events will be
-			tried. You can use the following bits to construct
-			your own event mask (from drivers/char/sonypi.h):
+			set to 0xffffffff, meaning that all possible events
+			will be tried. You can use the following bits to
+			construct your own event mask (from
+			drivers/char/sonypi.h):
 				SONYPI_JOGGER_MASK 		0x0001
 				SONYPI_CAPTURE_MASK 		0x0002
 				SONYPI_FNKEY_MASK 		0x0004
@@ -97,10 +100,10 @@
 				SONYPI_MEMORYSTICK_MASK		0x0800
 				SONYPI_BATTERY_MASK		0x1000
 
-	useinput:	if set (which is the default) jogdial events are
-			forwarded to the input subsystem as mouse wheel
-			events.
-			
+	useinput:	if set (which is the default) two input devices are
+			created, one which interprets the jogdial events as
+			mouse events, the other one which acts like a
+			keyboard reporting the pressing of the special keys.
 
 Module use:
 -----------
@@ -123,17 +126,17 @@
 	  external monitor on/off. There is no workaround yet, since this
 	  driver disables all APM management for those keys, by enabling the
 	  ACPI management (and the ACPI core stuff is not complete yet). If
-	  you have one of those laptops with working Fn keys and want to 
+	  you have one of those laptops with working Fn keys and want to
 	  continue to use them, don't use this driver.
 
 	- some users reported that the laptop speed is lower (dhrystone
 	  tested) when using the driver with the fnkeyinit parameter. I cannot
 	  reproduce it on my laptop and not all users have this problem.
-	  This happens because the fnkeyinit parameter enables the ACPI 
-	  mode (but without additional ACPI control, like processor 
+	  This happens because the fnkeyinit parameter enables the ACPI
+	  mode (but without additional ACPI control, like processor
 	  speed handling etc). Use ACPI instead of APM if it works on your
 	  laptop.
-	
+
 	- since all development was done by reverse engineering, there is
 	  _absolutely no guarantee_ that this driver will not crash your
 	  laptop. Permanently.
-- 
Stelian Pop <stelian@popies.net>    
