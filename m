Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264869AbUD2VAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbUD2VAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUD2U7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:59:33 -0400
Received: from mh57.com ([217.160.185.21]:10941 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S264858AbUD2UyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:54:01 -0400
Date: Thu, 29 Apr 2004 22:53:51 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.6-rc3 still oops on unplugging usb bluetooth bcm203x dongle
Message-ID: <20040429205351.GJ11077@mh57.de>
References: <1083218706.3942.5.camel@localhost> <Pine.LNX.4.44L0.0404291557550.1314-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0404291557550.1314-100000@ida.rowland.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.1 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2004 at 03:59:36PM -0400, Alan Stern wrote:
> On Thu, 29 Apr 2004, Soeren Sonnenburg wrote:
>=20
> > Hi...
> >=20
> > I still get:
> >=20
> > usb 2-1: USB disconnect, address 3
> > Oops: kernel access of bad area, sig: 11 [#1]
> > NIP: C02134B4 LR: F205D414 SP: EFE87DD0 REGS: efe87d20 TRAP: 0600    No=
t tainted
> > MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > DAR: 6B6B6BB7, DSISR: 00000120
> > TASK =3D effa4030[5] 'khubd' THREAD: efe86000Last syscall: -1=20
> > GPR00: FFFF0001 EFE87DD0 EFFA4030 EE77C828 6B6B6B6B 00000000 EB8EE83C 0=
0000000=20
> > GPR08: 00001388 EF0EE858 00010C00 C0213480 82008022 00000000 00000000 0=
0000000=20
> > GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 0=
0000000=20
> > GPR24: 00000000 C0400000 00000001 6B6B6B6B 6B6B6BB7 EF07B8A0 EE77C828 E=
E77C6FC=20
> > NIP [c02134b4] class_device_del+0x34/0x140
> > LR [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
> > Call trace:
> >  [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
> >  [f205876c] hci_unregister_dev+0x18/0xb0 [bluetooth]
> >  [f204cd94] hci_usb_disconnect+0x48/0x90 [hci_usb]
>=20
> Marcel Holtman is working on this; some other people have reported the=20
> same problem.  Have you been in touch with him?  It appears to be a=20
> problem in the Bluetooth driver, not in the USB stack.

Are there any patches available? The most recent patch I could find is
for 2.6.5, and does not change this problem.

I would like to try the latest version of the bluez-patch, if this can
help to find the bug.

LLAP, Martin

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAkWtfmGb6Npij0ewRAssYAJ4wgRIxoAn7FKhJzROSt6Z466y8bgCgpRjK
opaWuwuOrZbTGCD5rYLnxto=
=sgEp
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
