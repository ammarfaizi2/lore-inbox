Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUAJRGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265277AbUAJRGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:06:38 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:51087 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S265274AbUAJRGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:06:35 -0500
Date: Sat, 10 Jan 2004 18:06:34 +0100
From: martin f krafft <madduck@madduck.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
Message-ID: <20040110170634.GA31201@piper.madduck.net>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040108151225.GA11740@piper.madduck.net> <1073671862.24706.13.camel@tux.rsn.bth.se> <20040109185348.GA24499@piper.madduck.net> <Pine.LNX.4.58L.0401101005470.3641@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401101005470.3641@logos.cnet>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marcelo Tosatti <marcelo.tosatti@cyclades.com> [2004.01.10.1306=
 +0100]:
> Did you ever try to disable the DMA as suggested?

I am sorry, Marcelo, that it took me so long.

In fact, I tried disabling the DMA and I could *not* get it to crash
without DMA. It did also not crash with DMA on for the onboard (VIA)
controller and off for the Promise. But when I turned DMA back on
for the Promise, it crashed again.

Martin Josefsson has suggested that the Promise controller may be
defective, and it certainly looks like that. I am now trying
a different Promise controller (20376 rather than the 20369, but
same driver), but it also crashes.

Thus, it looks like it's a problem with the driver, doesn't it? Or
either of the two disks. I will run badblocks over them on
a known-to-be-good controller when I get a chance.

If it's a problem with the driver, then I would be happy to help,
but I know nothing about these layers of the computer. I would,
however, give the controller away to someone eager to debug the
driver (provided the university will let me)!

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
a qui sait comprendre, peu de mots suffisent.
                                                 -- intelligenti pauca

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAADEaIgvIgzMMSnURAgj/AJ9cpnDJZbb0c+FON9hu0asPLgT1SgCfYhWq
Ote8IWVUkIiTP7Epf8uyGhA=
=bY41
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
