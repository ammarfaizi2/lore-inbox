Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWIYUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWIYUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIYUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:30:56 -0400
Received: from farmequipmentauctions.com ([128.242.232.222]:37637 "EHLO
	verio.liveglobalbid.com") by vger.kernel.org with ESMTP
	id S1751137AbWIYUaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:30:55 -0400
Message-ID: <45183C7E.6050408@liveglobalbid.com>
Date: Mon, 25 Sep 2006 14:30:54 -0600
From: Roe Peterson <roe@liveglobalbid.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sound, RS-232 serial fails on dell latitute D620 notebook...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is probably a Dell problem, but I'm hoping someone on the list has
seen similar behavior before.

Sound input and RS232 serial input do not function on a Dell Latitude D620.

Details:
- Fedora Core 5 installation, running vanilla kernel.org 2.6.16.16 and 
2.6.18, results
      are identical.  Sound input times out with an I/O error, no serial 
input characters are
      ever seen.  I've tried with and without acpi, apic, and irqpoll, 
and see no different results.

- lspci:
00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile Integrated 
Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile Integrated Graphics 
Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 3 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface 
Bridge (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) 
Serial ATA Storage Controllers cc=IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller 
(rev 01)
03:01.0 CardBus bridge: O2 Micro, Inc. OZ601/6912/711E0 
CardBus/SmartCardBus Controller (rev 40)
09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5752 
Gigabit Ethernet PCI Express (rev 02)

-# cat /proc/interrupts
           CPU0       CPU1
  0:     122071     115893    IO-APIC-edge  timer
  1:        279        303    IO-APIC-edge  i8042
  4:         11          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          3   IO-APIC-level  acpi
 12:       1945       2177    IO-APIC-edge  i8042
 14:       5400       1996    IO-APIC-edge  libata
 15:       4172       4023    IO-APIC-edge  ide1
 17:       1427          0   IO-APIC-level  yenta, eth0
 19:        207          0   IO-APIC-level  uhci_hcd:usb1, ehci_hcd:usb5
 20:       4247       4295   IO-APIC-level  uhci_hcd:usb2, HDA Intel
 21:       1238        957   IO-APIC-level  uhci_hcd:usb3
 22:          0          0   IO-APIC-level  uhci_hcd:usb4
NMI:          0          0
LOC:     237898     237897
ERR:          0
MIS:          0


Can anyone point me in some general direction?  I have no problem 
hacking around in
kernel source, but a good start never hurts :-)

Thanks for any assistance.


