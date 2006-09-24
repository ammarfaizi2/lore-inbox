Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWIXHrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWIXHrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWIXHrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:47:24 -0400
Received: from master.altlinux.org ([62.118.250.235]:5897 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750967AbWIXHrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:47:23 -0400
Date: Sun, 24 Sep 2006 11:46:47 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Willy Tarreau <w@1wt.eu>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-Id: <20060924114647.a0e4a650.vsu@altlinux.ru>
In-Reply-To: <20060923235315.GB24214@1wt.eu>
References: <20060922222300.GA5566@stusta.de>
	<20060922223859.GB21772@kroah.com>
	<20060922224735.GB5566@stusta.de>
	<20060922230928.GB22830@kroah.com>
	<20060923045610.GM541@1wt.eu>
	<20060923232150.GK5566@stusta.de>
	<20060923235315.GB24214@1wt.eu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__24_Sep_2006_11_46_47_+0400_Dt/z=6OsfFBCJp0x"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__24_Sep_2006_11_46_47_+0400_Dt/z=6OsfFBCJp0x
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Sep 2006 01:53:15 +0200 Willy Tarreau wrote:

> The problem is when some hardware suddenly become detected and assigned
> in the middle of a stable release. Do not forget that people need stable
> releases to be able to blindly update and get their security vulnerabilit=
ies
> fixed. Sometimes, unlocking 2 SATA ports on the mobo by adding a PCI ID or
> adding the PCI ID of some new ethernet cards that were not supported may
> lead to such fun things (eth0 becoming eth2, sda becoming sdc, etc...).
> This causes real trouble to admins, particularly those doing remote
> updates. At least, I think that if you manage to inform people clearly
> enough, and to separate security fixes and such fixes in distinct release=
s,
> it might work in most situations. But this is a dangerous game anyway.

Seems that the V4L/DVB patches in question are safe in this regard.
These patches add PCI table entries matching the specific subsystem ids;
without these entries the device will still match the default entry for
the chip, and the user will get the same /dev/videoN, but most likely it
won't work correctly.

The only problem which might arise is with additional IR input devices,
but no one should expect any stable ordering there - with USB the order
of input devices is already random.

--Signature=_Sun__24_Sep_2006_11_46_47_+0400_Dt/z=6OsfFBCJp0x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFFjfrW82GfkQfsqIRAo1kAJwMKUxV1hYLVTJZJnN+7ZrtsGhXGgCeLdNM
4/4y2ag/LqcdTt4ZPKgaYE4=
=Dzsr
-----END PGP SIGNATURE-----

--Signature=_Sun__24_Sep_2006_11_46_47_+0400_Dt/z=6OsfFBCJp0x--
