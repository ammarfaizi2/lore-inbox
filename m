Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCALgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCALgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVCALgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:36:44 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:47788 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261878AbVCALgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:36:40 -0500
From: Mws <mws@twisted-brains.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc5
Date: Tue, 1 Mar 2005 12:36:53 +0100
User-Agent: KMail/1.8
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <200502251430.16860.mws@twisted-brains.org> <1109379043.14993.93.camel@gaston>
In-Reply-To: <1109379043.14993.93.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8227543.9dJfelea1f";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503011236.58222.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8227543.9dJfelea1f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi benjamin

now i had some spare time to do some investigation

booting the 2.6.11-rc5 with radeonfb.default_dynclk=3D0 or with -1
brings up a framebuffer console. everything is fine.
starting xorg-x11 with Ati binary only drivers just brings up a black screen
without a mouse cursor and freezes the hole machine. even network ect.=20
is no more reachable from outside the machine. worst thing out of that
a tail on the log files (on another machine) does immediately stop - also n=
o=20
output is written to syslog :/

next scenario - test 2.6.11-rc5 with radeonfb.default_dynclock=3D0 and -1
starting xorg-x11 with Xorg Radeon driver.=20
a grey screen comes up - mouse cursor is visible and also able to move for
5 - 8 seconds after screen display - then freezes the whole machine again.

regards
marcel


On Saturday 26 February 2005 01:50, Benjamin Herrenschmidt wrote:
> On Fri, 2005-02-25 at 14:30 +0100, Mws wrote:
> > hi,
> >=20
> > i also have problems with 2.6.11-rc5 and radeon:
> >=20
> > i am using a ATI Radeon X600 PciExpress.
> >=20
> > a) now the console framebuffer seems to bee working, thx benjamin :)
> > b) when bootup seq ist completed and i want to start X (xorg-x11) with =
ati-drivers
> >     x is freezing - not your problem, but the console is not correctly =
restored :/ the only way
> >     out is to reset the machine :/
> >     2.6.11-rc3 was running fine in this case
>=20
> Hrm, the binary drivers ? oh well... some users had them freezing vs.
> radeonfb before and not now. I don't know what they do and don't have
> access to a machine with them (there are no ppc versions) so it will be
> difficult to track. I suspect they completely reconfigure the chip and
> don't restore it properly tho.


=20
> What exactly is happening. Does X launches at all ? When does it
> freeze ? On X launch or when exiting it ? Have you tried disabling
> dynamic clock tweaking ? (radeonfb.default_dynclk=3D-1 or 0 on the
> cmdline, first one means "don't touch the registers", secoond one means
> "disable dynamic clocks").
=20

--nextPart8227543.9dJfelea1f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCJFPaPpA+SyJsko8RAhMbAKC8s4CKN9oupJ1TFIvKsSJLbuosuwCgtKUv
fSl8PdRsNuN1f/n8uBo8poI=
=8BE1
-----END PGP SIGNATURE-----

--nextPart8227543.9dJfelea1f--
