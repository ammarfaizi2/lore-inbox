Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUJNNM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUJNNM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJNNM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:12:56 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:63872 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264571AbUJNNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:12:42 -0400
Date: Thu, 14 Oct 2004 15:00:35 +0200
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org,
       linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041014130035.GA4152@gamma.logic.tuwien.ac.at>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at> <20041013233247.A11663@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041013233247.A11663@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Dear Ivan, dear kernel kackers!

On Mit, 13 Okt 2004, Ivan Kokshaysky wrote:
> > 	make bootpfile

Ok, now I have a boot file but the kernel is not started:

>>> boot ewa0 -fl ...
...
jumping to bootstrap code
Linux/AXP bootp loader for linux 2.4.27
Switching to OSF PAL-code .. 0k (rev 1000800020117)
Loading the kernel...'root=/dev/sda1'

Halted CPU 0

halt code = 2
kernel stack not valid halt
PC = 200000000
boot failure
>>>

(typed in from screen)

SRM 5.5, AlphaPC164
normal (from scsi) boot dmesg with aboot is attached.

Any hints for this?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HARPENDEN (n.)
The coda to a phone conversion, consisting of about eight exchanges,
by which people try gracefully to get off the line.
			--- Douglas Adams, The Meaning of Liff

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alpha.dmesg"

Linux version 2.4.27alphafullscsi (root@beta) (gcc version 3.3.4) #1 Tue Oct 12 08:04:47 CEST 2004
Booting on EB164 variation PC164 using machine vector PC164 from SRM
Major Options: EV56 LEGACY_START MAGIC_SYSRQ 
Command line: ro root=/dev/sda1
memcluster 0, usage 1, start        0, end      192
memcluster 1, usage 0, start      192, end    32651
memcluster 2, usage 1, start    32651, end    32768
freeing pages 192:384
freeing pages 794:32651
reserving pages 794:795
pci: cia revision 2
On node 0 totalpages: 32651
zone(0): 32651 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda1
Using epoch = 2000
Console: colour VGA+ 80x25
Calibrating delay loop... 994.44 BogoMIPS
Memory: 253544k/261208k available (2070k kernel code, 6128k reserved, 351k data, 328k init)
Dentry cache hash table entries: 32768 (order: 6, 524288 bytes)
Inode cache hash table entries: 16384 (order: 5, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 8192 bytes)
Buffer cache hash table entries: 8192 (order: 3, 65536 bytes)
Page-cache hash table entries: 32768 (order: 5, 262144 bytes)
POSIX conformance testing by UNIFIX
pci: passed tb register update test
pci: passed sg loopback i/o read test
pci: passed tbia test
pci: passed pte write cache snoop test
pci: failed valid tag invalid pte reload test (mcheck; workaround available)
pci: passed pci machine check test
pci: enabling save/restore of SRM state
SMC FDC37C93X Ultra I/O Controller found @ 0x370
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
srm_env: version 0.0.5 loaded successfully
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.10f
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
eth0: DE434/5 at 0x8400 (PCI bus 0, device 7), h/w address 00:c0:95:ec:b7:60,
      and requires IRQ17 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
SCSI subsystem driver Revision: 1.00
sym0: <810> rev 0x2 on pci bus 0 device 9 function 0 irq 19
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
blk: queue fffffc000fe2eca8, no I/O memory limit
  Vendor: IBM       Model: DNES-309170       Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue fffffc000fe2eea8, no I/O memory limit
  Vendor: HP        Model: C1533A            Rev: 9503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue fffffc000fe2f0a8, no I/O memory limit
sym0:0:0: tagged command queuing enabled, command queue depth 16.
st: Version 20040102, bufsize 32768, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sym0:0: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 328k freed
Adding Swap: 205592k swap-space (priority -1)
eth0: media is TP.

--J2SCkAp4GZ/dPZZf--
