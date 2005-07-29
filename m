Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVG2QWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVG2QWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVG2QWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:22:07 -0400
Received: from L8R.net ([216.58.41.32]:57053 "EHLO l8r.net")
	by vger.kernel.org with ESMTP id S262640AbVG2QUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:20:22 -0400
Date: Fri, 29 Jul 2005 12:20:23 -0400
From: Brad Barnett <lists@L8R.net>
To: linux-kernel@vger.kernel.org
Subject: Acer Aspire 1691WCLi no boot problem
Message-ID: <20050729122023.45cb3031@be.back.l8r.net>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hey, 

I have a very odd problem with an Acer Aspire 1691WCLi.  This laptop will
simply not boot with any Debian precompiled kernel, with the exception of
Debian's 2.4.27-2 initrd kernel.  I have compiled my own kernels, using a
vast array of options, 2.6.11, 2.6.12, 2.6.12.3, 2.6.13-rc4 and 2.4.27,
they also all fail in exactly the same way.  I have tried with and without
initrd, acpi, 386 or other processor options, as well as very lean,
stripped down kernels.  I have tried with both lilo and grub, but both
result in the same hang.

Lilo or grub boots the kernel, and I see the classic:

boot: vmlinuz
Loading vmlinuz.................................................
BIOS data check successful
Uncompressiong Linux... Ok. booting the kernel.
_


That's it.  A screencap can be had here, although it does not tell much else:

http://be.back.l8r.net:8000/no_boot.jpg

Debian's 2.4.27-2 boots fine, and this is what really annoys me.  I took
Debian's 2.4.27-2 initrd config from /boot, ran make oldconfig on a fresh
2.4.27 tree (some minor options were different due to Debian's
backpatching).  This image _still_ would not boot.

Does anyone have any suggestions?  If needed, I could compile a few more
kernels, change GCC versions (if anyone thinks that would help) and so on.
 However, my goal here is to get 2.6 working in order to support various
bits of hardware on this laptop. 

There are very few bios options to change. :/

Pentium M 725, 512M ram.

LSPCI shows:

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
0000:00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML ExpressGraphics Controller (rev 03)
0000:00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04)
0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04)
0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 04)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04)
0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
0000:06:01.0 CardBus bridge: Texas Instruments Texas Instruments PCIxx21/x515 Cardbus Controller
0000:06:01.2 FireWire (IEEE 1394): Texas Instruments Texas Instruments OHCI Compliant IEEE 1394 Host Controller
0000:06:01.3 Unknown mass storage controller: Texas Instruments Texas Instruments PCIxx21Integrated FlashMedia Controller
0000:06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
0000:06:08.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigabit Ethernet(rev 03)
