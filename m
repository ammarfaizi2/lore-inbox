Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129841AbQLCURs>; Sun, 3 Dec 2000 15:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQLCURi>; Sun, 3 Dec 2000 15:17:38 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:46596
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129841AbQLCURd>; Sun, 3 Dec 2000 15:17:33 -0500
Date: Sun, 3 Dec 2000 14:46:25 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: test12-pre2
Message-ID: <20001203144625.A1918@animx.eu.org>
In-Reply-To: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com> <20001128213003.A3720@animx.eu.org> <20001130202439.A585@jurassic.park.msu.ru> <20001201171033.A10915@animx.eu.org> <20001202162614.A2738@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=CE+1k2dSO48ffgeK
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20001202162614.A2738@jurassic.park.msu.ru>; from Ivan Kokshaysky on Sat, Dec 02, 2000 at 04:26:14PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii

> > It just oops continuously.  It finds the scsi drives and says it's enabling
> > a few pci devices but it scrolls too fast to see what it really does
> 
> If it finds scsi drives, PCI setup is probably ok. There could be
> a lot of other problems - too much changes since 2.2.
> 
> Capturing kernel messages via serial port would be helpful,
> but I understand that it is not always possible. :-(

I have the capture.  It actually mounts / and attempts to free unused memory
and then it continuously oops's in swapper.  (See attached)  

For the people on the list, I have also included the patch that allows me to
boot my machine.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.0-test12pre3-bootlog"

Linux version 2.4.0-test12 (wakko@kakarot) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #3 Sun Dec 3 14:06:12 EST 2000
Booting on Noritake using machine vector Noritake from SRM
Command line: root=/dev/sda1 ro single console=ttyS0
memcluster 0, usage 1, start        0, end      171
memcluster 1, usage 0, start      171, end    20403
memcluster 2, usage 1, start    20403, end    20480
freeing pages 171:384
freeing pages 627:20403
On node 0 totalpages: 20480
zone(0): 20480 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 ro single console=ttyS0
Using epoch = 1900
Console: colour VGA+ 80x25
Calibrating delay loop... 524.29 BogoMIPS
Memory: 157152k/163224k available (1114k kernel code, 4704k reserved, 241k data, 224k init)
Dentry-cache hash table entries: 32768 (order: 6, 524288 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
  got res[2800000:2ffffff] for resource 1 of 3DLabs Permedia II 2D+3D
  got res[3000000:37fffff] for resource 2 of 3DLabs Permedia II 2D+3D
  got res[2200000:221ffff] for resource 0 of 3DLabs Permedia II 2D+3D
  got res[2220000:222ffff] for resource 6 of 3DLabs Permedia II 2D+3D
  got res[9000:90ff] for resource 0 of Q Logic ISP1020
  got res[9400:947f] for resource 0 of Digital Equipment Corporation DECchip 21142/43
  got res[9480:94bf] for resource 0 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3800000:383ffff] for resource 6 of Digital Equipment Corporation DECchip 21142/43
  got res[3840000:384ffff] for resource 6 of Q Logic ISP1020
  got res[3850000:385ffff] for resource 6 of 3Com Corporation 3c905 100BaseTX [Boomerang]
  got res[3860000:3860fff] for resource 1 of Q Logic ISP1020
  got res[3861000:386107f] for resource 1 of Digital Equipment Corporation DECchip 21142/43
PCI: Bus 1, bridge: Digital Equipment Corporation DECchip 21050
  IO window: 1000-9fff
  MEM window: 03800000-038fffff
PCI enable device: (Intel Corporation 82375EB)
  cmd reg 0x7
PCI enable device: (Digital Equipment Corporation DECchip 21050)
  cmd reg 0x107
PCI enable device: (3DLabs Permedia II 2D+3D)
  cmd reg 0x7
PCI enable device: (Q Logic ISP1020)
  cmd reg 0x47
PCI enable device: (Digital Equipment Corporation DECchip 21142/43)
  cmd reg 0x47
PCI enable device: (3Com Corporation 3c905 100BaseTX [Boomerang])
  cmd reg 0x47
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (2)
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 00 irq 17 I/O base 0x9000
  Vendor: WDIGTL    Model: ENTERPRISE        Rev: 1.80
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: DEC       Model: RZ28D    (C) DEC  Rev: 0008
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 25501-XXX  Rev: 2.54
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0
SCSI device sda: 4254819 512-byte hdwr sectors (2178 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5
SCSI device sdb: 4110480 512-byte hdwr sectors (2105 MB)
 sdb: unknown partition table
SCSI device sdc: 4110480 512-byte hdwr sectors (2105 MB)
 sdc: unknown partition table
SCSI device sdd: 4110480 512-byte hdwr sectors (2105 MB)
 sdd: unknown partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(53): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(54): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(56): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(57): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(60): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(61): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(63): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(64): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 
Unable to handle kernel paging request at virtual address 0000000000000010
swapper(68): Oops 0
pc = [<fffffc0000323150>]  ra = [<fffffc0000323538>]  ps = 0000
v0 = 0000000000000000  t0 = 0000000000000012  t1 = fffffc0000489740
t2 = fffffc0000794560  t3 = fffffc0000470fa8  t4 = 0000000000000000
t5 = fffffffffffffffe  t6 = ffffffffffffffff  t7 = fffffc0009e00000
s0 = fffffc00003234e0  s1 = 0000000000000000  s2 = fffffc0000794560
s3 = fffffc0000794560  s4 = fffffc0009eacac0  s5 = fffffc0009eacac0
s6 = fffffc0009eacac0
a0 = fffffc000048b0c0  a1 = fffffc0009e00050  a2 = fffffc000048b1c0
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000000
t8 = 0000000000000001  t9 = 0000000000000003  t10= 0000000000000004
t11= 0000000000000010  pv = fffffc00003234e0  at = 0000000000000000
gp = fffffc00004a7f50  sp = fffffc0009dffee0
Code: 40203001  addl t0,1,t0
 b82b0000  stl_c t0,0(s2)
 e42001fe  blt t0,.+2044
 b57e0148  stq s2,328(sp)
 a5480428  ldq s1,1064(t7)
 a0220008  ldl t0,8(t1)
*a60a0010  ldq a0,16(s1)
 a52a0028  ldq s0,40(s1)

Trace:323538 3234e0 

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=240t12p3-pci-patch

diff -ru 2.4.0-test12-pre3/drivers/pci/setup-bus.c 2.4.0-test12-pre3-pci-patch/drivers/pci/setup-bus.c
--- 2.4.0-test12-pre3/drivers/pci/setup-bus.c	Fri Dec  1 15:38:12 2000
+++ 2.4.0-test12-pre3-pci-patch/drivers/pci/setup-bus.c	Fri Dec  1 16:03:31 2000
@@ -45,24 +45,28 @@
 	head_io.next = head_mem.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
+		u16 class = dev->class >> 8;
 		u16 cmd;
 
 		/* First, disable the device to avoid side
 		   effects of possibly overlapping I/O and
 		   memory ranges.
-		   Except the VGA - for obvious reason. :-)  */
-		if (dev->class >> 8 == PCI_CLASS_DISPLAY_VGA)
+		   Leave VGA enabled - for obvious reason. :-)
+		   Same with all sorts of bridges - they may
+		   have VGA behind them.  */
+		if (class == PCI_CLASS_DISPLAY_VGA
+				|| class == PCI_CLASS_NOT_DEFINED_VGA)
 			found_vga = 1;
-		else {
+		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
 			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
 						| PCI_COMMAND_MASTER);
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
 		}
- 
+
 		/* Reserve some resources for CardBus.
 		   Are these values reasonable? */
-		if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
+		if (class == PCI_CLASS_BRIDGE_CARDBUS) {
 			io_reserved += 8*1024;
 			mem_reserved += 32*1024*1024;
 			continue;
diff -ru 2.4.0-test12-pre3/drivers/pci/setup-res.c 2.4.0-test12-pre3-pci-patch/drivers/pci/setup-res.c
--- 2.4.0-test12-pre3/drivers/pci/setup-res.c	Fri Dec  1 15:38:12 2000
+++ 2.4.0-test12-pre3-pci-patch/drivers/pci/setup-res.c	Fri Dec  1 17:17:18 2000
@@ -148,8 +148,11 @@
 			continue;
 		for (list = head; ; list = list->next) {
 			unsigned long size = 0;
-			struct resource_list *ln = list->next;
+			struct resource_list *ln;
 
+			if (!list)
+				return;
+			ln = list->next;
 			if (ln)
 				size = ln->res->end - ln->res->start;
 			if (r->end - r->start > size) {

--CE+1k2dSO48ffgeK--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
