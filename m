Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288995AbSBDOrr>; Mon, 4 Feb 2002 09:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288996AbSBDOri>; Mon, 4 Feb 2002 09:47:38 -0500
Received: from fysh.org ([212.47.68.126]:21508 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S288995AbSBDOrW>;
	Mon, 4 Feb 2002 09:47:22 -0500
Date: Mon, 4 Feb 2002 14:47:20 +0000
From: Athanasius <Athan@gurus.tf>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Burj?n G?bor <buga+dated+1013036430.1fd862@elte.hu>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.17 NFS hangup
Message-ID: <20020204144720.GD18430@gurus.tf>
Mail-Followup-To: Athanasius <Athan@gurus.tf>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Burj?n G?bor <buga+dated+1013036430.1fd862@elte.hu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020203202251.GA22797@csoma.elte.hu> <shsbsf61di3.fsf@charged.uio.no> <20020203213422.GA703@csoma.elte.hu> <15453.48475.123973.610574@charged.uio.no> <20020203230030.GA14478@csoma.elte.hu> <20020204132146.GB18430@gurus.tf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20020204132146.GB18430@gurus.tf>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2002 at 01:21:46PM +0000, Athanasius wrote:
>    I'm seeing something like this as well.  Two machines using
> BNC/thinwire (yes, I know, waiting on finances to make this better), 2
> other machines on the same segment.  I use an NFS mount from the server
> (jimblewix) on the workstation (emelia) for amongst other things playing
> mp3s.

   Seems to be my day for this happening.  A bit more data:

   There's next to no collisions going on, from ifconfig eth0 on the
SERVER:

          RX packets:31331103 errors:0 dropped:1 overruns:0 frame:151
          TX packets:42576602 errors:0 dropped:0 overruns:0 carrier:0
          collisions:33733 txqueuelen:100=20

and the WORKSTATION:

          RX packets:301884 errors:0 dropped:0 overruns:0 frame:0
          TX packets:238086 errors:0 dropped:0 overruns:0 carrier:0
          collisions:397 txqueuelen:100=20

Also the numbers on the SERVER at least for collisions didn't increase
the last time NFS cut out on me.

   I'm not seeing ANY other logging in kern.log on either machine above
the NFS timeout reports, nothing about NICs having trouble or the like.

-Ath
--=20
- Athanasius =3D Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjxenvgACgkQzbc+I5XfxKd1cwCgmw/K7O4iLNGyCErtMyuZrz2p
njoAoIbR4j4pzNFP2bP02me5/u28cz6b
=VsLR
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
