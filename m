Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSK0O6Z>; Wed, 27 Nov 2002 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSK0O6Z>; Wed, 27 Nov 2002 09:58:25 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:53128 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S262875AbSK0O6S>; Wed, 27 Nov 2002 09:58:18 -0500
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Organization: INFN
To: "Jeff Nguyen" <jeff@aslab.com>
Subject: Re: e7500 and IRQ assignment
Date: Wed, 27 Nov 2002 16:06:11 +0100
User-Agent: KMail/1.5
References: <200211252021.52501.gabrielli@roma2.infn.it> <059c01c294bb$d1036110$6502a8c0@jeff>
In-Reply-To: <059c01c294bb$d1036110$6502a8c0@jeff>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-smp@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200211271606.11484.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:49, lunedì 25 novembre 2002, you wrote:
> You should try to disable ACPI in the kernel. That might fix the problem
> with the IRQ 0 assignment.
>

passed noacpi to kernel .. nothing changed

with aspi=force I had this:


[root@pn2 root]# cat /proc/interrupts
           CPU0       CPU1
  0:       1429      76989    IO-APIC-edge  timer
  1:          3          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 12:          0          0    IO-APIC-edge  PS/2 Mouse
 14:        597       1861    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
 17:         49        105   IO-APIC-level  eth0
NMI:          0          0
LOC:      78333      78332
ERR:          0
MIS:          0
[root@pn2 root]# lspci -vv -s 05:0c.0 -x -b
05:0c.0 Non-VGA unclassified device: Altera Corporation: Unknown device 0005 
(rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at fc300000 (32-bit, non-prefetchable)
00: 72 11 05 00 13 01 20 04 02 00 00 00 08 40 00 00
10: 00 00 30 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00

It seem the BIOS cannot succesfully write in the interrupt line register

just an opinion: is a problem of my own device or a MB bug ?!?!

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

