Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310139AbSDAGRO>; Mon, 1 Apr 2002 01:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310182AbSDAGRE>; Mon, 1 Apr 2002 01:17:04 -0500
Received: from erasure.jasnik.net ([207.148.204.33]:24755 "HELO
	erasure.jasnik.net") by vger.kernel.org with SMTP
	id <S310139AbSDAGQt>; Mon, 1 Apr 2002 01:16:49 -0500
Subject: ECC memory and SMP lockups on Gateway 6400 server
From: Jason Czerak <Jason-Czerak@Jasnik.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-e73pcMPhVezNFv0EItaN"
X-Mailer: Evolution/1.0.2 
Date: 01 Apr 2002 01:16:46 -0500
Message-Id: <1017641806.17921.35.camel@neworder>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e73pcMPhVezNFv0EItaN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello.

I'll start with the ECC memory problem.... 

Recently got the goahead to upgrade the Gateway Win2K server to a linux
box to replace out old webserver. It's a 6400 server. 2 PIII-733's, 704
megs ECC registered ram.. NT ran fine on this box. not a hitch.

Going to install Suse 7.3 on it and ran into some slowness problems.
Once the kernel was booted and the install programs were running thigns
slowed to a crawl. After an hour of messing around. I started to pull
memory and CPU's out. Turns out the 512meg DIMM ECC ram was the cause of
the slowness problem.  No error messages no nothing. looks like the ECC
was doing it's thing. But created a CPU useage of 100% all the time...
Is there a kernel switch I can flip to make it place nice with broken
ECC ram? or is this ram just worthless?


Now the real issue.  I searched all over google and this mailing list to
see if I'm the only one. But looks like I am. Infact, I seen nothing but
priase for this box with linux running on it.  


In a non-SMP kernel this machien runs perfectly. Not a hitch.. When
booted with an SMP kernel. Once the load hits 1.4, the machine locks up
like a rock. I have to hit the reset button.  I turned off MP 1.4 spec,
all power management is turned off any goodies in bios are off. I even
upgraded the BIOS to the latest version. No luck. I been suggested to
try the 2.2 kernel, but since the root partition is reiserfs and
namesys.com has been down all weekend. I'm not able to get a 2.2 kernel
running with reiserfs support.. I'll try 2.2.20 as soon as I can DL the
resierfs patch.

I have attached the dmesg for this box. Any suggestions or patches or
anything I'll try. 


Also I would like to note that the second CPU is the exact same stepping
and speed. But was installed well after the machine was purchased.  


--
Jason Czerak


--=-e73pcMPhVezNFv0EItaN
Content-Disposition: attachment; filename=moby.boot.msg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Inspecting /boot/System.map-2.4.18
Loaded 14295 symbols from /boot/System.map-2.4.18.
Symbols match kernel version 2.4.18.
No module symbols loaded.
klogd 1.4.1, log source =3D ksyslog started.
<4>Linux version 2.4.18 (root@Moby) (gcc version 2.95.3 20010315 (SuSE)) #1=
 SMP Sat Mar 30 20:12:07 EST 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
<4> BIOS-e820: 000000000bff0000 - 000000000bfff000 (ACPI data)
<4> BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<4>found SMP MP-table at 000ff780
<4>hm, page 000ff000 reserved twice.
<4>hm, page 00100000 reserved twice.
<4>hm, page 000f1000 reserved twice.
<4>hm, page 000f2000 reserved twice.
<4>On node 0 totalpages: 49136
<4>zone(0): 4096 pages.
<4>zone(1): 45040 pages.
<4>zone(2): 0 pages.
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.
<4>OEM ID: AMI      Product ID: CNB30LE      APIC at: 0xFEE00000
<4>Processor #0 Pentium(tm) Pro APIC version 17
<4>Processor #1 Pentium(tm) Pro APIC version 17
<4>I/O APIC #4 Version 17 at 0xFEC00000.
<4>I/O APIC #5 Version 17 at 0xFEC01000.
<4>Processors: 2
<4>Kernel command line: auto BOOT_IMAGE=3DLinux-2.4.18 ro root=3D802 BOOT_F=
ILE=3D/boot/kernel-2.4.18
<6>Initializing CPU#0
<4>Detected 733.377 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1464.72 BogoMIPS
<4>Memory: 191132k/196544k available (1030k kernel code, 5024k reserved, 29=
8k data, 216k init, 0k highmem)
<4>Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
<4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor =3D 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
<5>CPU serial number disabled.
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383fbff 00000000 00000000 00000000
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<7>CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383fbff 00000000 00000000 00000000
<4>CPU0: Intel Pentium III (Coppermine) stepping 03
<4>per-CPU timeslice cutoff: 731.61 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000004
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/1 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 1464.72 BogoMIPS
<7>CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor =3D 0
<6>CPU: L1 I cache: 16K, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
<5>CPU serial number disabled.
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0383fbff 00000000 00000000 00000000
<4>CPU1: Intel Pentium III (Coppermine) stepping 03
<6>Total of 2 processors activated (2929.45 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<4>Setting 4 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 4 ... ok.
<4>Setting 5 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 5 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 5-0, 5-1, 5-2, 5-3, 5-5, 5-6,=
 5-7, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
<6>..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
<3>..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>...trying to set up timer (IRQ0) through the 8259A ...=20
<4>..... (found pin 0) ...works.
<7>number of MP IRQ sources: 16.
<7>number of IO-APIC #4 registers: 16.
<7>number of IO-APIC #5 registers: 16.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #4......
<7>.... register #00: 04000000
<7>.......    : physical APIC id: 04
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
<7> 00 003 03  0    0    0   0   0    1    1    31
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 003 03  0    0    0   0   0    1    1    41
<7> 04 003 03  0    0    0   0   0    1    1    49
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 003 03  0    0    0   0   0    1    1    51
<7> 07 003 03  0    0    0   0   0    1    1    59
<7> 08 003 03  0    0    0   0   0    1    1    61
<7> 09 000 00  1    0    0   0   0    0    0    00
<7> 0a 003 03  1    1    0   1   0    1    1    69
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 003 03  0    0    0   0   0    1    1    71
<7> 0d 003 03  0    0    0   0   0    1    1    79
<7> 0e 003 03  0    0    0   0   0    1    1    81
<7> 0f 003 03  0    0    0   0   0    1    1    89
<4>
<7>IO APIC #5......
<7>.... register #00: 05000000
<7>.......    : physical APIC id: 05
<7>.... register #01: 000F0011
<7>.......     : max redirection entries: 000F
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 01000000
<7>.......     : arbitration: 01
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 000 00  1    0    0   0   0    0    0    00
<7> 02 000 00  1    0    0   0   0    0    0    00
<7> 03 000 00  1    0    0   0   0    0    0    00
<7> 04 003 03  1    1    0   1   0    1    1    91
<7> 05 000 00  1    0    0   0   0    0    0    00
<7> 06 000 00  1    0    0   0   0    0    0    00
<7> 07 000 00  1    0    0   0   0    0    0    00
<7> 08 003 03  1    1    0   1   0    1    1    99
<7> 09 003 03  1    1    0   1   0    1    1    A1
<7> 0a 000 00  1    0    0   0   0    0    0    00
<7> 0b 000 00  1    0    0   0   0    0    0    00
<7> 0c 000 00  1    0    0   0   0    0    0    00
<7> 0d 000 00  1    0    0   0   0    0    0    00
<7> 0e 000 00  1    0    0   0   0    0    0    00
<7> 0f 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ10 -> 0:10
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ20 -> 1:4
<7>IRQ24 -> 1:8
<7>IRQ25 -> 1:9
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 733.3550 MHz.
<4>..... host bus clock speed is 133.3369 MHz.
<4>cpu: 0, clocks: 1333369, slice: 444456
<4>CPU0<T0:1333360,T1:888896,D:8,S:444456,C:1333369>
<4>cpu: 1, clocks: 1333369, slice: 444456
<4>CPU1<T0:1333360,T1:444448,D:0,S:444456,C:1333369>
<4>checking TSC synchronization across CPUs: passed.
<4>Waiting on wait_init_idle (map =3D 0x2)
<4>All processors have done init_idle
<4>PCI: PCI BIOS revision 2.10 entry at 0xfdbb1, last bus=3D1
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<6>PCI: Discovered primary peer bus 01 [IRQ]
<6>PCI: Using IRQ router default [1166/0009] at 00:00.0
<6>PCI->APIC IRQ transform: (B0,I2,P0) -> 20
<6>PCI->APIC IRQ transform: (B0,I15,P0) -> 10
<6>PCI->APIC IRQ transform: (B1,I5,P0) -> 24
<6>PCI->APIC IRQ transform: (B1,I5,P1) -> 25
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<6>Detected PS/2 Mouse Port.
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIA=
L_PCI enabled
<6>ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
<4>block: 128 slots per queue, batch=3D32
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a National Semiconductor PC87306
<4>eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/e=
epro100.html
<4>eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin=
 <saw@saw.sw.com.sg> and others
<6>eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:18:02:0C:98, IRQ 20.
<6>  Receiver lock-up bug exists -- enabling work-around.
<6>  Board assembly 668081-002, Physical connectors present: RJ45
<6>  Primary interface chip i82555 PHY #1.
<6>  General self-test: passed.
<6>  Serial sub-system self-test: passed.
<6>  Internal registers self-test: passed.
<6>  ROM checksum self-test: passed (0x04f4518b).
<6>  Receiver lock-up workaround activated.
<6>SCSI subsystem driver Revision: 1.00
<6>sym53c8xx: at PCI bus 1, device 5, function 1
<4>sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
<6>sym53c8xx: 53c1010-33 detected with Symbios NVRAM
<6>sym53c8xx: at PCI bus 1, device 5, function 0
<4>sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
<6>sym53c8xx: 53c1010-33 detected with Symbios NVRAM
<6>sym53c1010-33-0: rev 0x1 on pci bus 1 device 5 function 1 irq 25
<6>sym53c1010-33-0: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
<6>sym53c1010-33-0: on-chip RAM at 0xfebfc000
<6>sym53c1010-33-0: restart (scsi reset).
<6>sym53c1010-33-0: handling phase mismatch from SCRIPTS.
<4>sym53c1010-33-0: Downloading SCSI SCRIPTS.
<6>sym53c1010-33-1: rev 0x1 on pci bus 1 device 5 function 0 irq 24
<6>sym53c1010-33-1: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
<6>sym53c1010-33-1: on-chip RAM at 0xfebfa000
<6>sym53c1010-33-1: restart (scsi reset).
<6>sym53c1010-33-1: handling phase mismatch from SCRIPTS.
<4>sym53c1010-33-1: Downloading SCSI SCRIPTS.
<6>scsi0 : sym53c8xx-1.7.3c-20010512
<6>scsi1 : sym53c8xx-1.7.3c-20010512
<4>  Vendor: IBM       Model: DPSS-309170N      Rev: S80D
<4>  Type:   Direct-Access                      ANSI SCSI revision: 03
<6>sym53c1010-33-0-<0,0>: tagged command queue depth set to 4
<4>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
<6>sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
<4>SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
<6>Partition check:
<6> sda: sda1 sda2 sda3
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
<4>IP: routing cache hash table of 1024 buckets, 8Kbytes
<4>TCP: Hash tables configured (established 16384 bind 16384)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>reiserfs: checking transaction log (device 08:02) ...
<4>Warning, log replay starting on readonly filesystem
<4>reiserfs: replayed 19 transactions in 6 seconds
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<4>Freeing unused kernel memory: 216k freed
<6>Adding Swap: 281128k swap-space (priority -1)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

--=-e73pcMPhVezNFv0EItaN--

