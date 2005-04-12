Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVDLXK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVDLXK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVDLUdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:33:20 -0400
Received: from lug-owl.de ([195.71.106.12]:44725 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262237AbVDLStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:49:08 -0400
Date: Tue, 12 Apr 2005 20:48:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412184859.GM4965@lug-owl.de>
Mail-Followup-To: "Kilau, Scott" <Scott_Kilau@digi.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
	linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
References: <335DD0B75189FB428E5C32680089FB9F12215A@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F12215A@mtk-sms-mail01.digi.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-12 11:42:31 -0500, Kilau, Scott <Scott_Kilau@digi.com>
wrote in message <335DD0B75189FB428E5C32680089FB9F12215A@mtk-sms-mail01.dig=
i.com>:
> The JSM driver was forced to be stripped down when being submitted
> to the kernel sources, and many extended features removed as so to be
> included into the kernel, as the extended features added special ioctls
> and special /proc (/sys for 2.6) files.

There's a consensus that if there's *any* choice, new /proc files as
well as new ioctls shall not be introduced. So if there's management
needed (disclaimer: I don't own such a card), then this interface needs
to be introduced as a generic interface, which might be used by any
further drivers. We've just had this situation for some RAID cards,
where the vendor wanted to introduce a (specific for his devices)
interface. Either do it correct (as of best current practice), or don't
do it at all.

> > I didn't think that you would remove them. I read the posts and
> > wondered *why* they wanted the management pieces removed.
> > One reason to use the Digi products is for the sole fact that
> > they *can* be diagnosed.
> > I'm glad that Digi is still focused properly.
> > I agree that committing the drivers to the main kernel
> > is not the way to go if you are forced to remove dpa and ditty.

Well, again, if this features can only used by your hardware (and
there's proof that no other vendor will add these features *ever*), then
an own interface is okay. But if there's a possibility that a different
vendor *might* introduce these as well, then a generic interface needs
to be build (with first of all only one user: your driver).

> I will let the chips fall where they will, and clean up the mess that
> will soon be introduced into my driver world. =3D)

That's a plan. Good to head :-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXBgbHb1edYOZ4bsRAhhPAJ9AjaK/cILY0ewr7hoMBXT9Y/JITwCfbpw9
3WDq6YCrTh4ddRFlzE+UB98=
=QxPP
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--
