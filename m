Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUFMIjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUFMIjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 04:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUFMIjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 04:39:35 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:29646 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S265027AbUFMIjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 04:39:33 -0400
In-Reply-To: <40C58781.1060200@draigBrady.com>
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk> <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com> <40C58781.1060200@draigBrady.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14--712920252"
Message-Id: <213F9E7F-BD15-11D8-AAF6-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       cijoml@volny.cz
From: Daniel Egger <de@axiros.com>
Subject: Re: jff2 filesystem in vanilla
Date: Sun, 13 Jun 2004 10:39:05 +0200
To: P@draigBrady.com
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-14--712920252
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 08.06.2004, at 11:31, P@draigBrady.com wrote:

> Can you give more detail on how you were able to "kill a card".

Write to it every now and then using a touchy filesystem
like ext2 and it will certainly break.

As soon as a CF card starts developing bad blocks you better
(trash-)can them because they're losing reliability very
quickly.

> Were there hot spots in those filesystems?

Yes, the only place that is written every now and then is
the configuration in /etc, everything else is mostly read.
Of course with ext2 such changes will always end up in the
same physical place on disk which can chew up the few 10K
to 100K guaranteed writes last for just a really short
amount of time.

There're a few more problems with ext2/3 which make it a
rather unpleasant filesystem for often rebooted systems
with r/w mounted partitions on limited write-cycle media.

Although JFFS2 on CF seems like a kludge at first it works
much better than expected and never let us down so far
(after changing to CVS, that is!) and makes it the top
choice for quite a number of applications that want to use
spindleless drives and need some (cheap) amount of capacity.

Servus,
       Daniel

--Apple-Mail-14--712920252
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMwSrzBkNMiD99JrAQJiFwf/ftxvZhbl0oETHiInUbB98pZO4UD82Ucu
mg2rEWCVrjaqThkLJowAUMyIva8EsD5efojs4VMEuOcPHV0EVBwFr92rpT+kgJmU
inOsW+Vb1UMGyhtWgAtyWb6E8U3IGjSEdgCKYfP+LAgffrIc7gfr3JvITuP/Nkv4
xmV27JwgZDWJ+U5ZM+yf92r3IZD4bhKUvlzLth3kfc+J+i2ZQlJSWlL6Rvqlull0
Q6HuvB9MH4FcuHsxn0gMYMCEQn48SA/l7P+aGJp/gsxp+8INvSCkz6edeYB5I2h/
nyuC+h+iJ9RWyRpN/c+PBLe/pLYmZ01SpLiEdiWCBckBJeScdk4vhQ==
=58rY
-----END PGP SIGNATURE-----

--Apple-Mail-14--712920252--

