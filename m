Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTADOrk>; Sat, 4 Jan 2003 09:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTADOrk>; Sat, 4 Jan 2003 09:47:40 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:53477 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S266941AbTADOrj>; Sat, 4 Jan 2003 09:47:39 -0500
Date: Sat, 4 Jan 2003 15:56:04 +0100 (CET)
From: Thomas Speck <Thomas.Speck@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic in 2.4.20-rc2
Message-ID: <Pine.LNX.4.21.0301041544310.1106-100000@ThS-home.dyns.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
from time to time (frequency a couple of weeks) I get the following: 

Jan  4 15:32:19 ThS-home kernel: CPU 0: Machine Check 
Exception: 0000000000000004
Jan  4 15:32:19 ThS-home kernel: Bank 1: f200000000000115
Jan  4 15:32:19 ThS-home kernel: Kernel panic: CPU context corrupt

Is that a hardware problem ? 

ThS-home:[~]# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 300.686
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
mmx
bogomips        : 599.65


ThS-home:[~]# lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 02)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 Ethernet controller: Digital Equipment Corporation DECchip 21041
[Tulip Pass 3] (rev 11)
00:0a.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee
(rev 03)

ThS-home:[~]# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-13feffff : System RAM
  00100000-0020f743 : Kernel code
  0020f744-00282a63 : Kernel data
13ff0000-13ff2fff : ACPI Non-volatile Storage
13ff3000-13ffffff : ACPI Tables
d8000000-dbffffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
dc000000-dfffffff : PCI Bus #01
  dc000000-ddffffff : 3Dfx Interactive, Inc. Voodoo Banshee
e0000000-e1ffffff : PCI Bus #01
  e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
e3000000-e300007f : Digital Equipment Corporation DECchip 21041 [Tulip
Pass 3]
  e3000000-e300007f : tulip
e3001000-e3001fff : Brooktree Corporation Bt848 Video Capture
ffff0000-ffffffff : reserved


Thank you 
--
Thomas

