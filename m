Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbTCGHdX>; Fri, 7 Mar 2003 02:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbTCGHdV>; Fri, 7 Mar 2003 02:33:21 -0500
Received: from isdn451.s.netic.de ([212.9.163.195]:9344 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S261415AbTCGHdQ>;
	Fri, 7 Mar 2003 02:33:16 -0500
Date: Fri, 07 Mar 2003 08:44:25 +0100 (MET)
Message-Id: <20030307.084425.41197714.mccramer@s.netic.de>
To: linux-kernel@vger.kernel.org
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <20030306132904.A838@flint.arm.linux.org.uk>
References: <20030306130340.GA453@zip.com.au>
	<20030306132904.A838@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org
Subject: 2.5.64p5 No USB support when APIC mode enabled
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I got some problems with USB (in my case the mouse).
 If I enable "APIC" in the BIOS of the motherboard,
 usb failed to "accept" my USB device.

 It constantly prints on the console (and log file):

 Mar  7 08:14:33 solfire kernel: usb_control/bulk_msg: timeout
 Mar  7 08:14:33 solfire kernel: usb.c: USB device not accepting new address=4 (error=-110)
 Mar  7 08:14:39 solfire kernel: usb_control/bulk_msg: timeout
 Mar  7 08:14:39 solfire kernel: usb.c: USB device not accepting new address=5 (error=-110)
 Mar  7 08:14:44 solfire kernel: usb_control/bulk_msg: timeout
 Mar  7 08:14:44 solfire kernel: usb.c: USB device not accepting new address=6 (error=-110)

 the address is constantly increased...printing does not stop, I hat
 to rmmod uhci for that.

 The mouse was not recognized.

 The failure seems to arise before  the mouse is recognized as such.

 I cannot decide, whether it is a problem of the motherboard or a
 linux kernel thingy...

 My system:
 Linux 2.4.21rc5
 EPoX 8K5A3+ (VIA KT333) motherboard
 Athlon XP 2400+
 DDR RAM 256 MB (Samsung)
 USB Mouse
 USB Cardreader

 I have enabled in the linux config:
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_UP_APIC=y
 CONFIG_X86_UP_IOAPIC=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
 CONFIG_APM=m
 CONFIG_APM_DO_ENABLE=y

 CONFIG_USB=m
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_UHCI=m
 CONFIG_USB_UHCI_ALT=m
 CONFIG_USB_OHCI=m
 CONFIG_USB_STORAGE=m
 CONFIG_USB_HID=m
 CONFIG_USB_KBD=m
 CONFIG_USB_MOUSE=m

 What did I wrong ?

 Any help would be very appreciated. Thank you very much in advance.

 Kind regards,
 Meino Cramer
