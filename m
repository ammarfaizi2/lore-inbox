Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269987AbUICXz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbUICXz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269991AbUICXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:55:29 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:62340 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269987AbUICXzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:55:24 -0400
Message-ID: <4139045B.8080307@slaphack.com>
Date: Fri, 03 Sep 2004 18:55:07 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: Frank van Maarseveen <frankvm@xs4all.nl>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040902203854.GA4801@janus> <1094160994.31499.19.camel@shaggy.austin.ibm.com> <20040902214806.GA5272@janus> <20040902220027.GD23987@parcelfarce.linux.theplanet.co.uk> <20040902220242.GA5414@janus> <20040902220640.GE23987@parcelfarce.linux.theplanet.co.uk> <20040902221133.GB5414@janus> <20040902221722.GF23987@parcelfarce.linux.theplanet.co.uk> <20040902222650.GA5523@janus> <20040902223324.GG23987@parcelfarce.linux.theplanet.co.uk> <20040902225634.GA5756@janus> <41382EC0.8080309@hist.no>
In-Reply-To: <41382EC0.8080309@hist.no>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Helge Hafting wrote:
[...]
| You don't need kernel support for cd'ing into fs images.
| You need a shell (or GUI app) that:
| 1. notices that user tries to CD into a file, not a directory
| 2. Attempts fs type detection and do a loop mount.
| 3. Give error message if it wasn't a supported fs image.

You can argue this about FS plugins, too.  You don't need kernel support
for cryptocompress, for example.  Just have a fifo farm.  Every file
that has compression turned on is actually a named pipe, the original
file is hidden (starts with a dot), and you have a script running to
each fifo which runs zcat.

The kernel support (read: interface) is just cleaner in some ways.

In the loop mount example, it isn't universal -- the user can't CD into
a file if they use the wrong shell, and two different shells might make
two different mounts.  How many mounts before we run out of loop devices?

In the cryptocompress example, there's no caching or compress-on-flush
optimization, and it isn't entirely transparent to anything.  It doesn't
look like a file, it looks like a fifo.  ls will make it look yellow.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTkEWngHNmZLgCUhAQKmMhAAkECgB9hUCxM2vNn0NgzQmkuz028QsAEN
6B1ej6tCbVyT8whsVD2YA7rQH5UavUeUKjuFNJNwelXeEYqG8tbv4vcE1Z65U5tR
GUJkDxWwgjfx4JtE137VmWXcMWW/6FeIBbHuKFohDeBz2nBYmc3w/b4NjgT//JOG
0iUQGRDQcGxDuCYqMqCO8+m/LOSL9wbYDG+bXa4NxVAcghmxAhAJFiDpRDQHcYxX
CeUI7ZkFnNX/4A52YTAFyHQmeoQRX1SLxJsn0GH9mcf2Gsxs8AtoTQgtedDsz9I2
Ct6Dil6NfI94VfOx0EWa1y4I0p7UnFjAsye9zeElhumhocFvEcd5Lzn6SnCY/rQh
o4VukNKUtDE92noL62BZGgCc9ek3/YZivMMFfmQOrjKjfQxEMwSvyjKWIj9XPATT
FWkN7mZn7JSxluB1n1BtHTYvdieD65RGWF1aW1atJZ1r0z0xzy95LF/kqm9Rkigr
zv6+1j9ND79pBikYuq4ol916R9bW93TkriSYbENBP5dtMx4nXUYI6kRU53Y1UxZH
+mstouIpGr9MB7kHLLDYFFFV8upRJi2EQHA2sAtHOaMmjZUoJrbsIdA9n1r1LsKt
6Wjq8MofdyvZWXbzh9aGD4QkovNf6tw4UHAGzVf9Uh3n6mwh7yw4qyDC5h8dqMEe
P4wWkRawtHc=
=GC9p
-----END PGP SIGNATURE-----
