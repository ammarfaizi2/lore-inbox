Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274681AbRJEX7c>; Fri, 5 Oct 2001 19:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274695AbRJEX7Y>; Fri, 5 Oct 2001 19:59:24 -0400
Received: from chiappa.ne.mediaone.net ([65.96.224.12]:1289 "EHLO
	lumberjack.snurgle.org") by vger.kernel.org with ESMTP
	id <S274681AbRJEX7K>; Fri, 5 Oct 2001 19:59:10 -0400
Date: Fri, 5 Oct 2001 19:59:39 -0400
From: Chris Chiappa <chris@chiappa.net>
To: linux-kernel@vger.kernel.org
Subject: Thinkpad 755CX & 2.4: Machine Check Exception
Message-ID: <20011005195939.A7662@lumberjack.snurgle.org>
Reply-To: chris@chiappa.net
Mail-Followup-To: Chris Chiappa <chris@chiappa.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've got a Thinkpad 755CX (75MHz Pentium classic with the f00f bug).  I've
been unable to boot any 2.4 kernels, even though 2.2 seems to run fine, and
burnP5 doesn't seem to produce any ill effects.
I've tried multiple compilations (both Linus and -ac kernels) by both me and
Debian with the obvious things to check (trying 386, 486, 586 kernels, etc,
leaving out APM...) with no difference in behavior.  All I've been able to
come up with is a kernel which, immediately upon booting, dumps line after
line of the following:

CPU#0: Machine Check Exception:  0x   BF??C (type 0x       D).

The '??' seems to be random numbers but they scroll by so quickly that I
can't make out any distinct numbers.  Any suggestions before starting a
binary search to find the kernel which broke this? I've attached a file with
the output of the kernel dmesg from 2.2.18pre21 (from Debian) and
/proc/cpuinfo.

-- 

..ooOO chris@chiappa.net              | My opinions are my own  OOoo..
..ooOO chris.chiappa@oracle.com       | and certainly not those OOoo..
..ooOO http://www.chiappa.net/~chris/ | of my employer          OOoo..

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tpad.info"

Linux version 2.2.18pre21 (herbert@arnor) (gcc version 2.7.2.3) #1 Sat Nov 18 18:47:15 EST 2000
Detected 75002 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 149.50 BogoMIPS
Memory: 13596k/16384k available (1728k kernel code, 412k reserved, 500k data, 148k init)
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium 75 - 200 stepping 04
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: No PCI bus detected
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
hda: DVAA-2810, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: DVAA-2810, 773MB w/32kB Cache, CHS=785/32/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 82078.
md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
scsi: <fdomain> Detection failed (no card)
NCR53c406a: no available ports found
sym53c416.c: Version 1.0.0
qlogicisp : PCI not present
eata_pio: No BIOS32 extensions present. This driver release still depends on it.
          Skipping scan for PCI HBAs.
Failed initialization of WD-7000 SCSI card!
IBM MCA SCSI: Version 3.2
IBM MCA SCSI: No Microchannel-bus present --> Aborting.
              This machine does not have any IBM MCA-bus
              or the MCA-Kernel-support is not enabled!
megaraid: v1.11 (Aug 23, 2000)
aec671x_detect: 
   NO PCI SUPPORT.
3w-xxxx: tw_scsi_detect(): No pci interface present.
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
apm: BIOS version 1.1 Flags 0x03 (Driver version 1.13)
apm: disabled on user request.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 148k freed
NET4: Unix domain sockets 1.0 for Linux NET4.0.
Adding Swap: 56412k swap-space (priority -1)
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Linux PCMCIA Card Services 3.1.22
  kernel build: 2.2.18pre21 unknown
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: 
  Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
    host opts [0]: none
    host opts [1]: none
    ISA irqs (default) = 3,4,5,7,9,10,11,12,15 polling interval = 1000 ms
cs: IO port probe 0x0c00-0x0cff: excluding 0xc20-0xc27
cs: IO port probe 0x0800-0x08ff: excluding 0x820-0x827
cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107 0x1a0-0x1af 0x3b8-0x3e7 0x420-0x427
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.
eth0: NE2000 (DL10022 rev 30): io 0x300, irq 3, hw_addr 00:48:54:C0:67:A4
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 4
cpu MHz		: 75.002
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 149.50


--gBBFr7Ir9EOA20Yy--
