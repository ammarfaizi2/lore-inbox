Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277243AbRJQVe3>; Wed, 17 Oct 2001 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJQVeT>; Wed, 17 Oct 2001 17:34:19 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:35875 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S277243AbRJQVeI>; Wed, 17 Oct 2001 17:34:08 -0400
Date: Wed, 17 Oct 2001 23:34:40 +0200
From: Kurt Garloff <garloff@suse.de>
To: Hugo van der Merwe <hugovdm@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps/2 mouse, keyboard conflicts
Message-ID: <20011017233440.B13317@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Hugo van der Merwe <hugovdm@mail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011017144158.A6534@baboon.wilgenhof.sun.ac.za>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20011017144158.A6534@baboon.wilgenhof.sun.ac.za>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.12 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the mouse needs to be reinitialized after being replugged. First it needs to
be enabled and then set to the protocol it uses (if different from plain
PS/2). This should be handled by mouse driver, i.e. gpm and X11.
However, it isn't.=20
There once was a kernel patch to do the first part (it can't do the second,
asw the kernel has not the slightest clue about the specifics of the mouse),
but
* it was bad design (should be done in userspace, where knowledge baout the
  specific mouse id present)
* broke some mouses (synps2 most notably)
so it got disbaled. You can try reenabling by using the parammeter
psaux-reconnect and check whether this makes a difference.

I don't have the slightest clue why it affects yoiur keyboard.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zflvxmLh6hyYd04RAl4FAKDVzUo9wQ0IA4t6h/Iv2FVOqjEK0gCggOpb
6af7yy9fozJtoJLS8IF5HhE=
=ggMY
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
