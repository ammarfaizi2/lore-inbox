Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275989AbRJKKfD>; Thu, 11 Oct 2001 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJKKex>; Thu, 11 Oct 2001 06:34:53 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:27338 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275981AbRJKKei>; Thu, 11 Oct 2001 06:34:38 -0400
Date: Thu, 11 Oct 2001 11:35:04 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-parport@torque.net, Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PARPORT] Problems with parallel port io card, emu10k1, system freeze
Message-ID: <20011011113504.R10562@redhat.com>
In-Reply-To: <20011010215733.B30906@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gVeFDRGtAQ0W7qcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011010215733.B30906@alpha.logic.tuwien.ac.at>; from preining@logic.at on Wed, Oct 10, 2001 at 09:57:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2001 at 09:57:33PM +0200, Norbert Preining wrote:

> No for the parallel port: I load parport_pc with
> 	modprobe parport_pc irq=3D7,none dma=3D3,none io=3D0x0378,0xc400
> which works, recognizes my printer on the second printer port (lp0 on
> parport1).
>=20
> But: If I load NOW the emu10k1 the system freezes.
> Same with emu10k1 loaded and modprobe parport_pc.

It will be because you haven't supplied the io_hi parameter; to tell
it _not_ to probe for an ECR register at base+0x400, you need to
supply 'io_hi=3D0,0'.

There is a patch for some NetMos cards, but unfortunately it seems to
suffer from the same problem anyway, which suggests that the code is
buggy in some way. :-(

Tim.
*/

--gVeFDRGtAQ0W7qcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7xXXYyaXy9qA00+cRAtubAJ9ExlRd+an2DdD//LCUZfpCJ/UYDgCfZpzF
CvA+3dxZ5sGXxUDbkLdOgXY=
=3O5b
-----END PGP SIGNATURE-----

--gVeFDRGtAQ0W7qcm--
