Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269785AbUIDGED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269785AbUIDGED (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbUIDGEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:04:02 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:22406 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269785AbUIDGD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:03:56 -0400
Message-ID: <41395AB9.1090804@slaphack.com>
Date: Sat, 04 Sep 2004 01:03:37 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Boyer <flar@allandria.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeremy Allison <jra@samba.org>,
       Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain> <1093804864.8723.15.camel@lade.trondhjem.org> <20040829193851.GB21873@jeremy1> <20040901201945.GE31934@mail.shareable.org> <20040901202641.GJ4455@legion.cup.hp.com> <1094118524.4842.27.camel@localhost.localdomain> <20040904011012.GA27405@pants.nu>
In-Reply-To: <20040904011012.GA27405@pants.nu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Brad Boyer wrote:
| On Thu, Sep 02, 2004 at 10:48:46AM +0100, Alan Cox wrote:
|
|>What I don't understand is the tie between Linux having such streams and
|>Windows doing it for Samba to work. Netatalk has always handle this for
|>Macintosh and portably. Presumably any Samba support would need to
|>handle OS's without wacky files for portability too ?
|
|
| I'm not 100% sure on the samba side, but I think there is a pretty
| significant difference. On the Mac, the problem of copying forks and
| metadata onto non-Mac systems was recognized early on. There are several
| standard formats for serialized versions of this data. If you take the
| files that netatalk writes and copy them directly to a Mac separately,
| there are tools that can convert them back to the original format with
| all the data intact. I've never seen such a thing for NTFS named streams.

I had an idea for how to solve this.  Search the archives for
"serialization" or "serialize".

Basically, it involves creating a better interface to a better "dump".
You do
	cat foo/serialize > foo.img
and send foo.img over the network.  Or you just tell mutt/scp/whatever
to grab foo/serialize instead of foo.  Can't be worse than a mac
resource fork, and it looks more user-friendly to me.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTlauHgHNmZLgCUhAQK7Iw//SAi7I84OIz4xHh5S7i1xc+JugPvELyh2
dvrVkETvQlvRcABZ0GYlCQQPPzL+QcTVnruMRAUZGrGCPJdTkxfae41tX5KDS8/4
OpPWEDki+FSJrv+Mn9Pbm3I5Bxlhu0+nuNOIS0HSULo+/IBV4f/ldv8TUKSbXeXJ
YjAXJJECpWTlYwF8sTvM/ALHpo+6xEtJq5gQxoUFnw4Pio8eycalS9m2cDs/N6rq
PYcOjb7pWjGEk+9qimmwIcX5LnBXl8L9OhXqMQoR3Of+blniIrEOtg/0WLrwzu62
rW+rBxDAfoDxIZZvquf/gyJ6stO8QzGeQqoxxTUXhbI5PUtD+qGO+tWT6+/EljHF
qNri65JwB8PetbqdjWmsTO3V+FVSRy3hu4/vTNpnmwnR8H+yilWWDc7Tnsjql+dh
9j4ycfT5xDAA9dC6APOSV5AEgI9z8FntQZzOCPe1lyLD7Qwjdak+3Nw2I3yNS+Pl
Xa5ijSm3IKJ+JqKpZKRzCRyXRQdeAj2kGaWQP4Ui3D/RwBEHtn7shwdJ9Hku6KkN
9ZyiTPqY5XGiyLrJWqRc9MraepGhuxxtYcq65A+vdJq2fxA5+XRF8UGbYc9KW5lF
1fYSXA2DBNJjeNEvZw8LWI54OrIMSlhj3dWLX8WkkXog2gWO7ly0E6OiA0odZV6M
i9sDeRClqlM=
=CFb4
-----END PGP SIGNATURE-----
