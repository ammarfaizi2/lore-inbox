Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWGRQLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWGRQLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGRQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:11:38 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.81]:45226 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S1751353AbWGRQLi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:11:38 -0400
Message-ID: <44BD0834.9020708@geograph.co.za>
Date: Tue, 18 Jul 2006 18:11:32 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: PCI: Failed to allocate mem resource #6:20000@90000000 for 0000:01:00.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

xorg sent me to nVidia, nVidia sent me to Intel and all have told me 
"not my problem". Please can someone tell me where to take this issue to 
get it resolved.

mega-TIA,  (mega-desperate)
Zoltan.




Multiseat setup on "fully updated" Ubuntu 6.06 LTS Dapper.
HW is Intel 975XBX motherboard, 950D CPU, 2GB Memory and 3 * MSI 
NX7600GS PCIe VGA cards.
Latest BIOS from 20 June on the M/B
Power supply is 17A nominal on the 12v2 rail (500W P/S) (16A 
recommended, with 19A peak)

Symptom is seat-lockup but can get in with ssh to see that X is using 
100% CPU on all seats.
All seats do not always fire-up at boot time.
I've googled all over and none of these previous situations solves the 
problem.
I have also tried bootstrings (individually) pci=noacpi   pci=biosirq   
noapic   and acpi=off

Output from the following commands is posted below:
uname -a
cat /proc/cmdline
dmesg | grep ailed
lshw -C display
lspci


root@gl1:/home/zls# uname -a
Linux gl1 2.6.15-26-686 #1 SMP PREEMPT Fri Jul 7 19:48:22 UTC 2006 i686 
GNU/Linux
root@gl1:/home/zls#

root@gl1:/home/zls# cat /proc/cmdline
root=/dev/sda2 ro expert vmalloc=256M
root@gl1:/home/zls#

root@gl1:/home/zls# dmesg | grep ailed
[17179570.320000] PCI: Failed to allocate mem resource #6:20000@90000000 
for 0000:01:00.0
[17179570.320000] PCI: Failed to allocate mem resource #6:20000@a0000000 
for 0000:02:00.0
[17179570.320000] PCI: Failed to allocate mem resource #6:20000@b0000000 
for 0000:03:00.0


root@gl1:/home/zls# lshw -C display
  *-display
       description: VGA compatible controller
       product: nVidia Corporation
       vendor: nVidia Corporation
       physical id: 0
       bus info: pci@01:00.0
       version: a1
       size: 256MB
       width: 64 bits
       clock: 33MHz
       capabilities: vga bus_master cap_list
       configuration: driver=nvidia
       resources: iomemory:b5000000-b5ffffff iomemory:80000000-8fffffff 
iomemory:b4000000-b4ffffff ioport:5000-507f irq:169
  *-display
       description: VGA compatible controller
       product: nVidia Corporation
       vendor: nVidia Corporation
       physical id: 0
       bus info: pci@02:00.0
       version: a1
       size: 256MB
       width: 64 bits
       clock: 33MHz
       capabilities: vga bus_master cap_list
       configuration: driver=nvidia
       resources: iomemory:b3000000-b3ffffff iomemory:90000000-9fffffff 
iomemory:b2000000-b2ffffff ioport:4000-407f irq:169
  *-display
       description: VGA compatible controller
       product: nVidia Corporation
       vendor: nVidia Corporation
       physical id: 0
       bus info: pci@03:00.0
       version: a1
       size: 256MB
       width: 64 bits
       clock: 33MHz
       capabilities: vga bus_master cap_list
       configuration: driver=nvidia
       resources: iomemory:b1000000-b1ffffff iomemory:a0000000-afffffff 
iomemory:b0000000-b0ffffff ioport:3000-307f irq:169
root@gl1:/home/zls#


root@gl1:/home/zls# lspci
0000:00:00.0 Host bridge: Intel Corporation: Unknown device 277c
0000:00:01.0 PCI bridge: Intel Corporation: Unknown device 277d
0000:00:03.0 PCI bridge: Intel Corporation: Unknown device 277a
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01)
0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI 
Express Port 1 (rev 01)
0000:00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) 
PCI Express Port 5 (rev 01)
0000:00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) 
PCI Express Port 6 (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB 
UHCI #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB 
UHCI #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB 
UHCI #3 (rev 01)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB 
UHCI #4 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GH (ICH7DH) LPC 
Interface Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
Controller (rev 01)
0000:00:1f.2 0106: Intel Corporation 82801GR/GH (ICH7 Family) Serial ATA 
Storage Controllers cc=AHCI (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus 
Controller (rev 01)
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0392 (rev a1)
0000:02:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0392 (rev a1)
0000:03:00.0 VGA compatible controller: nVidia Corporation: Unknown 
device 0392 (rev a1)
0000:05:00.0 Ethernet controller: Intel Corporation 82573L Gigabit 
Ethernet Controller
0000:06:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M 
[Tornado] (rev 74)
0000:06:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
IEEE-1394a-2000 Controller (PHY/Link)
0000:06:05.0 RAID bus controller: Silicon Image, Inc. SiI 3114 
[SATALink/SATARaid] Serial ATA Controller (rev 02)
root@gl1:/home/zls#




