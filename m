Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJQRcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJQRcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWJQRcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:32:36 -0400
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:52104 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S1751351AbWJQRcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:32:35 -0400
Message-Id: <200610171732.k9HHWZdF020439@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.18 will not boot on Intel D954nt motherboard.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Oct 2006 11:32:35 -0600
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.11 is the last release that will boot on my Intel D945Gnt
motherboard (Pentium 4) with a Nvidia Video Card and a generic ethernet
card.

Up thru 2.6.16 The boot completed (with errors) but you could not get
to the ethernet card.

With 2.6.18 the boot totally fails (see below)
HOPEFULLY this more serious failure mode will lead to a fix to this problem.
As noted, everything is fine up thru 2.6.11 ...

---

Boot output with Intel's most recent BIOS for the D945Gnt, NT3996.iso, dated 
11sep2006
and 2.6.18 with NO CHANGES the boot output (hand copied) is:

---

  Booting 'Fedora Core (2.6.18)'

root(hd1,5)
 File system type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-2.6.18 ro root=/dev/sda6 rhgb quiet
   [Linux-bzImage, setup=0x1e00, size=0x196a84]
initrd /boot/initrd-2.6.18.img
   [linux-initrd @ 0x37eba000, 0x135a1c bytes]

Uncompressing Linux... OK, booting the kernel.
PCI: BIOS Bug: MCFG area at f0000000 is not e820-reserved
PCI: Not using MMCONFIG.
PCI: Cannot allocate resource region 1 of device 0000:05:01.0
PCI: Cannot allocate resource region 2 of device 0000:05:01.0
PCI: Failed to allocate mem resource #6:20000@48000000 for 0000:01:00.0
APCI: getting cpu index for apciid 0x3
APCI: getting cpu index for apciid 0x4
RedHat nash version 4.2.15 starting
Bug: soft lockup detected on CPU#0!

  <hang>

---

This is in bugzilla as Bug 6209 with more details.


-- 
                                        Reg.Clemens
                                        reg@dwf.com


