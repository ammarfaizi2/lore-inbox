Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVCJMmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVCJMmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVCJMmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:42:51 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:906 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262564AbVCJMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:42:46 -0500
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
	2.6
From: Christophe Saout <christophe@saout.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz,
       David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
In-Reply-To: <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
References: <11102278521318@2ka.mipt.ru>
	 <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H0wXgYv5Qcf8Fpp1/6+t"
Date: Thu, 10 Mar 2005 13:42:33 +0100
Message-Id: <1110458553.4087.10.camel@server.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H0wXgYv5Qcf8Fpp1/6+t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Dienstag, den 08.03.2005, 00:08 -0500 schrieb Kyle Moffett:

> Did you include support for the new key/keyring infrastructure=20
> introduced
> a couple versions ago by David Howells?  It allows userspace to create=20
> and
> manage various sorts of "keys" in kernelspace.  If you create and=20
> register
> a few keytypes for various symmetric and asymmetric ciphers, you could=20
> then
> take advantage of its support for securely passing keys around in and=20
> out
> of userspace.

I've written a dm-crypt patch some weeks ago that does what you
describe. The crypto information (cipher and key) is added to a keyring
and then the device is constructed using a reference to this key.

I had some issues with the keyring code (mainly a deadlock problem with
crypto module autoloading): http://lkml.org/lkml/2005/2/4/113

I would also like to switch dm-crypt to acrypto once it's accepted into
the kernel.


--=-H0wXgYv5Qcf8Fpp1/6+t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCMEC5ZCYBcts5dM0RAnkJAJ93ViuWshfAJo6SQoqalNcP0OywFgCdH2bd
51GZcAvpj384hZJHe2pxmDE=
=LoSh
-----END PGP SIGNATURE-----

--=-H0wXgYv5Qcf8Fpp1/6+t--
