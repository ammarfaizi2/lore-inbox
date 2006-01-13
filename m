Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422946AbWAMTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWAMTye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWAMTyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:54:14 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:44243 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1422892AbWAMTxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:53:48 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 20:53:37 +0100
User-Agent: KMail/1.7.2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>
References: <200601122241.07363.rjw@sisk.pl> <20060112220940.GA10088@elf.ucw.cz> <200601130031.34624.rjw@sisk.pl>
In-Reply-To: <200601130031.34624.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1178421.APgeozDvNR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132053.43085.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1178421.APgeozDvNR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the las=
t argument
> > > +	should be a pointer to an unsigned int variable that will contain
> > > +	the result if the call is successful)
> >=20
> > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > available swap can be >4GB. [Or maybe it is in something else than
> > bytes, then you need to specify it.]
>=20
> It returns the number of pages.  Well, it should be written explicitly,
> so I'll fix that.

Please always talk to the kernel in bytes. Pagesize is only a kernel
internal unit. Sth. like off64_t is fine.


Regards

Ingo Oeser


--nextPart1178421.APgeozDvNR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDyAVHU56oYWuOrkARAqalAJ9h4PHCadTL5Xdq+VKWHsXSl83EpQCgpKG9
5LlCZ4b0IeyN+PuwMsVlJm4=
=H5YZ
-----END PGP SIGNATURE-----

--nextPart1178421.APgeozDvNR--
