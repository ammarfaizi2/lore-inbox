Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVHPKK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVHPKK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVHPKK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:10:59 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:14584 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965188AbVHPKK7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:10:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X+9TfHTSgPKQDZ7p6OKUL6wgZqH8Z0sntngiMtMJqcY3kxyoYw39/5AMWFRRScjIUhMbPPtqcCcEuuAUTnIDrfaBRNcBDrGusVp8XsZqnYaqZ3pDzL3L5+PpRodqZxjMe3+qZhN+yZuGjS5/rOM48GbfoU1k188NglqADeLRmbo=
Message-ID: <5a2cf1f6050816031011590972@mail.gmail.com>
Date: Tue, 16 Aug 2005 12:10:54 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: Marie-Helene Lacoste <manies@tele2.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
AX 300 SE/t mainboard.

I remember seeing a message in the boot saying something along:

  "cannot connect to hardware clock."

And now I see that the time is changing too fast (about 2 seconds each second).

I don't have visual on the boot sequence anymore (only remote access).
Kernel earlier than 2.6.11 won't boot on the box (SATA chipset unsupported).

Some info below (probably irrelevant).

What should I try?

Linux manies 2.6.12.3 #1 Thu Jul 28 12:49:15 CEST 2005 x86_64 GNU/Linux

jerome@manies:~$ lspci
0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951
0000:00:02.0 PCI bridge: ATI Technologies Inc: Unknown device 5a34
0000:00:11.0 RAID bus controller: ATI Technologies Inc: Unknown device 437a
0000:00:12.0 RAID bus controller: ATI Technologies Inc: Unknown device 4379
0000:00:13.0 USB Controller: ATI Technologies Inc: Unknown device 4374
0000:00:13.1 USB Controller: ATI Technologies Inc: Unknown device 4375
0000:00:13.2 USB Controller: ATI Technologies Inc: Unknown device 4373
0000:00:14.0 SMBus: ATI Technologies Inc: Unknown device 4372 (rev 04)
0000:00:14.1 IDE interface: ATI Technologies Inc: Unknown device 4376
0000:00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377
0000:00:14.4 PCI bridge: ATI Technologies Inc: Unknown device 4371
0000:00:14.5 Multimedia audio controller: ATI Technologies Inc:
Unknown device 4370
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 5b60
0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 5b70
0000:02:05.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
0000:02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
0000:02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

jerome@manies:~$ cat /proc/interrupts 
           CPU0       
  0:   22456064    IO-APIC-edge  timer
  1:       6175    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          0    IO-APIC-edge  rtc
 12:     241004    IO-APIC-edge  i8042
 14:     201574    IO-APIC-edge  ide0
 16:         23   IO-APIC-level  bttv0
 17:     370224   IO-APIC-level  ATI IXP
 19:         33   IO-APIC-level  ohci_hcd:usb1, ohci_hcd:usb2, ehci_hcd:usb3
 20:     221385   IO-APIC-level  eth0
 21:          0   IO-APIC-level  acpi
 22:      65322   IO-APIC-level  libata
 23:          0   IO-APIC-level  libata
NMI:       9788 
LOC:   11226651 
ERR:         18
