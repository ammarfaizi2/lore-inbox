Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTKXPog (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTKXPog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:44:36 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:32421 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S263778AbTKXPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:44:28 -0500
Date: Mon, 24 Nov 2003 16:44:25 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org
Subject: oops (sparc64) with 2.6.0-test9-bk24
Message-ID: <20031124164425.H4083@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_eAMfFXiAuoTsnn"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=_eAMfFXiAuoTsnn
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi,

this is with CONFIG_PREEMPT enabled.
I got (attached) oops with 2.6.0-test9-bk24 on debian/unstable box (gcc-3.3.2) 
on a Sun Ultra Enterpise.

If some further info is needed, please advice!

  - Christian

--=_eAMfFXiAuoTsnn
Content-Type: text/plain
Content-Disposition: attachment; filename="oops.txt"

ksymoops 2.4.9 on sparc64 2.6.0-test9-bk24.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test9-bk24/ (default)
     -m /boot/System.map-2.6.0-test9-bk24 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Nov 24 15:51:16 eclipse kernel: CPU 1 IS NOW UP!
Nov 24 15:51:16 eclipse kernel: CPU 1: synchronized TICK with master CPU (last diff 0 cycles,maxerr 383 cycles)
Nov 24 16:23:02 eclipse kernel: Unable to handle kernel NULL pointer dereference
Nov 24 16:23:02 eclipse kernel: tsk->{mm,active_mm}->context = 0000000000000669
Nov 24 16:23:02 eclipse kernel: tsk->{mm,active_mm}->pgd = fffff800023de000
Nov 24 16:23:02 eclipse kernel:               \|/ ____ \|/
Nov 24 16:23:02 eclipse kernel:               "@'/ .. \`@"
Nov 24 16:23:02 eclipse kernel:               /_| \__/ |_\
Nov 24 16:23:02 eclipse kernel:                  \__U_/
Nov 24 16:23:02 eclipse kernel: events/0(7): Oops [#1]
Nov 24 16:23:02 eclipse kernel: TSTATE: 0000001980f09604 TPC: 000000000044ebb4 TNPC: 000000000044ebb8 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Nov 24 16:23:03 eclipse kernel: g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000466900 g3: fffff800023afb80
Nov 24 16:23:03 eclipse kernel: g4: fffff80047edf260 g5: 0000000000000001 g6: fffff80047df8000 g7: 0000000000000000
Nov 24 16:23:03 eclipse kernel: o0: 000000000000016f o1: 0000000000000000 o2: 0000000000000001 o3: 0000000000620318
Nov 24 16:23:03 eclipse kernel: o4: 000000000000000a o5: fffff800023afb00 sp: fffff80047dfb401 ret_pc: 0000000000466bd8
Nov 24 16:23:03 eclipse kernel: l0: 0000000000000001 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000
Nov 24 16:23:03 eclipse kernel: l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
Nov 24 16:23:03 eclipse kernel: i0: fffff800023afbc0 i1: 0000000000000003 i2: 0000000000000001 i3: 0000000000000000
Nov 24 16:23:03 eclipse kernel: i4: fffffffffffffffa i5: 0000000000000000 i6: fffff80047dfb4c1 i7: 000000000044eda0


>>PC;  0044ebb4 <__wake_up_common+14/80>   <=====

>>g2; 00466900 <wait_for_helper+0/60>
>>o3; 00620318 <__func__.0+0/18>
>>ret_pc; 00466bd8 <queue_work+f8/120>
>>i7; 0044eda0 <complete+40/a0>

Nov 24 16:23:03 eclipse kernel: Instruction DUMP: b0062008  80a04018  02600017 <e2584000> b3366000  b73ee000  90007fe8  e0007fe8  92100019 


Code;  0044eba8 <__wake_up_common+8/80>
00000000 <_PC>:
Code;  0044eba8 <__wake_up_common+8/80>
   0:   b0 06 20 08       add  %i0, 8, %i0
Code;  0044ebac <__wake_up_common+c/80>
   4:   80 a0 40 18       cmp  %g1, %i0
Code;  0044ebb0 <__wake_up_common+10/80>
   8:   02 60 00 17       unknown
Code;  0044ebb4 <__wake_up_common+14/80>
   c:   e2 58 40 00       unknown
Code;  0044ebb8 <__wake_up_common+18/80>
  10:   b3 36 60 00       srl  %i1, 0, %i1
Code;  0044ebbc <__wake_up_common+1c/80>
  14:   b7 3e e0 00       sra  %i3, 0, %i3
Code;  0044ebc0 <__wake_up_common+20/80>
  18:   90 00 7f e8       add  %g1, -24, %o0
Code;  0044ebc4 <__wake_up_common+24/80>
  1c:   e0 00 7f e8       ld  [ %g1 + -24 ], %l0
Code;  0044ebc8 <__wake_up_common+28/80>
  20:   92 10 00 19       mov  %i1, %o1

Nov 24 16:23:03 eclipse kernel: TSTATE: 0000004480009601 TPC: 0000000000416414 TNPC: 0000000000416418 Y: 00000003    Not tainted
Nov 24 16:23:03 eclipse kernel: g0: 0000000000000000 g1: 0000005000000080 g2: fffff80000f82ea0 g3: fffff80000ff4008
Nov 24 16:23:03 eclipse kernel: g4: fffff80047eee640 g5: 0000000000000001 g6: fffff80000ff4000 g7: 00000000006ca020
Nov 24 16:23:03 eclipse kernel: o0: 000000000000000a o1: fffff80000ff4008 o2: 7fffffffffffffff o3: 000000000000003d
Nov 24 16:23:03 eclipse kernel: o4: fffff8004604fc70 o5: fffff8004604fbd0 sp: fffff80000ff7681 ret_pc: 0000000000416478
Nov 24 16:23:03 eclipse kernel: l0: 00000000006c40c0 l1: 00000000006ca020 l2: 00000000006c40c0 l3: 00000000006f3400
Nov 24 16:23:03 eclipse kernel: l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7: fffff80000ff7fd0
Nov 24 16:23:03 eclipse kernel: i0: 0000000000000000 i1: 00000000006df190 i2: 0000000000000001 i3: 00000000006f35c8
Nov 24 16:23:03 eclipse kernel: i4: fffff80000ff7fd8 i5: 0000000000000001 i6: fffff80000ff7741 i7: 000000000042676c


>>PC;  00416414 <cpu_idle+34/c0>   <=====

>>g7; 006ca020 <ivector_table+1220/10000>
>>ret_pc; 00416478 <cpu_idle+98/c0>
>>l0; 006c40c0 <per_cpu__runqueues+f20/1238>
>>l1; 006ca020 <ivector_table+1220/10000>
>>l2; 006c40c0 <per_cpu__runqueues+f20/1238>
>>l3; 006f3400 <inv_translate+88/100>
>>i1; 006df190 <__log_buf+ef8/8000>
>>i3; 006f35c8 <kbd_table+128/13b>
>>i7; 0042676c <startup_continue+26c/280>


1 warning and 1 error issued.  Results may not be reliable.

--=_eAMfFXiAuoTsnn
Content-Type: text/plain
Content-Disposition: attachment; filename="dmesg.txt"

PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
Linux version 2.6.0-test9-bk24 (root@eclipse) (gcc version 3.3.2 (Debian)) #2 SMP Fri Nov 21 01:14:58 CET 2003
ARCH: SUN4U
Ethernet address: 08:00:20:88:9c:b7
On node 0 totalpages: 48663
  DMA zone: 48663 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/sda1 ro
PID hash table entries: 4096 (order 12: 65536 bytes)
Console: colour dummy device 80x25
Memory: 375872k available (2160k kernel code, 544k data, 112k init) [fffff80000000000,0000000047f36000]
Calibrating delay loop... 335.05 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
Starting migration thread for cpu 0
Bringing up 1
Calibrating delay loop... 335.05 BogoMIPS
CPU 1 IS NOW UP!
CPU 1: synchronized TICK with master CPU (last diff 0 cycles,maxerr 383 cycles)
Starting migration thread for cpu 1
CPUS done 2
Total of 2 processors activated (670.10 BogoMIPS).
SMP: Calibrating ecache flush... Using heuristic of 186494 cycles, 1 ticks.
NET: Registered protocol family 16
SCSI subsystem initialized
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: HME DVMA gate array 
dma1: HME DVMA gate array 
dma2: ESC Revision 1 
cg6: CGsix [TGX+ sparc] at 1ff:30000000
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Console: switching to mono PROM 80x34
Console: switching to colour frame buffer device 144x56
pty: 256 Unix98 ptys configured
Serial: Sun Zilog driver (2 chips).
zs2 at 0x000001fff1000004 (irq = 12,7e8) is a SunZilog
zs3 at 0x000001fff1000000 (irq = 12,7e8) is a SunZilog
ttyS0 at MMIO 0x0 (irq = 7187200) is a SunZilog
ttyS1 at MMIO 0x0 (irq = 7187200) is a SunZilog
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:88:9c:b7 
eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:88:9c:b7 
esp0: IRQ 4,7e0 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
esp1: IRQ 7,7cb SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
esp2: IRQ 7,7d3 SCSI ID 7 Clk 40MHz CCYC=25000 CCF=8 TOut 167 NCR53C9XF(espfast)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : Sparc ESP366-HME
Using anticipatory io scheduler
  Vendor: FUJITSU   Model: MAG3091L SUN9.0G  Rev: 1111
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDRS-39130W       Rev: S71D
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: XM5701TASUN12XCD  Rev: 0997
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : Sparc ESP366-HME
scsi2 : Sparc ESP236-FAST
esp0: target 0 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
esp0: target 1 [period 100ns offset 15 20.00MHz FAST-WIDE SCSI-II]
SCSI device sdb: 17850000 512-byte hdwr sectors (9139 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 sdb8
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Console: switching to colour frame buffer device 144x56
mice: PS/2 mouse device common for all mice
input: Sun Mouse on zs/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 96977
EXT3-fs: sda1: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Adding 51184k swap on /dev/sda2.  Priority:-1 extents:1
EXT3 FS on sda1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb8, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Link is up using internal transceiver at 100Mb/s, Full Duplex.
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000669
tsk->{mm,active_mm}->pgd = fffff800023de000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
events/0(7): Oops [#1]
TSTATE: 0000001980f09604 TPC: 000000000044ebb4 TNPC: 000000000044ebb8 Y: 00000000    Not tainted
TPC: <__wake_up_common+0x14/0x80>
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000466900 g3: fffff800023afb80
g4: fffff80047edf260 g5: 0000000000000001 g6: fffff80047df8000 g7: 0000000000000000
o0: 000000000000016f o1: 0000000000000000 o2: 0000000000000001 o3: 0000000000620318
o4: 000000000000000a o5: fffff800023afb00 sp: fffff80047dfb401 ret_pc: 0000000000466bd8
RPC: <queue_work+0xf8/0x120>
l0: 0000000000000001 l1: 0000000000000000 l2: 0000000000000000 l3: 0000000000000000
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7: 0000000000000000
i0: fffff800023afbc0 i1: 0000000000000003 i2: 0000000000000001 i3: 0000000000000000
i4: fffffffffffffffa i5: 0000000000000000 i6: fffff80047dfb4c1 i7: 000000000044eda0
I7: <complete+0x40/0xa0>
Instruction DUMP: b0062008  80a04018  02600017 <e2584000> b3366000  b73ee000  90007fe8  e0007fe8  92100019 
note: events/0[7] exited with preempt_count 1
TSTATE: 0000004480009601 TPC: 0000000000416414 TNPC: 0000000000416418 Y: 00000003    Not tainted
TPC: <cpu_idle+0x34/0xc0>
g0: 0000000000000000 g1: 0000005000000080 g2: fffff80000f82ea0 g3: fffff80000ff4008
g4: fffff80047eee640 g5: 0000000000000001 g6: fffff80000ff4000 g7: 00000000006ca020
o0: 000000000000000a o1: fffff80000ff4008 o2: 7fffffffffffffff o3: 000000000000003d
o4: fffff8004604fc70 o5: fffff8004604fbd0 sp: fffff80000ff7681 ret_pc: 0000000000416478
RPC: <cpu_idle+0x98/0xc0>
l0: 00000000006c40c0 l1: 00000000006ca020 l2: 00000000006c40c0 l3: 00000000006f3400
l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7: fffff80000ff7fd0
i0: 0000000000000000 i1: 00000000006df190 i2: 0000000000000001 i3: 00000000006f35c8
i4: fffff80000ff7fd8 i5: 0000000000000001 i6: fffff80000ff7741 i7: 000000000042676c
I7: <startup_continue+0x26c/0x280>

--=_eAMfFXiAuoTsnn--

