Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288160AbSAMVyq>; Sun, 13 Jan 2002 16:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSAMVyf>; Sun, 13 Jan 2002 16:54:35 -0500
Received: from 12-235-34-22.client.attbi.com ([12.235.34.22]:41215 "EHLO
	voyager") by vger.kernel.org with ESMTP id <S288160AbSAMVyW>;
	Sun, 13 Jan 2002 16:54:22 -0500
Subject: RE: initramfs buffer spec -- third draft
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-9GEMJ19dnS3OnVEuQ1tM"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Jan 2002 13:42:26 -0800
Message-Id: <1010958148.8691.0.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9GEMJ19dnS3OnVEuQ1tM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

H. Peter Anvin wrote:
>               initramfs buffer format
>               -----------------------
>
>               Al Viro, H. Peter Anvin
>              Last revision: 2002-01-13
>
>       ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT ** DRAFT **
.....
>The full format of the initramfs buffer is defined by the following
>grammar, where:
>    *    is used to indicate "0 or more occurrences of"
>    (|)    indicates alternatives
>    +    indicates concatenation
>    GZIP()    indicates the gzip(1) of the operand
>    ALGN(n)    means padding with null bytes to an n-byte boundary
>
>    initramfs  :=3D ("\0" | cpio_archive | cpio_gzip_archive)*
>
>    cpio_gzip_archive :=3D GZIP(cpio_archive)
>
>    cpio_archive :=3D cpio_file* + (<nothing> | cpio_trailer)
>
>    cpio_file :=3D ALGN(4) + cpio_header + filename + "\0" + ALGN(4) +
data
>
>    cpio_trailer :=3D ALGN(4) + cpio_header + "TRAILER!!!\0" + ALGN(4)


what's the purpose of the "*" behind cpio_file in the cpio_archive
definition?  There is already repetition in the initramfs and the "*"
behind cpio_archive would e.g. allow a sequence of cpio_trailers
without  any cpio_file inbetween.

--nk

--=20
Key fingerprint =3D 6C58 F18D 4747 3295 F2DB  15C1 3882 4302 F8B4 C11C

--=-9GEMJ19dnS3OnVEuQ1tM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Qf9COIJDAvi0wRwRAqeyAJ45pHlQGxuk+OTHnHs7DZWzFXt5sQCfc50K
eAFYSh1WnmE84SXGvs9yRSg=
=jbv/
-----END PGP SIGNATURE-----

--=-9GEMJ19dnS3OnVEuQ1tM--

