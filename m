Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbRGQXYd>; Tue, 17 Jul 2001 19:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267592AbRGQXYY>; Tue, 17 Jul 2001 19:24:24 -0400
Received: from a9163.upc-a.chello.nl ([62.163.9.163]:5690 "EHLO
	casa.casa-etp.nl") by vger.kernel.org with ESMTP id <S267590AbRGQXYS>;
	Tue, 17 Jul 2001 19:24:18 -0400
Date: Wed, 18 Jul 2001 01:23:55 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Gianluca Anzolin <g.anzolin@inwind.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-pre6 can't complete e2fsck
Message-ID: <20010718012355.B12655@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Gianluca Anzolin <g.anzolin@inwind.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010716132933.A216@fourier.home.intranet> <20010716190653.E11978@athlon.random> <20010716202825.J11978@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010716202825.J11978@athlon.random>; from andrea@suse.de on Mon, Jul 16, 2001 at 08:28:25PM +0200
X-Operating-System: Linux 2.4.6-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2001 at 08:28:25PM +0200, Andrea Arcangeli wrote:
> On Mon, Jul 16, 2001 at 07:06:53PM +0200, Andrea Arcangeli wrote:
> > I can reproduce so it will be fixed in the next release. thanks for the
>=20
> Ok, it was because I developed the blkdev-pagecache and
> 00_drop_async-io-get_bh-1 patches in two separated trees.
>=20
> When both patches passed all the regression testing I merged both
> into 2.4.7pre6aa1 but unfortunately no reject reminded me I had to drop
> the get_bh from the async handler used by the blkdev pagecache (sorry!).
>=20
> So in short this incremental patch on top of 2.4.7pre6aa1 will fix your
> problem (at least it did for mine):

Works for me. (I could just use hdparm -tT a couple of times to trigger the
bug before). Now, a couple of machines, including my SMP iron here,  are
running stably now (that is, since max. a day)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7VMkKxmLh6hyYd04RAltgAJ9wnHVi7hNQeyXoysQxaYl/PxWe0ACgkyM9
IXw/LWoiDl6eMeX0CX/p7Q4=
=OIrc
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
