Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSG1AjY>; Sat, 27 Jul 2002 20:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318867AbSG1AjY>; Sat, 27 Jul 2002 20:39:24 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:41073 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S318865AbSG1AjW>; Sat, 27 Jul 2002 20:39:22 -0400
Date: Sun, 28 Jul 2002 02:42:35 +0200
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@math.psu.edu>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020728004235.GA7691@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu> <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl> <20020726175027.GC2746@clusterfs.com> <20020726185545.B18629@infradead.org> <20020726223224.GJ19721@nbkurt.etpnet.phys.tue.nl> <20020727104119.A5992@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20020727104119.A5992@infradead.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Al,

On Sat, Jul 27, 2002 at 10:41:19AM +0100, Christoph Hellwig wrote:
> On Sat, Jul 27, 2002 at 12:32:24AM +0200, Kurt Garloff wrote:
> Linus wants this, and he stated that again on the kernel summit. =20

I've not been there :-(

> But to do this porperly (=3D not the EVMS way) it needs preparation. =20
> Al currently does lots of work in that area to make the block drivers
> largely independent of the major number.

So he should port my sd patch to 2.5. All the data it uses is in a per-major
data structure. Currently, in most function it uses the kdev_t passed to fi=
nd
the right pointer. But that's very easy to replace.
Of course, sd still assumes it gets a whole major and not parts of one. Oth=
er-
wise, more splitting would be needed.

> Once the drivers don't need the major number anymore
> internally the only that needs sorting out is userlevel backwards-compati=
nlity.

That takes more effort than the change itself, I guess.

> I'm pretty sure the preparation will be finished for 2.6, also I can't co=
mment
> whether the unified disk major will be done. (Al?)

Would certainly be nice.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Qz37xmLh6hyYd04RAjIIAJ9g87rIiH2xsaT88ZD2BOx0LaRq/wCgiyJw
2X1f1rb+Ll+nar92MwQ6pok=
=/2ox
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
