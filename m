Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUGLXff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUGLXff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUGLXff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:35:35 -0400
Received: from smtp07.auna.com ([62.81.186.17]:26061 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S264238AbUGLXfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:35:30 -0400
Date: Tue, 13 Jul 2004 01:35:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.[46] Fix double reset in aic7xxx driver
Message-ID: <20040712233527.GA5570@werewolf.able.es>
References: <20040712192059.GA7660@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20040712192059.GA7660@tsunami.ccur.com> (from joe.korty@ccur.com on Mon, Jul 12, 2004 at 21:20:59 +0200)
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2004.07.12, Joe Korty wrote:
> Fix occasional PCI bus parity errors on the Dell PowerEdge 4600 during
> boot.
>=20
> Symptoms: The LCD display would turn orange and display "PCI SYSTEM
> E13F5", and the following message would appear in /var/log/dmesg:
> "Uhhuh. NMI received. Dazed and confused, but trying to continue".
>=20
> By inserting a PCI card with a PDC20268 IDE controller and attaching to
> that a Sony DRU-510A DVD RW burner with an unloaded tray, the failure
> can be made to happen on every boot.
>=20
> Cause: The aic7xxx driver was resetting the onboard AIC7891 SCSI controll=
er
> while waiting for a previous reset to complete.  This second reset confus=
es
> the controller causing it to put bad data onto the PCI bus.
>=20
> This is a backport of a RedHat 2.4.21-15.ELsmp fix.  A letter discussing
> this problem, or one very close to it, may be found at:
>=20
>    http://lists.us.dell.com/pipermail/linux-poweredge/2003-May/025010.html
>=20
> Against 2.6.7 and 2.4.26.
>=20

This fixes are included in current driver in Justin Gibbs' site.

Will this driver ever be updated on mainline or is it a religious issue ?


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.7-jam12 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-1mdk)) #1

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8yA/RlIHNEGnKMMRArtSAJ9cEq+T1coxJQEw75vlZNSoDTrHPgCfcoXw
XHA7sIQNWsy2ByaMnD17Mdo=
=0ZJg
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
