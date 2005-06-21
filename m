Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVFUKV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVFUKV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 06:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVFUKVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 06:21:25 -0400
Received: from mout1.freenet.de ([194.97.50.132]:55436 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S261507AbVFUKVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 06:21:19 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: bobl <bobl@turbolinux.com>
Subject: Re: a trival bug of megaraid in patch 2.6.12-mm1
Date: Tue, 21 Jun 2005 12:20:41 +0200
User-Agent: KMail/1.8.1
References: <42B7E5F2.2060409@turbolinux.com>
In-Reply-To: <42B7E5F2.2060409@turbolinux.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4410042.B85el2pkyI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506211220.42136.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4410042.B85el2pkyI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting bobl <bobl@turbolinux.com>:
>     The attachment is the patch, please confirm it.

> diff -purN linux-2.6.12/drivers/scsi/megaraid.c linux-2.6.12.new/drivers/=
scsi/megaraid.c
> --- linux-2.6.12/drivers/scsi/megaraid.c        2005-06-21 18:49:50.11873=
2304 +0900
> +++ linux-2.6.12.new/drivers/scsi/megaraid.c    2005-06-21 18:57:55.26697=
8560 +0900
> @@ -1975,6 +1975,7 @@ __megaraid_reset(Scsi_Cmnd *cmd)
>  static int
>  megaraid_reset(Scsi_Cmnd *cmd)
>  {
> +       adapter_t       *adapter;
>         adapter =3D (adapter_t *)cmd->device->host->hostdata;
>         int rc;

That's mixed code and declarations (aka Not Good (tm)).
Please do something like this instead:

=2D       adapter =3D (adapter_t *)cmd->device->host->hostdata;
+       adapter_t *adapter =3D (adapter_t *)cmd->device->host->hostdata;
        int rc;


=2D-=20
Greetings, Michael



--nextPart4410042.B85el2pkyI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCt+n6FGK1OIvVOP4RAvVpAJ9PPREeb9TPiorydt4wLS8P5OGEpgCfZ4i9
QSSUxvwnexLogm3jLocCZ8k=
=zGQX
-----END PGP SIGNATURE-----

--nextPart4410042.B85el2pkyI--
