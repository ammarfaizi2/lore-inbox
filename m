Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263942AbRFMMWX>; Wed, 13 Jun 2001 08:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFMMWN>; Wed, 13 Jun 2001 08:22:13 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:31237 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S263942AbRFMMWI>; Wed, 13 Jun 2001 08:22:08 -0400
Date: Wed, 13 Jun 2001 14:20:26 +0200
From: Kurt Garloff <garloff@suse.de>
To: ognen@gene.pbi.nrc.ca
Cc: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010613142026.B13623@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, ognen@gene.pbi.nrc.ca,
	Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de> <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca>; from ognen@gene.pbi.nrc.ca on Tue, Jun 12, 2001 at 01:07:11PM -0600
X-Operating-System: Linux 2.2.19 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2001 at 01:07:11PM -0600, ognen@gene.pbi.nrc.ca wrote:
> due to the nature of the problem (a pairwise mutual alignment of n
> sequences results in mx. n^2 alignments which can each be done in a
> separate thread), I need to create and destroy the threads frequently.
>=20
> I am not really comfortable with 1.4 - 1.5 speedups since the solution was
> intended as a Linux one primarily and it just happenned that it works (and
> now even better) on Solaris/SGI/OSF...

Nor would I.=20

What I do in my numerics code to avoid this problem, is to create all the
threads (as many as there are CPUs) on program startup and have then wait
(block) for a condition. As soon as there's something to to, variables for
the thread are setup (protected by a mutex) and the thread gets signalled
(cond_signal).
If you're interested in the code, tell me.

This is supposed to be much faster than thread creation.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7J1qJxmLh6hyYd04RAoSYAJ9JS7SE0WQBGmiHSz+4y7lsnZJS2wCcDL8A
Gq4RXZYHmTQpGTTURpJpVfU=
=lq4O
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
