Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269977AbTGNKBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269992AbTGNKBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:01:55 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:22538 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S269977AbTGNKBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:01:54 -0400
Subject: Re: airo_cs load error
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Matthew Koch <MatthewK@hsius.com>, Russell King <rmk@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1056051882.2354.3.camel@iso-8590-lx.zeusinc.com>
References: <1055941189.861.1.camel@localhost>
	 <1056025814.3074.8.camel@neutrino>
	 <1056051882.2354.3.camel@iso-8590-lx.zeusinc.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JBFVS5G6FTooLeaw6KqN"
Message-Id: <1058177339.773.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 20:08:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JBFVS5G6FTooLeaw6KqN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hey there Tom,

sorry for the delay.
i just patched the 2.6-test1 with this patch, and it sure does remove
the "scheduling when atomic" errors

I still have the problem that i mentioned in "mis-identified cisco
aironet pccard" where the cisco card is recognised as a memory card at
bootup. I don't know where to start with tracking this problem down - if
you have suggestions for me to look at, i'll have a go :)

cheers
sven

On Fri, 2003-06-20 at 05:45, Tom Sightler wrote:
> > Jun 19 08:22:21 neutrino cardmgr[2280]: executing: 'modprobe airo_cs'
> > Jun 19 08:22:21 neutrino kernel: airo: Doing fast bap_reads
> > Jun 19 08:22:21 neutrino kernel: airo: MAC enabled eth1 0:9:e8:62:c0:75
> > Jun 19 08:22:21 neutrino kernel: eth1: index 0x05: Vcc 5.0, Vpp 5.0, ir=
q
> > 3, io 0x0100-0x013f
> > Jun 19 08:22:21 neutrino cardmgr[2280]: executing: './network start
> > eth1'
> > Jun 19 08:22:21 neutrino kernel: bad: scheduling while atomic!
>=20
> Could you try with this patch, it should fix the "scheduling while
> atomic" error in airo.c.
>=20
> It actually also includes a few other things, mostly cleanups and fixes
> pulled from the CVS version of the airo.c driver for 2.4 so I don't
> think it will cause you any harm.  It has worked well for me on three
> fairly different cards, (a PCMCIA, a PCI card, and a Mini-PCI).
>=20
> Later,
> Tom
>=20

--=-JBFVS5G6FTooLeaw6KqN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EoE7PAwzu0QrW+kRAoV9AJ9uno+QXJZBHZH4qV590QXINZISAwCdHaoe
Vf87ZuxmDj6CRLxH30IfCVA=
=5o0M
-----END PGP SIGNATURE-----

--=-JBFVS5G6FTooLeaw6KqN--

