Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262413AbSI2ILu>; Sun, 29 Sep 2002 04:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSI2ILu>; Sun, 29 Sep 2002 04:11:50 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:9344 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262413AbSI2ILt>;
	Sun, 29 Sep 2002 04:11:49 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: chrisl@gnuchina.org, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix htree dir corrupt after fsck -fD
Date: Sun, 29 Sep 2002 01:16:57 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020928141330.GA653@think.thunk.org> <20020929070315.GA6876@vmware.com>
In-Reply-To: <20020929070315.GA6876@vmware.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209290117.02331.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 29, 2002 00:03, chrisl@gnuchina.org wrote:
> I already do the initial test and it fix the problem in kernel and
> e2fsck.

Still broken here. The short directory inodes are cleared up, but I'm still 
getting various errors from fsck

Case 1:
"Problem in HTREE directory inode 2 (/): bad block 3223649"

Case 2:
"Inode 2, i_blocks is 3718, should be 2280
Directory inode 2 has an unallocated block #377
Directory inode 2 has an unallocated block #378
Directory inode 2 has an unallocated block #379"
etc

This is a completely fresh loopback EXT3 filesystem, untouched by fsck -D, and 
normally unmounted.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lrb9LGMzRzbJfbQRAhpSAKCbkbyiwM8PnpAbN2FvU6tRHM1urwCdEzFK
WSwjN6jC+0QI0NnJzKc0rX8=
=HHtV
-----END PGP SIGNATURE-----
