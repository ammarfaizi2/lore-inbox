Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbUDFLMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUDFLH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:07:58 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:7691 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263764AbUDFLE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:04:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Date: Tue, 6 Apr 2004 13:03:30 +0200
User-Agent: KMail/1.6.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Bill Davidsen <davidsen@tmr.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <20040406094258.A15945@flint.arm.linux.org.uk> <200404061246.53847@WOLK>
In-Reply-To: <200404061246.53847@WOLK>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_C6ocAIyyyhDhtC8"
Message-Id: <200404061303.30828@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_C6ocAIyyyhDhtC8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 06 April 2004 12:46, Marc-Christian Petersen wrote:

Hi again,

> 02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch
> 	Fix SCSI dependency for USB-Storage support.
> 	- Rip out "select SCSI"
> 	- Make a comment when SCSI is not selected

grmpf, change !SCSI to SCSI=n. Again attached.

ciao, Marc

--Boundary-00=_C6ocAIyyyhDhtC8
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="02_menu-Kconfig-cleanups-09-USB-vs-SCSI-fix.patch"

diff -Naurp linux-2.6.4-wolk2.4-fullkernel/drivers/usb/storage/Kconfig linux-2.6.4-wolk2.4-USB-stuff/drivers/usb/storage/Kconfig
--- linux-2.6.4-wolk2.4-fullkernel/drivers/usb/storage/Kconfig	2004-04-05 17:10:21.000000000 +0200
+++ linux-2.6.4-wolk2.4-USB-stuff/drivers/usb/storage/Kconfig	2004-04-06 12:30:55.000000000 +0200
@@ -2,10 +2,9 @@
 # USB Storage driver configuration
 #
 
-config USB_STORAGE
+menuconfig USB_STORAGE
 	tristate "USB Mass Storage support"
-	depends on USB
-	select SCSI
+	depends on USB && SCSI
 	---help---
 	  Say Y here if you want to connect USB mass storage devices to your
 	  computer's USB port. This is the driver you need for USB floppy drives,
@@ -89,3 +88,5 @@ config USB_STORAGE_JUMPSHOT
 	  Say Y here to include additional code to support the Lexar Jumpshot
 	  USB CompactFlash reader.
 
+comment "SCSI support is needed for USB Storage support"
+	depends on USB && SCSI=n

--Boundary-00=_C6ocAIyyyhDhtC8--
