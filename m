Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbSIZGRb>; Thu, 26 Sep 2002 02:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSIZGRb>; Thu, 26 Sep 2002 02:17:31 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:62080 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262199AbSIZGRa>;
	Thu, 26 Sep 2002 02:17:30 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Wed, 25 Sep 2002 23:22:41 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org> <20020926055755.GA5612@think.thunk.org>
In-Reply-To: <20020926055755.GA5612@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209252322.44389.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 25, 2002 22:57, Theodore Ts'o wrote:
> Just to humor me, can you try it with gcc 2.95.4?  I just want to
> eliminate one variable....
I'll make a brief run with 2.95.4 shortly. I hope you understand my reluctance 
to do any more in-depth testing after the data loss I experienced

> > 3) While starting man(1), EXT3 began spewing messages in the form:
> > "EXT3-fs error (device (ide0(3,2)): ext3_readdir: directory #4243459
> > contains a hole at offset xxxxxx"
>
> what directory was 4243459?  You can use the debugfs's ncheck command
> to get back a pathname from an inode number?
/usr/share/man/man1

> Are you sure the filesystem was consistent before you started this
> whole procedure?
Fairly sure, I ran fsck to completion after my first run-in with dir_index.

> > The directory number stayed constant, but the offset was variable. fsck
> > -fD had -not- been run at this point.
> > 4) On reboot, fsck reported:
> > "Directory inode has unallocated block #xx"
> > multiple times. fsck seemed to fully recover the filesystem. I rebooted
> > again for good measure.
>
> What were the directory inode numbers, and what pathname did they map
> to?
Sorry, I forgot to mention that the directory inode was 4243459 
(/usr/share/man/man1), the same one EXT3 complained about above.

> > 7) While KDE was trying to start, EXT3 dumped the following to the
> > console: "EXT3-fs error (device ide(3,2)) in start_transaction: Journal
> > has aborted"
>
> This message will appear if previously some other part of ext2
> reported a filesystem inconsistency.  So it's a symptom, and not the
> root cause of the problem.
>
> > 8) I rebooted, and fsck said:
> > "Directory inode 131073,block3,offset 528: Directory corrupted"
> > I wasn't so lucky this time, and a good portion of my home directory got
> > eaten.
>
> Against, what was the pathnmae to the inode #131073?
/home/ryan (ugh)

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9kqe0LGMzRzbJfbQRAnUxAJ9NWR7sdunDTFo2brbAV4qGCdHhkgCfZ7yt
TiR5s6fv6E+CDDc4KayqFgU=
=ycMb
-----END PGP SIGNATURE-----
