Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264872AbUE0Q06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264872AbUE0Q06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUE0Q06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:26:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22163 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264872AbUE0Q0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:26:48 -0400
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on
	Alpha
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040527194920.A1709@jurassic.park.msu.ru>
References: <20040527194920.A1709@jurassic.park.msu.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sDfWq0Ez+ZKWrcVzPHGu"
Organization: Red Hat UK
Message-Id: <1085675193.7179.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 18:26:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sDfWq0Ez+ZKWrcVzPHGu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-27 at 17:49, Ivan Kokshaysky wrote:
> Spinning the disks down across a 'halt' on Alpha is even
> worse than doing that on reboot on i386 (assuming the
> boot device is IDE disk).
> Typically, the sequence to boot another kernel is:
> # halt
> kernel shuts down, firmware re-initializes,
> then on firmware prompt we type something like
> >>> boot -file new_kernel_image.gz
>=20
> Unfortunately, the firmware does not expect the IDE drive
> to be in standby mode and reports 'bootstrap failure' on
> the first and all subsequent boot attempts until the
> drive spins up, which is extremely annoying and
> confuses users a lot.

how do you flush the disks' writecache then? Halting the disk seems to
be the only reliable way to do so.


--=-sDfWq0Ez+ZKWrcVzPHGu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtha5xULwo51rQBIRAqzrAJ9EK+woRvtXCHv4DY4wWSTROnEsegCfV04n
Ij70mmw8PSKgbaBOsV2dfjA=
=XMHW
-----END PGP SIGNATURE-----

--=-sDfWq0Ez+ZKWrcVzPHGu--

