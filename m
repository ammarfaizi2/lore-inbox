Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264247AbSIQPHP>; Tue, 17 Sep 2002 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264251AbSIQPHP>; Tue, 17 Sep 2002 11:07:15 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:1555 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S264247AbSIQPHO>; Tue, 17 Sep 2002 11:07:14 -0400
Date: Tue, 17 Sep 2002 17:12:11 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Chin-Tser Huang <chuang@cs.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: save variables to hard disk at kernel mode
Message-ID: <20020917151211.GK4593@arthur.ubicom.tudelft.nl>
References: <Pine.LNX.4.33.0209161818120.26471-100000@nurse.cs.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209161818120.26471-100000@nurse.cs.utexas.edu>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2002 at 06:23:04PM -0500, Chin-Tser Huang wrote:
> I would like to implement at the kernel a save that
> can periodically store the value of some variables
> to the hard disk. Could anyone please tell me what
> function can I use to achieve this? Will this save
> block the operation of other functions? Thank you
> very much for your help!

This is policy, and policy should be implemented in userland. Have your
driver implement a device node that presents the value when userland
reads it. Imlement a simple userland program that read()s the device
and writes it to whatever file you like. The advantage of this approach
is that userland can decide *where* to write it: on a hard disk, send
it over a network, etc. etc.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9h0ZL/PlVHJtIto0RAuAlAJsG0A3hs7r1qXWbmH9EBwgYj+DkWACfZJDv
BOCT4jiJTOk2YhwNnfIsdfs=
=ZDLW
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
