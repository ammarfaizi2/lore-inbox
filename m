Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVLKMzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVLKMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVLKMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:55:09 -0500
Received: from host-87-74-42-126.bulldogdsl.com ([87.74.42.126]:39142 "EHLO
	shell.skyblue.eu.org") by vger.kernel.org with ESMTP
	id S1751356AbVLKMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:55:07 -0500
X-Antivirus-SKYBLUE-Mail-From: brent@skyblue.eu.org via shell
X-Antivirus-SKYBLUE: 1.25-st-qms (Clear:RC:1(172.21.1.101):. Processed in 0.092737 secs Process 30096)
From: "Brent" <brent@skyblue.eu.org>
To: "'Willy Tarreau'" <willy@w.ods.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: High load since upgrade
Date: Sun, 11 Dec 2005 12:54:45 -0000
Message-ID: <000001c5fe52$10411040$3128fea9@mforma.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcX9EmoGIJQEW7T5SiqDDpeuvKsyHQBPg2pg
In-Reply-To: <20051209214417.GE15993@alpha.home.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost everything is statically compiled apart from a few things that I
didn't feel like rebooting for.
I also put up the .config at http://pics.skyblue.eu.org/graphs/config.txt if
you want to check that out as well.

lon-gw:/var/log# lsmod
Module                  Size  Used by
8250                   27380  0 
serial_core            25984  1 8250
lon-gw:/var/log# 


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1584  516 ?        S    Dec09   0:01 init [2]  
root         2  0.0  0.0     0    0 ?        S    Dec09   0:06 [migration/0]
root         3  0.0  0.0     0    0 ?        SN   Dec09   0:00 [ksoftirqd/0]
root         4  0.0  0.0     0    0 ?        S    Dec09   0:06 [migration/1]
root         5  0.0  0.0     0    0 ?        SN   Dec09   0:00 [ksoftirqd/1]
root         6  0.0  0.0     0    0 ?        S<   Dec09   0:00 [events/0]
root         7  0.0  0.0     0    0 ?        S<   Dec09   0:00 [events/1]
root         8  0.0  0.0     0    0 ?        S<   Dec09   0:00 [khelper]
root         9  0.0  0.0     0    0 ?        S<   Dec09   0:00 [kthread]
root        12  0.0  0.0     0    0 ?        S<   Dec09   0:00 [kacpid]
root        78  0.0  0.0     0    0 ?        S<   Dec09   0:00 [kblockd/0]
root        79  0.0  0.0     0    0 ?        S<   Dec09   0:00 [kblockd/1]
root        82  0.0  0.0     0    0 ?        S<   Dec09   0:00 [khubd]
root       183  0.0  0.0     0    0 ?        S    Dec09   0:00 [pdflush]
root       184  0.0  0.0     0    0 ?        S    Dec09   0:00 [pdflush]
root       186  0.0  0.0     0    0 ?        S<   Dec09   0:00 [aio/0]
root       185  0.0  0.0     0    0 ?        S    Dec09   0:00 [kswapd0]
root       187  0.0  0.0     0    0 ?        S<   Dec09   0:00 [aio/1]
root       771  0.0  0.0     0    0 ?        S<   Dec09   0:00 [kseriod]
root       848  0.0  0.0     0    0 ?        S<   Dec09   0:00 [scsi_eh_0]
root       881  0.0  0.0     0    0 ?        S<   Dec09   0:00 [scsi_eh_1]
root       915  0.0  0.0     0    0 ?        S<   Dec09   0:00 [scsi_eh_2]
root       961  0.0  0.0     0    0 ?        D    Dec09   0:00
[firmware/dell_r]
root       964  0.0  0.0     0    0 ?        S    Dec09   0:00 [kirqd]
root       966  0.0  0.0     0    0 ?        S    Dec09   0:00 [kjournald]
root      1259  0.0  0.0     0    0 ?        S    Dec09   0:00 [kjournald]
root      1260  0.0  0.0     0    0 ?        S    Dec09   0:00 [kjournald]
root      1261  0.0  0.0     0    0 ?        S    Dec09   0:00 [kjournald]
root      1262  0.0  0.0     0    0 ?        S    Dec09   0:02 [kjournald]
root      1263  0.0  0.0     0    0 ?        S    Dec09   0:00 [kjournald]
nobody    1963  0.0  0.1  3660 1176 ?        Ss   Dec09   1:05
/usr/sbin/openvpn --writepid /var/run/openvpn.lonoffice-lonrack.pid --daemon
ovpn-lonoffice-lonrack --status /var/run/openvpn.lonoffice-lonrack.status 10
--cd /etc/openvpn --config /etc/openvpn/lonoffice-lonrack.conf
root      6120  0.0  0.0  2332  772 ?        Ss   Dec09   0:05 /sbin/syslogd
root      6123  0.0  0.1  2616 1460 ?        Ss   Dec09   0:00 /sbin/klogd
root      6131  0.0  0.5 41060 5436 ?        Ss   Dec09   0:09
/usr/sbin/named -c /etc/bind/internal/named.conf
root      6133  0.0  0.2 38736 3088 ?        Ss   Dec09   0:00
/usr/sbin/named -c /etc/bind/external/named.conf
root      6135  0.0  0.3 39328 3400 ?        Ss   Dec09   0:01
/usr/sbin/named -c /etc/bind/wifivpn/named.conf
root      6183  0.0  2.0 24128 21052 ?       Ss   Dec09   0:00
/usr/sbin/spamd -m 10 -d --pidfile=/var/run/spamd.pid
root      6191  0.0  2.1 25172 21732 ?       S    Dec09   0:01 spamd child
root      6192  0.0  2.0 24832 21340 ?       S    Dec09   0:00 spamd child
root      6193  0.0  2.0 24948 21468 ?       S    Dec09   0:01 spamd child
root      6194  0.0  2.0 25056 21556 ?       S    Dec09   0:01 spamd child
root      6195  0.0  2.0 24836 21328 ?       S    Dec09   0:00 spamd child
root      6196  0.0  2.1 26040 22580 ?       S    Dec09   0:02 spamd child
root      6197  0.0  2.1 25168 21724 ?       S    Dec09   0:01 spamd child
root      6198  0.0  2.1 26044 22588 ?       S    Dec09   0:02 spamd child
root      6199  0.0  2.0 25012 21484 ?       S    Dec09   0:00 spamd child
root      6200  0.0  2.1 25616 22124 ?       S    Dec09   0:01 spamd child
clamav    6201  0.0  1.7 29184 17812 ?       Ss   Dec09   0:06
/usr/sbin/clamd
clamav    6242  0.0  0.1  4180 1192 ?        Ss   Dec09   0:00
/usr/bin/freshclam -d --quiet -p /var/run/clamav/freshclam.pid
root      6287  0.0  0.0  2460  640 ?        Ss   Dec09   0:00
/usr/sbin/dhcpd -q
Debian-   6430  0.0  0.1  8488 1340 ?        Ss   Dec09   0:00
/usr/sbin/exim4 -bd -q30m
root      6442  0.0  0.0  2316  660 ?        Ss   Dec09   0:00
/usr/sbin/inetd
ntop      6447  0.2  3.5 108128 36556 ?      Ss   Dec09   7:38
/usr/sbin/ntop -d -L -u ntop -P /var/lib/ntop --skip-version-check -a
/var/log/ntop/access.log -i eth0,eth1 -n -O /var/log/ntop/
nobody    6454  0.0  0.1  3376 1472 ?        S    Dec09   0:00
perdition.pop3s                                       
nobody    6457  0.0  0.1  3380 1484 ?        S    Dec09   0:00
perdition.imaps                                       
root      6460  0.0  0.0  2436  720 ?        Ss   Dec09   0:00
/usr/sbin/pptpd
root      6481  0.0  0.3  6468 3696 ?        S    Dec09   0:21
/usr/sbin/snmpd -Lsd -Lf /dev/null -p /var/run/snmpd.pid
root      6487  0.0  0.0  3544 1032 ?        Ss   Dec09   0:08
/usr/sbin/sshd
root      6496  0.0  0.3  4024 4024 ?        SLs  Dec09   0:00
/usr/sbin/ntpd -p /var/run/ntpd.pid
root      6521  0.0  0.0  4240  608 ?        Ss   Dec09   0:00
/usr/sbin/squid -D -sYC
proxy     6523  0.0  1.6 18952 16644 ?       S    Dec09   0:29 (squid) -D
-sYC
proxy     6525  0.0  0.0  1428  296 ?        Ss   Dec09   0:00 (unlinkd)
daemon    6537  0.0  0.0  1768  364 ?        Ss   Dec09   0:00 /usr/sbin/atd
root      6540  0.0  0.0  1820  740 ?        Ss   Dec09   0:00
/usr/sbin/cron
root      6547  0.0  0.4  9188 4992 ?        Ss   Dec09   0:00 /usr/bin/perl
/usr/share/webmin/miniserv.pl /etc/webmin/miniserv.conf
root      6568  0.0  0.0  1584  492 tty1     Ss+  Dec09   0:00 /sbin/getty
38400 tty1
root      6569  0.0  0.0  1580  488 tty2     Ss+  Dec09   0:00 /sbin/getty
38400 tty2
root      6570  0.0  0.0  1584  492 tty3     Ss+  Dec09   0:00 /sbin/getty
38400 tty3
root      6571  0.0  0.0  1584  488 tty4     Ss+  Dec09   0:00 /sbin/getty
38400 tty4
root      6572  0.0  0.0  1584  492 tty5     Ss+  Dec09   0:00 /sbin/getty
38400 tty5
root      6573  0.0  0.0  1584  492 tty6     Ss+  Dec09   0:00 /sbin/getty
38400 tty6
root     17864  0.0  0.1  6988 1932 ?        Ss   12:32   0:00 sshd: bgeach
[priv]
bgeach   17866  0.0  0.1  7140 1448 ?        S    12:32   0:00 sshd:
bgeach@pts/0
bgeach   17867  0.0  0.1  3064 1612 pts/0    Ss   12:32   0:00 -bash
root     17870  0.0  0.1  2672 1496 pts/0    S    12:32   0:00 -su
root     19194  0.0  0.0  2628  848 pts/0    S    12:33   0:00 sms_serv
root     31127  0.0  0.0  2568  856 pts/0    R+   12:42   0:00 ps aux



Linux version 2.6.14.3 (root@lon-gw) (gcc version 3.3.5 (Debian 1:3.3.5-13))
#4 SMP Fri Dec 9 14:02:29 GMT 2005 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fffec00 (ACPI data)
 BIOS-e820: 000000003fffec00 - 000000003ffff000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee20000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved) 127MB HIGHMEM
