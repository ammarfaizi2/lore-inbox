Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319598AbSH3P4w>; Fri, 30 Aug 2002 11:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319606AbSH3P4w>; Fri, 30 Aug 2002 11:56:52 -0400
Received: from gc-na5.alcatel.fr ([64.208.49.5]:48965 "EHLO smail3.alcatel.fr")
	by vger.kernel.org with ESMTP id <S319598AbSH3P4u> convert rfc822-to-8bit;
	Fri, 30 Aug 2002 11:56:50 -0400
X-Lotus-FromDomain: ALCATEL-SPACE
From: Didier.Schrapf@space.alcatel.fr
To: linux-kernel@vger.kernel.org
Message-ID: <C1256C25.00579226.00@vzmta01.netfr.alcatel.fr>
Date: Fri, 30 Aug 2002 17:44:53 +0200
Subject: Kernel hangs or oops when I create a few number of processes
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

my Linux 24.2 kernel systematically hangs or Oops when I create a few number of
processes;
I could'nt get any information on such a problem in the mailling list.

For example, sh; sh; ls hangs the system.

My configuration :
    .embedded board with MPC860 and 8 MB RAM
    .HardHat Linux 2.4.2
    .File System on PC via NFS mount


Hereafter is an example, with 3 successive bash calls :

Linux version 2.4.2_hhl20 (schrapd@host.fr) (gcc version 2.95.3 20010315
(release/MontaVista)) #13 ven aoû 30 14:41:10 CEST 2002
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=192.134.0.7:/tftpboot/%s
ip=192.134.0.6
Decrementer Frequency = 180000000/60
Calibrating delay loop... 47.71 BogoMIPS
Memory: 14936k available (808k kernel code, 280k data, 44k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
block: queued sectors max/low 9861kB/3287kB, 64 slots per queue
eth0: CPM ENET Version 0.2 on SCC1, ff:ff:ff:ff:ff:ff
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Guessing netmask 255.255.255.0
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.134.0.7
Looking up port of RPC 100005/2 on 192.134.0.7
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 44k init 4k openfirmware
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
Mounting local filesystems...
not mounted anything
Setting up IP spoofing protection: FAILED
Configuring network interfaces: /sbin/ifup: interface lo already configured
done.
Starting portmap daemon: portmap.
Cleaning: /tmp /var/lock /var/run.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.

MontaVista Software's Hard Hat Linux 2.0

192.134.0.6 login: root
Last login: Thu Jan  1 01:24:58 1970 on console
Linux 192.134.0.6 2.4.2_hhl20 #13 ven aoû 30 14:41:10 CEST 2002 ppc unknown

Welcome to MontaVista Software's Hard Hat Linux.

root@192.134.0.6:~# bash
root@192.134.0.6:~# bash
root@192.134.0.6:~# bash
Oops: kernel access of bad area, sig: 11
NIP: C000CA54 XER: 00009F00 LR: C000CA38 SP: C0A29E50 REGS: c0a29da0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 46720020, DSISR: 0000012B
TASK = c0a28000[82] 'bash' Last syscall: 6
last math 00000000 last altivec 00000000
GPR00: EF2A4005 C0A29E50 C0A28000 00009032 00000000 C00EDC70 C01BC510 00000000
GPR08: C00EDC70 1ACDC006 C00E6060 46720000 001717E6 100A9A4C 00000000 100BE2F0
GPR16: 100BE250 00000001 007FFF00 00000000 00009032 00A29E80 00000000 C000274C
GPR24: C000A4B8 00000001 C0A28000 7FFFFDBC 7FFFFDC4 00000000 C00EEF10 C0A29E50
Call backtrace:
FFFFFFFE C00027AC 3002A0F8 0FE48580 0FE3BE28 0FE3BC20 3000E504
3000E6D4 30012F88
Oops: kernel access of bad area, sig: 11
NIP: C00156D0 XER: 00009F00 LR: C0015620 SP: C0A29B30 REGS: c0a29a80 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 00000927
TASK = c0a28000[82] 'bash' Last syscall: 6
last math 00000000 last altivec 00000000
GPR00: 00000004 C0A29B30 C0A28000 C00CD00C 000FFFFF 03FFFFFF C01015AC 00000000
GPR08: C0101620 00000000 C01F5EE8 C0100000 C0100000 100A9A4C 00000000 100BE2F0
GPR16: 100BE250 00000001 007FFF00 00000000 00001032 C00CD008 C01017B4 C0100000
GPR24: C00F0000 C0100000 C01015B0 C01013AC C01011A8 C0100FA4 C01017B4 00000E00
Call backtrace:
C0015590 C0012FFC C0012EA8 C0012C28 C0002790 C0002948 C000A86C
C000A748 C000274C FFFFFFFE C00027AC 3002A0F8 0FE48580 0FE3BE28
0FE3BC20 3000E504 3000E6D4 30012F88
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing
Rebooting in 180 seconds..


I'd be very glad if someone could tell me how to debug thhis problem ...

Best regards.


