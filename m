Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUIABNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUIABNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUIABNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:13:38 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:20897 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269017AbUIABKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:10:09 -0400
Message-ID: <4135216C.5090308@slaphack.com>
Date: Tue, 31 Aug 2004 20:10:04 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <20040826100530.GA20805@taniwha.stupidest.org> <20040826110258.GC30449@mail.shareable.org> <20040827210638.GE709@openzaurus.ucw.cz> <4133CDA6.4060105@slaphack.com> <20040831082144.GA535@elf.ucw.cz>
In-Reply-To: <20040831082144.GA535@elf.ucw.cz>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
| Hi!
|
|
|>| uservfs does
|>|
|>| cd foo.deb#uar
|>cd foo.deb/ar
|>| vs.
|>| cd foo.deb#udeb
|>cd foo.deb/deb
|>
|>and why would you want that, instead of just:
|>cd foo.deb	# for the ar
|>dpkg -i foo.deb	# for the deb
|
|
| Because I want to see contents of that .deb package, nicely parsed?
|
|
|>Just want to extract the tar file?  Maybe something like
|>cat foo.tgz/gunzip
|>In which case (of course) foo.tgz/gunzip has exactly the same directory
|>contents as foo.tgz
|
|
| Yes, that would work.
|
|
|>In fact, for just about any syntax anyone could suggest, I can't really
|>see why you can't just replace all weird symbols with a slash and a
|>symbol.  Instead of
|>	foo.tgz#utar
|>you have
|>	foo.tgz/#/utar
|>Only difference is, some things which used to require special tools can
|>now be serviced by less than what's in busybox.
|
|
| That would work, too. I do not get your comment about busybox.

Busybox is a bare minimum of unix tools, yet still includes things like
tar/bz2.  With such a system, you can use the most basic (sub-GNU)
versions of tools like cp, cat, sh, ls, and so on, to do much more
complex operations.  What's more, you can see everything you can do to a
file just by looking at it.  I can certainly imagine doing
	cat foo.tgz/metas/README
rather than a google search for tgz, followed by a "man tar" and "man
gzip". Assuming I know nothing about tar/gzip files, it's a lot easier
as a new user to have one common interface for everything -- including
docs.  Fewer commands to memorize, faster to learn new stuff.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTUha3gHNmZLgCUhAQKRJw/7BUEm41gKZGoVj7gOkcUVe/SRdTs9WtTL
jkjCX8Zzr/1nnAKTHLqNJEiAJ68Ndf+dRhDfL5y6dDHhOy/Dx+38SzsWz+dQnMJ0
Fiq5fFDO/DTd0UPecXYPhBrtVeCdfjyyENhgRgJud6D8F39qvLWrZFUsIkjAA3lj
nzZ/48jRPDWT/mF6JJmv0RfVvNtMWh9HUcW/i0+n4WZU1yFp6jyiF5ExCOP84z3x
yXQ4Q9hnjgt52MDJTrGsCDvfCSQscQilxvXbl0iaozquIhG9Jz1XNYpij2XUygFi
RDc1LA1k74VvbWahlkdfbTI+3P4qeMYGBblmfwXVDRwW0i4NH7X0/6xcnr1QjaK/
f/7EHBz0wnkIG4OpcGWzu9ik4WOR0WXapKrd938XC/mG+WzIluJlQsxG1A2HoRqg
R66E/mVMVvHJWnJjrW6s10WIemPiKnuXgeIVPifsw81DLXlZ3wxjlZU3iuo7xked
O6wNDFQBWQR8kv+EMDIt3gtbUdB+5KpxGR+Yli0AjxEdpdk3oZTfe5XQiNdJhcl5
xrcomVKXGvR96IlNUwHy1EsQk5LySMl101vJIS4z6i7lAIM5CQ1d6eOZrPp/DBOP
Rw0KoQaiPd3SKNMgoyWSKQL6h85i1PRUN62WH0T2NRU1fZ3EazpiRZr+fuaFqFT9
Wk2lkDvm5yw=
=ShWo
-----END PGP SIGNATURE-----