available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:15 DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdcd0
ACPI: RSDT (v001 DELL   PA1550   0x00000001 MSFT 0x0100000a) @ 0x000fdce4
ACPI: FADT (v001 DELL   PA1550   0x00000001 MSFT 0x0100000a) @ 0x000fdd10
ACPI: MADT (v001 DELL   PA1550   0x00000001 MSFT 0x0100000a) @ 0x000fdd84
ACPI: DSDT (v001 DELL   PA1550   0x00000001 MSFT 0x0100000a) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled) Processor #1 6:8 APIC
version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x00] enabled) Processor #0 6:8 APIC
version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs Using ACPI (MADT) for SMP
configuration information Allocating PCI resources starting at 40000000
(gap: 3ffff000:bec01000) Built 1 zonelists Kernel command line:
root=/dev/sda1 ro mapped APIC to ffffd000 (fee00000) mapped IOAPIC to
ffffc000 (fec00000) mapped IOAPIC to ffffb000 (fec01000) Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes) Detected 927.350 MHz
processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes) Inode-cache
hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033212k/1048512k available (2847k kernel code, 14528k reserved,
1073k data, 244k init, 131008k highmem) Checking if this processor honours
the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1857.01 BogoMIPS
(lpj=3714020) Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000 Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06 Booting processor 1/0 eip
2000 Initializing CPU#1 Calibrating delay using timer specific routine..
1854.35 BogoMIPS (lpj=3708700)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000 Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06 Total of 2 processors
activated (3711.36 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfcb7e, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:03.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Root Bridge [PCI1] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 *10 11 12 14)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LNK9] (IRQs *3 4 5 6 7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12 14)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14) *0, disabled.
ACPI: PCI Interrupt Link [LUSB] (IRQs 3 4 5 6 *7 10 11 12 14) Linux Plug and
Play Support v0.97 (c) Adam Belay SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: feb00000-febfffff
  PREFETCH window: f8000000-fbffffff
