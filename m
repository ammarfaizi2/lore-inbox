Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRGBJ0A>; Mon, 2 Jul 2001 05:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbRGBJZk>; Mon, 2 Jul 2001 05:25:40 -0400
Received: from mail18.bigmailbox.com ([209.132.220.49]:1807 "EHLO
	mail18.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S261274AbRGBJZ3>; Mon, 2 Jul 2001 05:25:29 -0400
Date: Mon, 2 Jul 2001 02:25:23 -0700
Message-Id: <200107020925.CAA13222@mail18.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [64.40.52.131]
From: "Colin Bayer" <colin_bayer@compnerd.net>
To: linux-kernel@vger.kernel.org
Subject: Sticky IO-APIC problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'K, here's the deal.

I have a Pentium III 933/133 (Coppermine, stepping 6) in an Intel-manufactured i810 motherboard (hey, I know it's a lame chipset, but it was on sale).  On boot, the kernel (version 2.4.6-pre8) identifies and maps the IO-APIC onboard, but does not assign any IRQs to it.

The relevant boot log snippet follows.

[root@fortytwo i386]# cat /var/log/dmesg
 ...
 ...
mapped APIC to ffffe000 (0121c000)
Kernel command line: auto BOOT_IMAGE=linux-test ro root=307 BOOT_FILE=/boot/vmlinuz-2.4.6-pre8 devfs=mount pirq=9,4
PIRQ redirection, working around broken MP-BIOS.
... PIRQ0 -> IRQ 9
... PIRQ1 -> IRQ 4
 ...
 ...

And /proc/interrupts:
[root@fortytwo i386]# cat /proc/interrupts
           CPU0
  0:      79409          XT-PIC  timer
  1:       5911          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:        990          XT-PIC  es1371
  8:          1          XT-PIC  rtc
  9:      26402          XT-PIC  usb-uhci, serial
 11:      16473          XT-PIC  i810@PCI:0:1:0
 14:       5152          XT-PIC  ide0
 15:         47          XT-PIC  ide1
NMI:          0
ERR:          0
MIS:          0
[root@fortytwo i386]# 

This problem also occurs when booting without the pirq switch. I've configured everything the way it's mentioned in Documentation/i386/IO-APIC.txt, but it doesn't help.  Anyway, thx in advance for the help.

     -- Colin

------------------------------------------------------------
The CompNerd Network: http://www.compnerd.com/
Where a nerd can be a nerd.  Get your free webmail@compnerd.net!
