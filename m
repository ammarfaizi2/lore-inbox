Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbQLWPWP>; Sat, 23 Dec 2000 10:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQLWPWF>; Sat, 23 Dec 2000 10:22:05 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:24072 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130011AbQLWPV5>; Sat, 23 Dec 2000 10:21:57 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4-ac2 - part of diff fails
Date: Sat, 23 Dec 2000 07:52:33 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: daniel@kabuki.eyep.net
MIME-Version: 1.0
Message-Id: <00122307523300.01837@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Stone wrote:
>linux-2.4.0-test12 + reiserfs + test13-pre4 + reiserfs makefile fix (only
>changes fs/reiserfs/Makefile) + netfilter patch-o-matic stuff (only touches
>net/ipv4/netfilter) + test13-pre4-ac2.

I was able to patch and build 2.4.0test13pre4-ac2.  I did not see the problem
with smp.c which existed with the earlier test13pre3-ac3.

[root@localhost src]# date;uname -a
Sat Dec 23 07:33:48 MST 2000
Linux localhost.localdomain 2.4.0-test13pre4-ac2 #3 Fri Dec 22 22:06:06 MST 
2000 i686 unknown

1 Script started on Fri Dec 22 18:28:38 2000
2 [root@localhost linux]# patch -p1 <patch-2.4.0test13pre4-ac2
3 patching file CREDITS
[snipped]
28 patching file arch/i386/kernel/setup.c
29 patching file arch/i386/kernel/smp.c
30 patching file arch/i386/kernel/smpboot.c

I did things in this order:

tar zxvf linux-2.4.0-test12.tar.gz 
patch -p0 <test13-pre4
cd linux
patch -p1 <patch-2.4.0test13pre4-ac2

Found problem with build, fixed it, submitted patch.

cd /usr/src
patch -p0 <linux-2.4.0-test12-reiserfs-3.6.23-patch
patch -p0 <reiserfs-Makefile-patch

I then built a kernel with reiserfs-3.6.23 which I'm running now.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
