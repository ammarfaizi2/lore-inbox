Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCZKsQ>; Tue, 26 Mar 2002 05:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSCZKsH>; Tue, 26 Mar 2002 05:48:07 -0500
Received: from otto.colonization.com ([128.171.80.37]:40452 "EHLO
	otto.cfht.hawaii.edu") by vger.kernel.org with ESMTP
	id <S293632AbSCZKsD>; Tue, 26 Mar 2002 05:48:03 -0500
Date: Tue, 26 Mar 2002 00:48:00 -1000
From: Sidik Isani <lksi@cfht.hawaii.edu>
Message-Id: <200203261048.AAA12444@otto.cfht.hawaii.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Timer interrupt stopped (2.2.20, 2.4.x)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

  We've been seeing intermittent (~weekly) lock-ups with our PCs which
  never happened with the 2.2.16 kernel.  Today the console on one
  of them froze shortly after booting up to the text login (no X).
  But this particular time, it still accepts ssh connections, so
  is there anything I should check while it is in this state?
  /proc/interrupts shows one very interesting thing:

           CPU0
  0:      63444    IO-APIC-edge  timer       <-- Not incrementing anymore!
  1:          2    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          0    IO-APIC-edge  rtc
 12:        245    IO-APIC-edge  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:        858    IO-APIC-edge  ide0
 15:          7    IO-APIC-edge  ide1
 19:     110413   IO-APIC-level  usb-uhci, eth0
NMI:          0
ERR:          0

  Mouse and keyboard interrupts are also not incrementing, but the disk
  and network interrupts are.  The kernel seems happy (no errors logged.)

Linux version 2.2.20-smp #1 SMP Sun Mar 24 18:35:47 HST 2002
Built with:  gcc 2.7.2.3, binutils 2.11.90.0.8
Patches:     Vanilla tree plus DEVFS and RAID 0.90
Machine:     Dell Precision 210 Workstation
Motherboard: Dell, 440BX based (supports dual processors)
Processor:   Single P-III 500 MHz
PCI Cards:   Only an NVidia graphics card (but X was never started yet.)
Memory:      1GB ECC
Disks:       2x13GB Maxtor IDE's on hda,hdb

  The same thing happened before with a 2.4 kernel a few months ago.
  At that time the machine had 512MB of RAM.  If anything useful can
  be done to track down the problem while the machine is like this,
  please let me know and I'll try before rebooting tomorrow.

Thanks,

- Sidik
