Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRBSASj>; Sun, 18 Feb 2001 19:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbRBSAS2>; Sun, 18 Feb 2001 19:18:28 -0500
Received: from adsl-64-163-64-74.dsl.snfc21.pacbell.net ([64.163.64.74]:33028
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S129561AbRBSASM>; Sun, 18 Feb 2001 19:18:12 -0500
Message-Id: <200102190018.f1J0IBo08575@konerding.com>
To: linux-kernel@vger.kernel.org
Subject: problems with reiserfs + nfs using 2.4.2-pre4
Date: Sun, 18 Feb 2001 16:18:11 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I migrated some exported disks over to reiserfs and had no luck when I
mounted the disk via NFS on another machine.  I've noticed many messages
about reiser and NFS in the archives, but my understanding was that
it had been cleared up.  In particular, the Configure.help in 2.4.2-pre4
says "reiserfs can be used for anything that ext2 can be used for".

Here's my setup:

server box running RH71beta, kernel 2.4.2-pre4 compiled with gcc-2.95.2.

client box running RH71beta, kernel 2.4.2-pre4 compiled with gcc-2.95.2.

On the server, I built a standard kernel with NFS server, LVM, and reiser.
On the client, I built a standard kernel with NFS client.

On the server, the filesystem was created over an LVM logical volume.
When I mounted the server-exported filesystem on the client node,
there are no visible files or directories.  Reverting to ext2 fixed the problem.

I'd like to hear from people who have tried recent 2.4 kernels with RH7.1,
NFS, and reiser, to see if anybody has had luck.  

Dave
