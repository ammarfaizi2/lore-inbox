Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265358AbTL0LJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 06:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTL0LJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 06:09:06 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:21647 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265358AbTL0LI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 06:08:58 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
In-Reply-To: <8240000.1072511437@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v1ie5bFjVyaxM7RYYj05"
Message-Id: <1072523478.12308.52.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 13:11:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v1ie5bFjVyaxM7RYYj05
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 09:50, Martin J. Bligh wrote:
> Something appears to have broken OSS sound emulation between=20
> test2 and test3. Best I can tell (despite the appearance of the BK logs),=
=20
> that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
> understands the sound architecture better than I can fix this?
>=20

I wont say I understand it, but a quick look seems the major change is
the addition of the 'whole-frag' and 'no-silence' opts.  You might try
the following to revert what 'no-silence' change at least does:

--
 # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
 # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
--

and restart xmms.  If that do not work, then one of the alsa guys will
have to have a look.


--=20
Martin Schlemmer

--=-v1ie5bFjVyaxM7RYYj05
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7WjWqburzKaJYLYRAugoAJoC0b5VAlo7QQ5YhYrhR5FeT7lzaQCeI4V7
QkxPc42WHB8vkuPnZ6oC+BM=
=ZzUw
-----END PGP SIGNATURE-----

--=-v1ie5bFjVyaxM7RYYj05--

