Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269455AbUICArE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269455AbUICArE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUICAjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:39:51 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:51126 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269455AbUICAfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:35:22 -0400
Message-ID: <4137BC3C.4010207@slaphack.com>
Date: Thu, 02 Sep 2004 19:35:08 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Bergman <steve@rueb.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org>	 <200408282314.i7SNErYv003270@localhost.localdomain>	 <20040901200806.GC31934@mail.shareable.org>	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>	 <4136A14E.9010303@slaphack.com>	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>	 <4136C876.5010806@namesys.com>	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>	 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay> <1094154744.12730.64.camel@voyager.localdomain>
In-Reply-To: <1094154744.12730.64.camel@voyager.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steve Bergman wrote:
[...]
| In following this thread, I may be missing huge chunks of concept.

You are, but don't worry.  You aren't the only one.  (Before I get
assaulted for this, let me say that there are people on this list
smarter than me and I miss concept chunks quite frequently.)

| 1. The file as directory thing adds complexity that the administrator
| has to deal with.  Symlinks are useful, but it's still aggravating to
| tar off a directory structure, take it somewhere, and then realize that
| all you have is links to something not in the archive because you didn't
| get your tar switches just right.  Now we're talking about adding
| another set of "files which are not really files" to the semantics.
| More complexity.  I'll take simplicity over some ivory tower ideal of
| "unified name space" any day.

You want simplicity?  How does this strike you:
	scp file/serialize daemon@bsd:~/file.img

You don't have to worry about "file is not a file".  You don't have to
worry about fifos or device nodes.  You don't have to worry about files
in files.  In fact, you don't have to worry about any new kind of file
added, ever.

| 2. The use of multiple streams within files by Linux apps would make
| Linux as cross-platform unfriendly as MS is trying to be.  Say these

The use of ext3 as a filesystem isn't cross-platform.  Every disk-write
is platform-specific!  We should all be using captive-ntfs instead!

Seriously, this isn't hard -- it's called a "library".  And anything as
bloated as OO.org has got to already be modular enough to add this sort
of thing.

| features start getting used and you copy an OO.org document from a Linux
| box to a BSD box.  It's broken.  Of course, OO.org wouldn't use the
| streams in the first place because it would destroy their cross platform

If that was so, OO.org wouldn't use a GUI, because that isn't
cross-platform.  They'd use a purely commandline interface, because that
is universal.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTe8PHgHNmZLgCUhAQKiNQ//Zo6BLeGK6/GBbYzcgyp51Ra4fRf2xoVo
0aOve2vinVl+RRzFGWSa66p+/rHd339BhxTPYhlLkm9SWbU9Et80J0R/bySYtc17
RmUHhmukSEXhJx+py7Vc99jXr03zr2fNaA3UBIfpMiAlj1UB2yOls5iwJgqfPVnX
+YwYcVRfZXc3KWqH9SGcY9q+NX38wXoQh3rbeJ0OEzaIxnvPWlMvUFEN4OF92cub
on+n0h+JKptwtXOhLh9HaKAzG9fDhy4tJwmN3GIemSzKpEZ0ZGS4+Pz4dcnRXP+S
C6cMxpsmCnm5WVzmeoyBYBY28Fmnji00ShvxDGRFYOp48RPFhNaoMbVhLkQFoYfX
a5k3iedhbjaWOLmpfNGaDNdpKFtqD3LJO1xOSkXz3sndAiLW9ArKhuu2+63ASAQy
wlFknP09k13UHzD2iL5kPUPzy0A/BLqZPSpX4tXnF0xcSp4X8RoLnyu8BmrqaTjG
fi7FkEsoVEB7BWslNNtKrH596sDhWCP+BQdkAYqOBh0fzSIJ+0uyo2nJRw3d8FEi
/ynNVUqZEN8Xj08WHI+ucwUmRpTnh6spwXZC42K2tokAQa+95nSTegx3uNkypcGU
l12s+BtIHFB25BKDaBReyGoBqUj0sdFvoHVkRNc/3DNY6MfRHV3rdgjz5NieT4gH
uwMwLNstv8c=
=O3r8
-----END PGP SIGNATURE-----
