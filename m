Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUIABQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUIABQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUIABQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:16:03 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:26273 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S268882AbUIABOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:14:38 -0400
Message-ID: <41352279.7020307@slaphack.com>
Date: Tue, 31 Aug 2004 20:14:33 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
In-Reply-To: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Horst von Brand wrote:
| Pavel Machek <pavel@ucw.cz> said:
|
|>David Masover <ninja@slaphack.com> said:
|
|
| [...]
[...]
| You do need extra tools anyway, placing them in the kernel is cheating
(and
| absolutely pointless, IMHO).

Repeat after me:  plugins in kernel does NOT equal tools in kernel.

It's not hard to, for instance, imagine a generic plugin for archive
manipulation which talks to a userspace daemon/library.  The kernel
doesn't know anything other than (maybe) a list of extensions that are
archives.  All else is handled in userspace -- the idea that "this is a
zipfile" and "zipfiles can be extracted with the 'zip' command" are all
in userspace.

It's not about the kernel, it's about the interface.  And see my other mail:
	cat foo.zip/README
	less foo.zip/contents/bar.c
is a lot easier than
	lynx http://google.com/search?q=zip
	emerge zip
	man zip
	unzip foo.zip
	cat bar.c
which already assumes quite a lot of expertise.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTUieXgHNmZLgCUhAQLj8Q//VEuRWg9RB/PVg/M1t36SraKIRdbrgGq6
0DYLZwwVWkfz+UKGhUkACNGQzhHG3ySn/lRjqXCsJhzMOzfgmte2CwgGxunHYqdp
W69OSZ1vv0ZLpdpzEkVdMfRhhg8RBL54Ewj6fQu7G1ZzJ0J0HUFCEZIsVoL4zJfk
+GFl4M+vvc+152HipEDsvrrPasc0dSxmryyzPbyABrfPRi3l2E3Okfewn/4MCC1E
H/L04nmvJQ2OSZYu1eSMSpnLrgQdZJbYefRuSinpqfKhjpwQXjj2rnfcPm+xc3hh
FDMlAUPA/DAlthTuhxd9+8iDPEARY57/FAMFTalYVhBEv0NWieMMn9V6R8BbnhZW
8y9EWu0Nvoowg9qElkVjWEt5M1Rbeuq4TDviyVyPYg/KcTKDGpjLuyQQbWv6hMVM
WAx6THtRK8Ji/XLCj4Kh6qDOEYP1nuwqLYSWv13BtNAJ3bVeKryOJ4Er4AmuJomA
uydBPQVsrtzTNmk7Eul2ZjrxXdESpUnUIAbu7H1Gbn51uP4rQTdlXkdPTv6s/wvG
OSOMWKs28GBFsG3+IJLnoN2wxrffpgTBEAaPwbh9TRFKLIH+pkCFSx2cIkTj93nr
RjETFObjYdJGhGygrq0xOmN5e7iprdxhxd3/+fvjQxnZGxXT3fZLUwhVX9/zhaXG
cxau2Onr3jc=
=MrR9
-----END PGP SIGNATURE-----
