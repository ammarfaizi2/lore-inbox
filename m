Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUI0XFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUI0XFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUI0XFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:05:20 -0400
Received: from smtp06.auna.com ([62.81.186.16]:20450 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S267423AbUI0XFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:05:00 -0400
Date: Mon, 27 Sep 2004 23:04:59 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm4
To: linux-kernel@vger.kernel.org
References: <20040926181021.2e1b3fe4.akpm@osdl.org>
In-Reply-To: <20040926181021.2e1b3fe4.akpm@osdl.org> (from akpm@osdl.org on
	Mon Sep 27 03:10:21 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096326299l.5222l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.27, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/
> 

Just a small problem with usb:

irq 11: nobody cared!
 [<c0108474>] __report_bad_irq+0x24/0x90
 [<c01086e2>] note_interrupt+0x92/0x160
 [<c011970d>] finish_task_switch+0x3d/0x90
 [<c0108b22>] do_IRQ+0x162/0x1a0
 [<c010653c>] common_interrupt+0x18/0x20
 [<c0103ad0>] default_idle+0x0/0x40
 [<c0103afc>] default_idle+0x2c/0x40
 [<c0103b84>] cpu_idle+0x34/0x50
handlers:
[<c03329a0>] (usb_hcd_irq+0x0/0x70)
[<c03329a0>] (usb_hcd_irq+0x0/0x70)
[<c03329a0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #11

nada:/var/log# cat /proc/interrupts
           CPU0       CPU1       
  0:   27920320         24    IO-APIC-edge  timer
  1:         11          0    IO-APIC-edge  i8042
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:      19380      80620   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd
 12:        463          0    IO-APIC-edge  i8042
 14:       5984          0    IO-APIC-edge  ide2
 15:         14          0    IO-APIC-edge  ide3
169:    2636025          1   IO-APIC-level  libata
177:    3317638          0   IO-APIC-level  libata
185:    3453700          1   IO-APIC-level  eth0
NMI:          0          0 
LOC:   27923546   27923680 
ERR:          0
MIS:          0
nada:/var/log# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 933.139
...
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 933.139

nada:/var/log# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