PCI: Bridge: 0000:01:04.0
  IO window: d000-dfff
  MEM window: fe900000-febfffff
  PREFETCH window: f8000000-fbffffff
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com> highmem bounce
pool size: 64 pages Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
Using specific hotkey driver
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1 io scheduler noop registered io
scheduler anticipatory registered io scheduler deadline registered io
scheduler cfq registered Floppy drive(s): fd0 is 1.44M FDC 0 is a National
Semiconductor PC87306 RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI Copyright (c)
1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 29 (level, low) -> IRQ 16
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:04:06.1[B] -> GSI 30 (level, low) -> IRQ 17
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection Ethernet
Channel Bonding Driver: v2.6.4 (September 26, 2005)
bonding: Warning: either miimon or arp_interval and arp_ip_target module
parameters must be specified, otherwise bonding will not detect link
failures! see bonding.txt for details.
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 18
eth2: OEM i82557/i82558 10/100 Ethernet, 00:B0:D0:F0:09:2F, IRQ 18.
  Board assembly 02d484-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 17 (level, low) -> IRQ 19
eth3: OEM i82557/i82558 10/100 Ethernet, 00:B0:D0:F0:09:30, IRQ 19.
  Board assembly 02d484-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.2
PPP Deflate Compression module registered PPP BSD Compression module
registered MPPE/MPPC encryption/compression module registered
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com> Uniform
Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1 SvrWks OSB4: chipset
revision 0 SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:pio, hdd:pio Probing
IDE interface ide0...
hda: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive ide0 at 0x1f0-0x1f7,0x3f6
on irq 14 Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 24X CD-ROM drive, 128kB Cache, (U)DMA Uniform CD-ROM driver
Revision: 3.20 Loading Adaptec I2O RAID: Version 2.4 Build 5go Detecting
Adaptec I2O RAID controllers...
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 27 (level, low) -> IRQ 20 scsi0 :
Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

