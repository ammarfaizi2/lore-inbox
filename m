Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261636AbSI0Hui>; Fri, 27 Sep 2002 03:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbSI0Huh>; Fri, 27 Sep 2002 03:50:37 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:64384 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261636AbSI0Huh>;
	Fri, 27 Sep 2002 03:50:37 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Fri, 27 Sep 2002 00:55:49 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020926235741.GC10551@think.thunk.org> <20020927041234.GS22795@clusterfs.com>
In-Reply-To: <20020927041234.GS22795@clusterfs.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209270055.52378.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 21:12, Andreas Dilger wrote:
> After that, we'd be happy if you could test with a loopback filesystem:
>
> touch /tmp/foo
> mke2fs -j -F /tmp/foo 100000
> mkdir /mnt/tmp
> mount -o loop /tmp/foo /mnt/tmp
>
> and run tests on /mnt/tmp instead of your root filesystem.

Okay, I followed those steps, and gave /mnt a fairly good fsstress'ing. No FS 
errors were encountered during the run. Upon umount and fsck, I got the 
following error:
"Problem in HTREE directory inode 2 (/): bad block number 3617593."

fsck then "optimized" inode 2 in pass 3A. Will beat up the filesystem some 
more ;)

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lA8ILGMzRzbJfbQRAtSnAJwNp9um7iTwK2cEpQo4OlGOGjTp4ACgj5lo
8JPvFW0jS18DOPFN5bBccUg=
=XzaF
-----END PGP SIGNATURE-----
