Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbSJTT0T>; Sun, 20 Oct 2002 15:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264627AbSJTT0T>; Sun, 20 Oct 2002 15:26:19 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:5241 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264626AbSJTT0S>;
	Sun, 20 Oct 2002 15:26:18 -0400
Date: Sun, 20 Oct 2002 21:32:17 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Error in get_swap_page? (2.5.44)
Message-ID: <20021020213217.A17457@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Unless I am mistaken, we return stuff (entry) from the local=20
stack in swapfile.c::get_swap_page. Am I mistaken?

Code in question:

swp_entry_t get_swap_page(void)
{
        struct swap_info_struct * p;
        unsigned long offset;
        swp_entry_t entry;
        int type, wrapped =3D 0;

        entry.val =3D 0;  /* Out of memory */
[...]

out:
        swap_list_unlock();
        return entry;
}


Regards,
  Rasmus

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9swTAlZJASZ6eJs4RAlVPAJ94e0AUsOsrpbFeiHu40gphZl0FSQCfemPf
4fpK3IsdLSEZzboZJZ92kFw=
=o5LY
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