ACPI: PCI Interrupt 0000:04:05.1[B] -> GSI 28 (level, low) -> IRQ 21
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
megaraid: probe new device 0x101e:0x1960:0x1028:0x0493: bus 3:slot 0:func 0
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 25 (level, low) -> IRQ 22
megaraid: fw version:[197O] bios version:[3.35]
scsi2 : LSI Logic MegaRAID driver
scsi[2]: scanning scsi channel 0 [Phy 0] for non-raid devices
  Vendor: DELL      Model: 1x3 U2W SCSI BP   Rev: 1.21
  Type:   Processor                          ANSI SCSI revision: 02
scsi[2]: scanning scsi channel 1 [Phy 1] for non-raid devices
scsi[2]: scanning scsi channel 2 [virtual] for logical drives
  Vendor: MegaRAID  Model: LD 0 RAID1   34G  Rev: 197O
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 71557120 512-byte hdwr sectors (36637 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through SCSI device sda: 71557120 512-byte
hdwr sectors (36637 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 > Attached scsi disk sda at
scsi2, channel 2, id 0, lun 0
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage USB Mass Storage support
registered.
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
v0.12
mice: PS/2 mouse device common for all mice i2c /dev entries driver
piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device i2c_adapter i2c-0: found
DS1780 revision 1 adm9240 0-002c: Using VRM: 8.2 adm9240 0-002c: status:
config 0x03 mode 1 i2c_adapter i2c-0: found DS1780 revision 1 adm9240
0-002d: Using VRM: 8.2 adm9240 0-002d: status: config 0x03 mode 1
i2c_adapter i2c-0: found LM81 revision 3 adm9240 0-002e: Using VRM: 8.2
adm9240 0-002e: status: config 0x03 mode 1 i2c_adapter i2c-0: detect fail:
address match, 0x2f
 dcdbas: Dell Systems Management Base Driver (version 5.6.0-1)
u32 classifier
    OLD policer on
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes) TCP
established hash table entries: 262144 (order: 9, 2097152 bytes) TCP bind
hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536) TCP reno
registered ip_conntrack version 2.3 (8191 buckets, 65528 max) - 236 bytes
per conntrack ctnetlink v0.90: registering with nfnetlink.
ip_conntrack_pptp version 3.1 loaded
ip_tables: (C) 2000-2002 Netfilter core team ipt_recent v0.3.1: Stephen
Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP bic registered
TCP westwood registered
TCP highspeed registered
TCP hybla registered
TCP htcp registered
TCP vegas registered
TCP scalable registered
Netfilter messages via NETLINK v0.30.
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 244k freed Adding 2000052k swap on /dev/sda6.
Priority:-1 extents:1 across:2000052k
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
e1000: eth1: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged! 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Willy Tarreau
> Sent: 09 December 2005 21:44
> To: Brent
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: High load since upgrade
> 
> On Fri, Dec 09, 2005 at 11:57:37AM -0000, Brent wrote:
> > Hi
> > Hope this is the right list I'm posting to but here goes.
> > 
> > I recently upgraded 3 servers to the stock 2.6.14.3 kernels from an 
> > older
> > 2.4.28 kernel, all identical running debian stable and all 
> up to date 
> > with no outstandng updates needed to the OS.
> > As from these 3 graphs (all servers almost identical 
> hardware), PIII 
> > 900, 1G RAM, you can quite clearly see when the upgrades where made 
> > and sending the load avg up way above the previous averages.
> > http://pics.skyblue.eu.org/graphs/
> 
> you graphs show a permanent load of 1 + something low. In the 
> past, there have been some bugs in modules which made them 
> increase the apparent load average by 1. I suspect that 
> you're witnessing something similar here.
> 
> > All these servers are only running; shorewall, squid and 
> ntop as their 
> > primary functions.
> > 
> > Before I go pasting my .config etc etc I wanted to know 
> first off what 
> > anyone would really like so I don't paste too much to 
> create a really 
> > large post.
> 
> # ps aux
> # lsmod
> # dmesg
> 
> > Also if it's a known issue?
> 
> I don't think so. I've encountered scheduler fairness 
> problems on 2.6 which always made me go back to 2.4, except 
> for my home web server on parisc which has never been stable 
> for more than a few days on 2.4, while it's rock solid on 
> 2.6.11, but I never monitor performance there so it's not a 
> problem. Anyway, its loadavg is ~0.
> 
> > But here is a quick vmstat and as can see the 'in' is rather larger 
> > than normal I would think?
> 
> It's expected. In 2.6 on x86, you now have the system timer 
> set to 250 Hz, while it was at 100 on 2.4. So it implies 150 
> more interrupts/s that you can count in the 'in' column. I 
> guess you were roughly between 110 and 160 on 2.4 here.
> 
> > Top is not reporting anything usefull really.
> > 
> > /usr/src/linux-2.6.14.3# vmstat -n 1
> > procs -----------memory---------- ---swap-- -----io---- --system--
> > ----cpu----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   
> in    cs us sy id
> > wa
> >  0  0      0     26    231    364    0    0     0    13   
> 13     4  1  2 97
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 272    42  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 265    35  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 276    46  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0    36  
> 290    70  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0    48  
> 276    64  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 291    69  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0    12  
> 266    37  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 315   120  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     4  
> 322   116  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 313    99  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 301    92  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 279    49  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 298    77  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 315    93  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0    36  
> 300    74  0  0 100
> > 0
> >  0  0      0     26    231    364    0    0     0     0  
> 283    45  0  0 100
> > 0
> > 
> > A list of the hardware is from lspci is:
> > 
> > 0000:00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
> > 0000:00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> > 0000:00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> > 0000:00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01) 
> > 0000:00:01.0 Ethernet controller: Intel Corp. 82557/8/9 
> [Ethernet Pro 
> > 100] (rev 08) 0000:00:02.0 Ethernet controller: Intel Corp. 
> 82557/8/9 
> > [Ethernet Pro 100] (rev 08) 0000:00:03.0 VGA compatible controller: 
> > ATI Technologies Inc Rage XL (rev
> > 27)
> > 0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> > 0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> > 0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB 
> Controller 
> > (rev
> > 04)
> > 0000:01:04.0 PCI bridge: Digital Equipment Corporation 
> DECchip 21154 
> > (rev
> > 05)
> > 0000:02:00.0 PCI bridge: Digital Equipment Corporation 
> DECchip 21154 
> > (rev
> > 05)
> > 0000:02:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual 
> > Channel
> > Ultra3 SCSI Processor (rev 06)
> > 0000:03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID 
> > (rev 20) 0000:04:05.0 SCSI storage controller: Adaptec AIC-7899P 
> > U160/m (rev 01)
> > 0000:04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 
> > 01) 0000:04:06.0 Ethernet controller: Intel Corp. 82546GB Gigabit 
> > Ethernet Controller (rev 03)
> > 0000:04:06.1 Ethernet controller: Intel Corp. 82546GB 
> Gigabit Ethernet 
> > Controller (rev 03)
> 
> Regards,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


