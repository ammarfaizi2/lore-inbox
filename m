Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbTHQMzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270003AbTHQMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:55:39 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:21453 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S269602AbTHQMzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:55:37 -0400
Date: Sun, 17 Aug 2003 15:55:33 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dominik Strasser <Dominik.Strasser@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030817125533.GR27888@actcom.co.il>
References: <3F3F782C.2030902@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4HoONH8zr3Mj5MZN"
Content-Disposition: inline
In-Reply-To: <3F3F782C.2030902@t-online.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4HoONH8zr3Mj5MZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2003 at 02:42:20PM +0200, Dominik Strasser wrote:
> scsi.h uses "u8" which doesn't seem to be defined.
> Better use u_char.
>=20
> --- linux/include/scsi/scsi.h   2003-08-17 14:36:02.000000000 +0200
> +++ /tmp/scsi.h 2003-08-17 14:39:42.000000000 +0200
> @@ -226,7 +226,7 @@
>   * ScsiLun: 8 byte LUN.
>   */
>  typedef struct scsi_lun {
> -       u_char scsi_lun[8];
> +       u8 scsi_lun[8];
>  } ScsiLun;

IMO, it's more correct to include <linux/types.h> in scsi.h, which
will bring in u8 and make scsi.h compilable on its own (provided
__KERNEL__ is defined, as it should be).=20

Index: include/scsi/scsi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux-2.5/include/scsi/scsi.h,v
retrieving revision 1.10
diff -u -r1.10 scsi.h
--- include/scsi/scsi.h	13 May 2003 06:20:05 -0000	1.10
+++ include/scsi/scsi.h	17 Aug 2003 11:23:01 -0000
@@ -14,6 +14,8 @@
=20
 */
=20
+#include <linux/types.h>=20
+
 /*
  * SCSI command lengths
  */



--=20
Muli Ben-Yehuda
http://www.mulix.org


--4HoONH8zr3Mj5MZN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/P3tFKRs727/VN8sRAjrcAKC56nACqd2Etk4dpG0lDMv/EDJVBACcC1Ly
h0aU4siwW0QN1xcp/Ou3KC8=
=RwEt
-----END PGP SIGNATURE-----

--4HoONH8zr3Mj5MZN--
