Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279789AbRJ0HqY>; Sat, 27 Oct 2001 03:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279795AbRJ0HqQ>; Sat, 27 Oct 2001 03:46:16 -0400
Received: from gateway2.ezbroadnet.com ([203.124.128.26]:34526 "EHLO
	ezbroadnet.com") by vger.kernel.org with ESMTP id <S279794AbRJ0HqJ>;
	Sat, 27 Oct 2001 03:46:09 -0400
Message-ID: <00b301c15ebc$2783dba0$aac8a8c0@cruise>
From: "Kalyan" <kalyand@cruise-controls.com>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
        "ML-linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <03c101c15a76$7d067320$aac8a8c0@cruise> <15316.1504.603255.831736@cargo.ozlabs.ibm.com>
Subject: Re: Wild Pointer!!!! ( some more info )
Date: Sat, 27 Oct 2001 13:21:06 +0530
Organization: Cruise Controls Pvt. Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
            after my failed attempts at 2.4.11 -pre 5 ...i decide to try
2.4.12.. ( from kernel.org.)...
            i still get random crashes... i am attaching one below...

Cruise> bootm
## Booting image at 00100000 ...
   Image Name:   kalyan
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    541440 Bytes = 528 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.12 (kalyand@rtlinux.cruise) (gcc version 2.95.3 20010315
(rele
ase)) #13 Sat Oct 27 13:01:59 IST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=192.168.200.244:/tftpboot/diskonch
ip nfsaddrs=192.168.200.36:192.168.200.244
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.66 BogoMIPS
Memory: 14668k available (1008k kernel code, 368k data, 56k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
devfs: v0.119 (20011009) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=8
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oops: kernel access of bad area, sig: 11
NIP: 74757950 XER: 2000FF28 LR: C0012AD8 SP: C01FBDA0 REGS: c01fbcf0 TRAP:
0400
   Not tainted
MSR: 08209032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01fa000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 74757953 C01FBDA0 C01FA000 00000000 00001032 00000001 00000000
C0004850
GPR08: 00000028 C0149B00 00000000 00000000 0000000D 1EE60200 00FFC700
007FFF65
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 001FBE20 00000000
C0002980
GPR24: C0004038 00FFBAA4 C0133770 00000000 C0150000 00000001 00000000
C0149880
Call backtrace:
53545556 C0012998 C00125D8 C000424C C0002980 C000F7F4 C013AF8C
C013AC2C C013AC54 C01347D0 C0134818 C000255C C0004DF0
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..


Heres a part of the system.map
c0012550 T do_softirq
c0012550 t Letext        ------------? i still do not understand this...how
come  two entries have the same address
c0012650 T raise_softirq
c00126d4 T open_softirq
c00126f0 T __tasklet_schedule
c0012784 T __tasklet_hi_schedule
c0012818 t tasklet_action
c00128f8 t tasklet_hi_action
c00129d8 T tasklet_init
c00129f4 T tasklet_kill



C0012998 ->falls in the range of tasklet_hi_action
what is interesting is the NIP...it is 74757950  ...and
how can this be possible???? can i supect stack problems here?????


thanx in advance
_kalyan.


