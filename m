Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVDKLjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVDKLjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDKLjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:39:07 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:31417 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261784AbVDKLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:38:10 -0400
Date: Mon, 11 Apr 2005 13:38:02 +0200
To: Pavel Machek <pavel@suse.cz>
Cc: Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050411113800.GC5610@vanheusden.com>
References: <4259B474.4040407@domdv.de> <20050411102550.GD1353@elf.ucw.cz>
	<20050411103608.GA5610@vanheusden.com>
	<20050411110152.GD1373@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20050411110152.GD1373@elf.ucw.cz>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Tue Apr 12 12:17:30 CEST 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.8i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > > The following patch adds the core functionality for the encrypted
> > > > suspend image.
> > > [Please inline patches, it makes it easier to comment on them.]
> > > You seem to reuse same key/iv for all the blocks. I'm no crypto
> > > expert, but I think that is seriously wrong... You probably should use
> > > block number as a IV or something like that.
> > Or use a feedback loop: xor your data with the outcome of the previous
> > round. And for the initial block use 0x00...00 for 'previous block'-
> > value.
> I'd like to retain ability to read suspend image in any order (so that
> code can be reused for swap encryption, etc).

In that case: encrypt the blocknumber with the key, and then use the
outcome as IV for the encryption of the data. Or calculate a hash over the
blocknumber and use the outcome of that as IV. Don't use the blocknumer
directly.


Folkert van Heusden

Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden.
--------------------------------------------------------------------
 UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)=20
 a try, it brings monitoring logfiles to a different level! See    =20
 http://vanheusden.com/multitail/features.html for a feature-list. =20
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iIMEARECAEMFAkJaYZg8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiunlIAnRIZ+YSC
15S7de0d45y+4TSYbp2TAJ4xmb8G9kiKnoCbeDf3bBEL4daXtQ==
=7wQQ
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
