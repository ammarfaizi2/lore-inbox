Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269996AbUIDAPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269996AbUIDAPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269997AbUIDAPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:15:05 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:1413 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269996AbUIDANt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:13:49 -0400
Message-ID: <413908AB.90103@slaphack.com>
Date: Fri, 03 Sep 2004 19:13:31 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Spam <spam@tnonline.net>, Paul Jakma <paul@clubi.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	 <200408282314.i7SNErYv003270@localhost.localdomain>	 <20040901200806.GC31934@mail.shareable.org>	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	 <1094118362.4847.23.camel@localhost.localdomain>	 <20040902161130.GA24932@mail.shareable.org>	 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org>	 <1835526621.20040903014915@tnonline.net>	 <1094165736.6170.19.camel@localhost.localdomain>	 <32810200.20040903020308@tnonline.net>	 <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>	 <142794710.20040903023906@tnonline.net> <1094216718.2679.30.camel@shaggy.austin.ibm.com>
In-Reply-To: <1094216718.2679.30.camel@shaggy.austin.ibm.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Kleikamp wrote:
| On Thu, 2004-09-02 at 19:39, Spam wrote:
|
|>
|>
|>
|>>On Fri, 3 Sep 2004, Spam wrote:
|>
|>>> Yes, some archive types can't be partially unzipped either. But my
|>>> point is that it wouldn't be transparent to the application/user in
|>>> the same way.
|>
|>>It doesnt matter whether it is transparent to the application. It can
|>>be the application which implements the required level of
|>>transparency.
|>
|>>User doesnt care what provides the transparency or how it's
|>>implemented.
|>
|>  Indeed. I hope I didn't say otherwise :). Just that I think it will
|>  be very difficult to have this transparency in all apps.
|
|
| You're missing the point.  We don't need transparency in all apps.  You
| can write an application to be as transparent as you want, but you don't
| need every app to to understand every file format.

You don't need every app to understand every filesystem, either.  Come
to think of it, why would I want anything other than CD burning software
and file browsers to understand a CD drive?

Let's all just wait -- quietly -- for the powers that be to work out
whether it's feasable and sane to support it in all apps.  Because
wouldn't that be better?

|> Just
|>  thinking of "nano file.jpg/description.txt" or "ls
|>  file.tar/untar/*.doc".
|
|
| I don't do much image editting, but I'm sure there are applications that
| let you edit the description in a text file.  You can even create a
| script that extracts it, runs nano, and puts it back into the jpeg.

That is a PITA.  Because you'll need to make more scripts.  And still more.

Say you want to grep for a jpeg with a particular description.  Say you
want to copy the description from one jpeg into another.

Maybe you could make a general-purpose command, like "jpeg_run", which
runs a command on the jpeg description, but it'd still be hackish, slow,
and more to type and remember.  Consider that you might have no idea
what "jpeg_run" is called, but you can always do "ls file.jpeg/metas" to
find out how to edit it.
|
| This works for me:
| tar -tf file.tar | grep '\.doc'

And then you need to run "tar -tf" a minute later, this time looking for
*.xls.  Maybe file.tar is actually a several gigabyte file.tar.bz2.

|> Sure in some environments like Gnome it could
|>  work, but it still doesn't for the rest of the flora of Linux
|>  programs.
|
|
| Just choose the right program.  tar groks tar files, not ls.

tar groks tar.  bzip2 groks bz2.  gzip groks gz.  "mount -o loop" groks
images.  zip groks zip.  rar groks rar.  openoffice groks .sxw, unless
staroffice does.  xmms can read id3 info from mp3s.  gcc compiles C.

If the file is an object, it's easier.  You can ask the file what it is,
and what you can do with it.  And you can tell it to do certain standard
things.  You can do all of this while reading almost no documentation on
what the file is.  At the end of the day, it won't matter to you whether
a file is zip, rar, or tar -- it's an archive, and you can extract it by
copying files out of its /contents directory.

Your way (the traditional way) means you have to learn to use which
program is the right program and how to use that program, and you'll
have to remember it constantly.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTkIq3gHNmZLgCUhAQJaNRAAnp/o0Wr+SJK5tkgYFCuc+CKIP+eALJo/
9wHnqK0nLdnji+vG0Czd9TUj1vWtoMrUichAwFoguMHHg3VeZGu61YwZoZ4idLNM
QbZ+CuQdUygNmyT0byGMFemP+cSbyvff1PRMy2BlSHKW3gUhvnQyggLGVKxpMRWf
VNnEHvkvJeA9PpEm6QGi1VRNp5bc0+Ocl4kO4CJk5ZYZ9D+BV6NwN/MZwqwlsu+Y
RZsYYEa6mLiCnU4rEo0tEAvvwMdC0e/9s9TQMcmJbT6JnybkWIRFMrTS4pmSabKg
uYGG9p1WrX8/V8WRNnaodlvx35gRPQj5S5SWDBoSWr999nmq31Y5RZ9QwbVj0d+U
yB4yNu0NpvFBJfwg8nVIKUa+bhPLCkdY5w+GnlEYGweSN20FYOaLiqiPtXBqJm8a
PP+8OCL35zy+1X7t/tq+JG/K91fYbECPR/qrAyHDXzNSuxdqidvBjfsEPBHOGwu6
RpsPoKyEvkzdXgauotWbVzWLt1ijGmYd/8Uk19OnmiloggViQhUWAJTIVGcvMNt8
Tnk8ESQMzGHbbVOIu3gB6DZD6P0IEEN4L6+gOZWoYqe2nvaYKvIL1My/i4BMU5Ml
cxDkzzeq58iVK07Has8lwgFp0U9iD1LrbIT5p0ZJn/52EXqlX4dJCYSSNaHzUqE8
hcLG4aDELEI=
=Wcyv
-----END PGP SIGNATURE-----
