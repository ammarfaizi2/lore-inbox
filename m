Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTG2RIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271929AbTG2RIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:08:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9608 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271924AbTG2RH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:07:59 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2
Date: Tue, 29 Jul 2003 12:42:17 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307291242.17216.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.10.84] at Tue, 29 Jul 2003 11:42:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5,6,7,8th 9th (ad infinitum :) attempts to boot

After running make defconfig, I found it had turned on several scsi 
drivers I don't have cards for, all I have is an advansis abp-930.

I've tried to clean all that out so that only the sg, ide-scsi and the 
advansis drivers are enabled, but I've not been able to get it to 
boot to a login prompt again, its getting stuck in a loop reseting 
and then disabling the scsi bus.  I also do not think I've found the 
keyboard yet either, as there is no response on screen from it at any 
point in the boot attempt and the only recovery is with the hardware 
reset button.

The keyboard is a M$ (spit) Internet model, plugged into the ps2 port 
labeled kbd, and the mouse is a USB logitech optical wheel mouse.  
Both are working great for any 2.4.x boot in recent history.

here is a grep of .config for VT + '='
CONFIG_VT=y
CONFIG_VT_CONSOLE=y

Here is the grep of INPUT from .config containing an = sign:
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_USB_HIDINPUT=y
-------------
Here is the same for SCSI, also stripped of stuff lacking an = :
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_SCSI=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_ADVANSYS=y

----------------
And here is USB:
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_AUDIO=m
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_SCANNER=y
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_PL2303=y

And a repeat grep for FB (framebuffer) yielded nothing.

It never got far enough to dump the syslog, so there is no recording.

Ideas?  Do you need other info I can get from a 2.4.22-pre8 boot that 
works pretty good?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

