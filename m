Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269409AbUICA3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbUICA3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUICA2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:28:50 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:38838 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269409AbUICARX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:17:23 -0400
Message-ID: <4137B806.3030501@slaphack.com>
Date: Thu, 02 Sep 2004 19:17:10 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Spam <spam@tnonline.net>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <Pine.LNX.4.58.0409021045210.2295@ppc970.osdl.org> <1591214030.20040902215031@tnonline.net>
In-Reply-To: <1591214030.20040902215031@tnonline.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Spam wrote:
[...]
|   I doubt that something like file streams and meta-data can
|   successfully be implemented purely in user-space and get the same
|   support (ie be used by many programs) if this change doesn't come
|   from the kernel. I just do not see it happen.

The issue is not "many programs".  The issue is "all programs".

Even if the political issues were solved -- even if Linus said to us all
"Thou shalt use this library or suffer my wrath!" -- it'd have to be
everywhere.  Bash.  Perl.  Make.  Gcc.  Vim.

And btw, if it was political, you'd get no sympathy here.  ("Oh no,
everyone's using their own game engine!  We need to put the doom3 engine
in the kernel, now!")  No, _people_ solve political problems.  Kernels
don't.

Kernel support automatically adds support for a lot of features without
patching a thing.

There should be an interface in the filesystem.  And for certain things,
uservfs will be incredibly slower than reiser4 as that interface.
(Remember Linus' point about TUX and Apache.)

I'll say this again:  most of it -- all but the bare interface stuff --
should be in userspace.  In fact, let's all add this to our signature so
no one brings it up again. ("Oh no, they want to put tar support in the
kernel!" no, we don't.)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTe4BXgHNmZLgCUhAQKH1g//WXaL5xdLpX37TdgFhXidiRJGe/ojehj3
CZ7kseI9GkOBSxHt/yb5/xC6r+XT7JLlvJZybT7HLIRIxGp+WQHHBOD/xezWC+eX
OyRaOlkZ7o9HRQKhKNRIAwI4jgftpLhFUhePgibubS4UdxtzN2FWuULfKvMKIGHn
L4Zv4Dpje5ld7l7ce8jhfcURJ7AgAPwja3Tc7C38pmG+dSo2mj0I+YlCUED7mx3R
ZSv6WtdAUCZjnKv9hSQVruk3fjYZc4dLEGzGH1ZJsD1ZkH5wNmWds5gHGEvQrc4Z
9reNanTxy+0ECxndk2H/ukw5Wv011rJWubLy/CnaPakPrSvrsmmoEs8ZcVZavlg9
ABJX/NtyBVl/y8+6Eh6/BdAhQr30U+c/UZLNbOflmcPGPiJCiXfBuaX1OF+qffQ1
QQvAGPgO2R9egHJWqFhBaLHtBAmiXSRWUU4+4nPBYZ/X5dCmGuV46knQGHdqoAQc
l/qILh+spY09q9g118QbdnXBseiuVh/a+vf2GrbxbEMuWQu1kAI0DJbN0KKgUdtE
ZkmIqXYULO6QZsYk3L41ZyKyE7oFMUqbT0uxSQZUCjOcnuBpMn/PzwM0yMJeDUKx
295Yzq5lkqkGmHJHi7XGOOI5XVIPb++DWXXv9E6Bfgoj4TSZscfwM69PQRoSq0hu
iL9VOiyLRBU=
=zrvZ
-----END PGP SIGNATURE-----
