Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269461AbUICAmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269461AbUICAmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUICAku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:40:50 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:45750 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269464AbUICAZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:25:47 -0400
Message-ID: <4137B9FC.7040708@slaphack.com>
Date: Thu, 02 Sep 2004 19:25:32 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Jamie Lokier <jamie@shareable.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	 <200408282314.i7SNErYv003270@localhost.localdomain>	 <20040901200806.GC31934@mail.shareable.org>	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	 <1094118362.4847.23.camel@localhost.localdomain>	 <20040902161130.GA24932@mail.shareable.org> <1094146912.31495.13.camel@shaggy.austin.ibm.com>
In-Reply-To: <1094146912.31495.13.camel@shaggy.austin.ibm.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Kleikamp wrote:
[...]
| Please don't tell me that we have expectations to run make from within a
| tar file.  This is getting silly.  tar does a pretty good job of
| extracting files into real directories, and putting them back into an
| archive.  I don't see a need to teach the kernel how to deal with
| compound files when user space can do it very easily.

Suppose I've got a tar file with an index attached.  Suppose it's
something like /usr/src/linux.  Am I expected to extract all code for
all architectures, with all drivers, all docs, etc?  Now, yes -- or I
have to figure out exactly which ones I need before I extract them
manually, one by one.

But with tar support for make (and so on), files can be extracted on
demand.  It's possible to do this in userspace, with named pipes, but
that's much slower and insanely clumsy.

This has further implications -- imagine a desktop, binary distro
shipped with all files except the very most basic stuff as package
archives.  They can all be extracted, on demand -- the first time I run
OpenOffice.org, it's installed.  If there needs to be post-installation,
that's handled by the .deb plugin (or whatever).

I don't know offhand how big OOo is.  I think it's something like this:
~ The installer is at most half (and maybe only a third) of the full
installation. That's a HUGE optimization!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTe5/HgHNmZLgCUhAQI5vQ/+NyU/tbW1Dyaf/OlDUEScH8jHghdcMPQQ
qcyBbzid9hMT0pm4fRX4CQJ/vm+VLhfvYzEmgRUCyNY3JybCKeS/EynRt/ybdblu
aB+hO8meFitBmAa7kYrj1UhWvoSvDSZgAwC9k50DYPuQO1kVZFjFYcPee1P54iwJ
UMn9RE01aeufCt1+jWFxhsEZKfNWvXDCaQtqa483A2AWWzklwF25ZW2kSfp6G+i0
g1jND8pPDkQcP8ujGTuDxEI8LsN62glNzVZ8MhPa65lZI1vO5Ll2dDL2QKgNwziK
MqtMMJD1d3HWa7QBHwMegJ0teR/hiqJ62SgQr3QpW4Xy9Ss0VUVH1HNuhxwPB2rl
YYomqw2yO/GGSDs5XuXm/cRM5E9d+nvu1V8bsrSa5LK/64Vlp6huLkLNvOZ3y6vK
38ELPBxbmIA3iWTgaYDPANX/vrpnA0K8JQU9M4LMveaHhxfEcDbH+iZHtpjsYqF3
allfHH2SEZRFlXGxKBNZsXTcrudAHjoyEOQ+UiI9QLCM83G4bFGr1WEGOEHmD0ry
hBETe8GkwuQK1CfxFm5obgFUmE4TwVRIWVD71EvoJFuBS+dlezO6GOZ5mDf91tSe
goPS2f/9XKwyYfOnEnnfXT17k5SYjTB9m0upi6q7dJpxvg1535E6N1nCqdLZzTcJ
mVkdhfFsUqI=
=YjJH
-----END PGP SIGNATURE-----
