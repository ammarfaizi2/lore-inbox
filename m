Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCJQCC>; Sun, 10 Mar 2002 11:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293081AbSCJQBw>; Sun, 10 Mar 2002 11:01:52 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:62732 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S293076AbSCJQBg>; Sun, 10 Mar 2002 11:01:36 -0500
Date: Sun, 10 Mar 2002 16:01:34 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.6: JFS vs gcc 2.95.4
Message-ID: <Pine.LNX.4.33.0203101600010.31738-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't build jfs in 2.5.6 with gcc 2.95.4 from Debian
testing:

gcc -D__KERNEL__ -I/home/matthew/kern/linux-2.5.6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6  -D_JFS_4K -DKBUILD_BASENAME=jfs_imap  -c -o jfs_imap.o
jfs_imap.c
jfs_imap.c: In function `diAlloc':
/home/matthew/kern/linux-2.5.6/include/asm/rwsem.h:169: inconsistent
operand constraints in an `asm'
jfs_imap.c: In function `diNewIAG':
/home/matthew/kern/linux-2.5.6/include/asm/rwsem.h:169: inconsistent
operand constraints in an `asm'

I don't really speak gcc asm, so I don't know where to start
on this.  Is it a known issue?

Matthew.

