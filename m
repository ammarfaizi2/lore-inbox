Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSGPVjr>; Tue, 16 Jul 2002 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSGPVjq>; Tue, 16 Jul 2002 17:39:46 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:24642 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S318026AbSGPVjo>; Tue, 16 Jul 2002 17:39:44 -0400
Date: Tue, 16 Jul 2002 23:42:39 +0200
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tyan s2466 stability
Message-ID: <20020716214239.GE23954@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0207161020280.2603-100000@tyan.doghouse.com> <1026834468.2119.61.camel@irongate.swansea.linux.org.uk> <20020716205113.GC23954@nbkurt.etpnet.phys.tue.nl> <1026857446.1688.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <1026857446.1688.76.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Tue, Jul 16, 2002 at 11:10:46PM +0100, Alan Cox wrote:
> On Tue, 2002-07-16 at 21:51, Kurt Garloff wrote:
> > Strange SMI stuff, maybe?
> > Bugs with PCI arbitration that are recovered from but take time?
> >=20
> > You've probably already looked into those, though.
>=20
> I've read the errata but thats not given me any clues. The box is fast,
> including PCI bandwidth measurements but neither PCI card or SCSI
> streaming to tape or CD-R works well. The motherboard IDE works a treat
> and the 64bit slots give me excellent performance (but thats a raid card
> so I can't yet use it for tape)

c't, a good german computer mag, has done some test of Dual MoBos a month
ago. (c't, 12/02, p.188). They performed some low-level benchmarks ... on
PCI ... transfer rates on different PCI slots with and without parallel
access to IDE. They used RocketDrive (RD), a solid-state HD, to test.
Funnily, all mainboards had one or another low number in there. For the Tyan
MPX (S2466N-4M), it was writing to RD in 32bit slot with only 29 MB/s
without concurrent IDE access and 24MB/s with concurrent IDE access.
Of course way enough for burning CDs. Two more low numbers: When writing
to RD in 64 bit PCI slot, the IDE only made 19/20 MB/s for read/write.

Those tests were performed under Win AFAICS, so maybe the PCI stuff under
Linux is set up differently ...

These numbers itself are no reason to worry, of course, but they may
indicate that arbitration may not be fair and may leave one device without
data for more than a short moment. Current CD-writers are like 16x with
a 4MB buffer, which means they should not be left w/o data for more than
1.7s and throughput should not go below 2.4 MB/s.

OK, this is really unlikely a PCI implementation would be that unfair with
test engineers noticing. Maybe strange occasional PCI aborts causing a long
recovery ...
Just a strange idea, of course.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9NJNOxmLh6hyYd04RApaHAJ9ob8/TGXgsS8JZttkeHViF6P7f+wCdEAdz
No4JHaEsFgv7fDZD6oGQJk8=
=ERu3
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
