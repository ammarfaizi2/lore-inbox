Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUEFU03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUEFU03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 16:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUEFU03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 16:26:29 -0400
Received: from outbound01.telus.net ([199.185.220.220]:61106 "EHLO
	priv-edtnes03-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S262910AbUEFU01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 16:26:27 -0400
Subject: hdc: lost interrupt ide-cd: cmd 0x3 timed out with 2.6.6-rc3-bk8
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083875341.4603.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 06 May 2004 14:29:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I recently built 2.6.6-rc3-bk8.  The boot process stalls with 
ide-cd: cmd 0x5a timed out
hdc: lost interrupt.
hdc: lost interrupt.
hdc: lost interrupt.
hdc: lost interrupt.
ide-cd: cmd 0x3 timed out
...
There are no problems booting 2.6.6-rc3-bk6.
My system: FC2-test3.
When booting from 2.6.6-rc3-bk6, I get the following:
(from cat /proc/ioports)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1080-109f : 0000:00:02.1
e000-e0ff : 0000:00:03.0
  e000-e0ff : sis900
e400-e41f : 0000:00:09.0
  e400-e41f : EMU10K1
e800-e807 : 0000:00:09.1
ec00-ec7f : 0000:00:0d.0
f000-f00f : 0000:00:02.5
  f000-f007 : ide0
  f008-f00f : ide1

from /proc/interrupts:
           CPU0
  0:    1580849          XT-PIC  timer
  1:       4012          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          6          XT-PIC  bttv0
  9:       9680          XT-PIC  acpi, EMU10K1, ohci1394
 10:     114470          XT-PIC  ohci_hcd, nvidia
 11:        562          XT-PIC  ohci_hcd, eth0
 12:      39542          XT-PIC  i8042
 14:      19181          XT-PIC  ide0
 15:      21677          XT-PIC  ide1
NMI:          0
LOC:    1580793
ERR:          0
MIS:          0

I didn't see anything in /Documentation.  Besides running FC2-t3
(updated with yum), I have /sys and /udev (hotplug from 2004_04_01 and
udev-025) installed.  On my system /dev/hdc is a Sony DVD drive, and is
not /boot or /.  
I can still boot 2.6.6-rc3-bk6 without problems.  Please email me for
more information as I'm not on the list.
TIA,
Bob

