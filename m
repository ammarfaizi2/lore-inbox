Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJUKa5>; Sun, 21 Oct 2001 06:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJUKar>; Sun, 21 Oct 2001 06:30:47 -0400
Received: from gateway2.ezbroadnet.com ([203.124.128.26]:18143 "EHLO
	ezbroadnet.com") by vger.kernel.org with ESMTP id <S275818AbRJUKam>;
	Sun, 21 Oct 2001 06:30:42 -0400
Message-ID: <017f01c159b7$83943520$aac8a8c0@cruise>
From: "Kalyan" <kalyand@cruise-controls.com>
To: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <m33d4gjaoa.fsf@linux.local> <20011020171730.A28057@parallab.uib.no> <3BD28673.1060302@sap.com> <20011021120755.A1252@parallab.uib.no>
Subject: wild pointer!!!!!
Date: Sun, 21 Oct 2001 04:05:23 +0530
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

hi all,
        I recently ported the linux kernel v 2.4.11-pre5  to MDPPro (
MPC860T processor ) board..the kernel dies with an Oops and everytime at a
different place....

        i use ppcboot to load the kernel...

        i am attaching a sample message below....

        upon back tracing i found that at some point the kernel tries to
execute code in Letext ( according to System.map)....

        it'd be great if someone can explain me what this Letext is and why
is the control going there???

thanx in advance
_kalyan.
Linux version 2.4.11-pre5 (kalyand@rtlinux.cruise) (gcc version 2.95.3
20010315
(release)) #1 Sun Oct 21 13:27:55 IST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=192.168.200.244:/tftpboot
nfsaddrs
=192.168.200.36:192.168.200.244
Decrementer Frequency = 187500000/60
Calibrating delay loop... 49.76 BogoMIPS
Memory: 14908k available (848k kernel code, 300k data, 44k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=8
eth0: CPM ENET Version 0.2 on SCC1, 00:12:23:34:34:45
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.200.36, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.168.200.36, domain=, nis-domain=(none),
     bootserver=192.168.200.244, rootserver=192.168.200.244, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.200.244
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.200.244
Root-NFS: Unable to get mountd port number from server, using default
Oops: kernel access of bad area, sig: 11
NIP: C0014768 XER: 2000FF28 LR: C00145B4 SP: C00F5DC0 REGS: c00f5d10 TRAP:
0300
   Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 7C9FF303, DSISR: 0000092A
TASK = c00f3fa0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C010F300 C00F5DC0 C00F3FA0 00000001 00001032 00000001 C0100000
C0107180
GPR08: 00000002 7FFBFDF7 7C9FF2FF C030F30F 22158222 FEE7DF32 00FFC700
007FFF5A
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 00001032 000F5E70 C00D7060
C010F2F0
GPR24: C0110000 C0100000 C00FBD70 00000000 C0110000 00000001 D173C7FC
7FB97ED3
Call backtrace:
C0014538 C0012314 C00121D4 C0011E14 C0003FAC C00026E0 C0003CF0
C0003D04 C0002270 C00FC744 C0002138
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..




