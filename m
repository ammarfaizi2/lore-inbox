Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291742AbSBTKlr>; Wed, 20 Feb 2002 05:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291743AbSBTKlg>; Wed, 20 Feb 2002 05:41:36 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:32924 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S291742AbSBTKla>; Wed, 20 Feb 2002 05:41:30 -0500
Date: Wed, 20 Feb 2002 11:41:29 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-rcx: Dual P3 + VIA + APIC
Message-ID: <20020220104129.GP13774@os.inf.tu-dresden.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to boot a 2.4.18-rc1, 2.4.18-rc2-ac1 or 2.5.5pre1 on a dual P3
with a VIA chipset hangs (randomly) at the "=====" signs, sometimes the
screen is flickering:

CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.39 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1874.32 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3742.10 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
=====
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 937.5155 MHz.
..... host bus clock speed is 133.9307 MHz.
cpu: 0, clocks: 1339307, slice: 446435
CPU0<T0:1339296,T1:892848,D:13,S:446435,C:1339307>
cpu: 1, clocks: 1339307, slice: 446435
=====
CPU1<T0:1339504,T1:446480,D:14,S:446505,C:1339515>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init
=====

or it hangs after initialising the SCSI driver (sym), IDE, network etc.
seems ok:

...
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
=====

It never went further.


Booting with "noapic" works, as do UP 2.4 kernels and 2.2.20 SMP
kernels.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)





Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
