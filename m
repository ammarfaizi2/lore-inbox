Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTBFRmp>; Thu, 6 Feb 2003 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTBFRmp>; Thu, 6 Feb 2003 12:42:45 -0500
Received: from ns.suse.de ([213.95.15.193]:58384 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267370AbTBFRmo>;
	Thu, 6 Feb 2003 12:42:44 -0500
Date: Thu, 6 Feb 2003 18:52:21 +0100
From: Olaf Hering <olh@suse.de>
To: bjorn@haxx.se, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21pre: ide_fix_driveid unresolved in usb-storage
Message-ID: <20030206175221.GA3072@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

drivers/usb/storage/isd200.c calls ide_fix_driveid()
This function is only available when CONFIG_IDE is active.


--- linux-2.4/drivers/usb/Config.in.olh	2003-02-06 18:43:48.000000000 +0100
+++ linux-2.4/drivers/usb/Config.in	2003-02-06 18:44:08.000000000 +0100
@@ -46,7 +46,7 @@ if [ "$CONFIG_USB" = "y" -o  "$CONFIG_US
       dep_mbool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG $CONFIG_USB_STORAGE
       dep_mbool '    Datafab MDCFE-B Compact Flash Reader support' CONFIG_USB_STORAGE_DATAFAB $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM  $CONFIG_USB_STORAGE
-      dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE
+      dep_mbool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200 $CONFIG_USB_STORAGE $CONFIG_IDE
       dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
       dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL

-- 
A: No.
Q: Should I include quotations after my reply?
