Return-Path: <linux-kernel-owner+w=401wt.eu-S965294AbXAHB2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbXAHB2f (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbXAHB2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:28:35 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48993 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965294AbXAHB2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:28:34 -0500
X-Sasl-enc: gai9el9MFQNqVJC8ZbqGvmrQQCK1gqIm9JUIPP435YkS 1168219515
Message-ID: <45A19F3A.5030800@imap.cc>
Date: Mon, 08 Jan 2007 02:32:42 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings
References: <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr> <20070107204834.GU24090@1wt.eu> <20070107233750.GL20714@stusta.de> <20070108003857.GE435@1wt.eu>
In-Reply-To: <20070108003857.GE435@1wt.eu>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEE18E2923C171351FAE4A07"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEE18E2923C171351FAE4A07
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 08.01.2007 01:38 schrieb Willy Tarreau:
> I'm not blaming UTF-8 per se, but people who still believe in encoding
> *whole documents*. Copy-paste, text insertion, git output, etc... every=
thing
> has a good reason not to be in the same encoding as what your MUA belie=
ves.
> If major MUAs still have problems with UTF-8 10 years after it was intr=
oduced,
> it's clearly the proof of a flaw in the initial design.

Actually it's working amazingly well. In the past 15 years the frequency =
of
character encoding problems has gone from "frequent, that's just the way =
it
is, if you want your text to go through unharmed then stick to 7 bit ASCI=
I"
to "rare, it normally works, if it doesn't then we've got a problem to so=
lve".
Copy/paste? Works for me! Mail forwarding? Works for me!

The only thing that doesn't and cannot work is automatic conversion of da=
ta
with unknown encoding or with incorrect encoding information, and that ha=
s
to be solved at the source. If you store differently encoded text in git
without labelling it accordingly then there is just no way to retrieve it=

consistently. There are two ways out of that - a complicated one: storing=

encoding information with every piece of text, and a simple one - declari=
ng
a single internal encoding to which everything must be converted upon ent=
ry
into the database. Guess which one has more chances of working well.

> And I'm not even
> discussing the stupidity which requires that you read a whole text to g=
et
> its number of characters !

Personally I find the requirement to know the number of characters in a t=
ext
rather unusual, so I wouldn't base a decision for an encoding on that. In=

fact, I cannot remember ever really wanting to know the actual number of
characters in a text. The number of bytes occupied on storage, ok. The
number of letters, of words, of lines, perhaps even the number of printab=
le
characters, all potentially interesting, depending on the application.
But the raw number of characters? I don't know what that might serve for.=


HTH
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigAEE18E2923C171351FAE4A07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFoZ86MdB4Whm86/kRAiiFAJ4kBk2zO/WX+547TiANOY6orjBJPQCdHjWq
3i1V6a1fUhtgle+aIwVszzs=
=dKN2
-----END PGP SIGNATURE-----

--------------enigAEE18E2923C171351FAE4A07--
