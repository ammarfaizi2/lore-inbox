Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSLRJi4>; Wed, 18 Dec 2002 04:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSLRJi4>; Wed, 18 Dec 2002 04:38:56 -0500
Received: from cibs9.sns.it ([192.167.206.29]:41734 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261568AbSLRJiz>;
	Wed, 18 Dec 2002 04:38:55 -0500
Date: Wed, 18 Dec 2002 10:46:50 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: problems with NFSv3 kernel 2.5.52 server, 2.4.20 client. (server
 x86 linux, clientsparclinux)
Message-ID: <Pine.LNX.4.43.0212181026370.25931-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,

I am having some problem with NFS v3 with kernel 2.5.52 for the NFS server and
2.4.20 as NFS client..

I was doing some extended test with an x86 server (Pentium3 933 Mhz,
with 512 MB RAM,
i810 chipset), and a client sparclinux (Sparc64 II,on an Ultra 2 single CPU,
1GB RAM).

The first test I was doing was compilation of gcc, the kernel and so on on NFS
with an async export.

(Then the day after I would have started some real stress test)

Anyway the compilation seemed to go well, and I left to go home when gcc was
compiling stage 2.

When I come back this morning NFS was still mounted, bu I could not
access any NFS mounted partyition on the sparc because of I/O error (not df
was showing the the real disk occupation on those NFS partitions, just 0).

On the server I could not find any error message, while on the sparclink client
I found:

Dec 17 18:08:16 storm kernel: call_verify: server accept status: 1
Dec 17 18:08:16 storm last message repeated 2 times
Dec 17 18:08:16 storm kernel: RPC: garbage, exit EIO
Dec 17 18:08:16 storm kernel: call_verify: server accept status: 1
Dec 17 18:08:16 storm last message repeated 2 times
Dec 17 18:08:16 storm kernel: RPC: garbage, exit EIO
Dec 17 18:08:16 storm kernel: call_verify: server accept status: 1
Dec 17 18:08:16 storm last message repeated 2 times
Dec 17 18:08:16 storm kernel: RPC: garbage, exit EIO
Dec 17 18:08:16 storm kernel: call_verify: server accept status: 1
Dec 17 18:08:16 storm last message repeated 2 times
Dec 17 18:08:16 storm kernel: RPC: garbage, exit EIO

and so on.

Those are the systems:

PentiumIII 933 Mhz
i810 chipset
512MB RAM
2 ATA66 DISK
kernel 2.5.52
glibc 2.3.1
binutils 2.13.90.0.16
gcc 3.2.1
nfs and nfsd support compiled as modules
init-modules-utils 0.9.3
in nfsd support version 4 is not enabled.
nfs-utils 1.0.1
nfsd is runned with async exports


SUN UltraII
Sparc64 II 400Mhz
1GB RAM
Creator3D video card, with DRM enabled in the kernel
PROMLIB: Sun IEEE Boot Prom 3.25.0 1999/12/03 11:35
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0 with clock at 25 Mhz
kernel 2.4.20 compiled with egcs-2.92.11 (gcc2 ss-980609 experimental) 64 bit.
glibc 2.3.1 (32 bit userspace)
binutils 2.13.90.0.16
gcc 3.2.1
nfs client support compiled as modules



bests

Luigi


