Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbULBNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbULBNDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbULBNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:03:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21988 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261603AbULBNDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:03:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: [PATCH] cosa.h ioctl numbers
Date: Thu, 2 Dec 2004 13:58:00 +0100
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20041202124456.GF11992@fi.muni.cz>
In-Reply-To: <20041202124456.GF11992@fi.muni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_YFxrBu6pK8KFJzX";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412021358.00844.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_YFxrBu6pK8KFJzX
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 02 Dezember 2004 13:44, Jan Kasprzak wrote:
> 	The following patch reverts the changes in ioctl() numbers
> for COSA WAN card, makink the ioctl numbers the same as in 2.4, and thus
> preserving the binary compatibility with user-space utils.

>  /* Read the block from the device memory */
> -#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download)
> +#define COSAIORMEM	_IOWR('C',0xf2, struct cosa_download *)
> =20
>  /* Write the block to the device memory (i.e. download the microcode) */
> -#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download)
> +#define COSAIODOWNLD	_IOW('C',0xf2, struct cosa_download *)

Isn't that rather misleading? I suppose the real argument is=20
'struct cosa_download', so you should have some kind of comment there,=20
e.g.

#define COSAIODOWNLD _IOW('C',0xf2, long) /* actually struct cosa_download =
*/

	Arnd <><

--Boundary-02=_YFxrBu6pK8KFJzX
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBrxFY5t5GS2LDRf4RAtnUAKCZP0ICuWA4sxhEVsgALNmKDtje4ACeLGb4
dU/0dsDVgsky04YoyANOzNQ=
=PyGl
-----END PGP SIGNATURE-----

--Boundary-02=_YFxrBu6pK8KFJzX--
