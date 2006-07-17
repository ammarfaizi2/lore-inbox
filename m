Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWGQO2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWGQO2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWGQO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:28:46 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:23239 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S1750796AbWGQO2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:28:45 -0400
X-Ids: 166
Date: Mon, 17 Jul 2006 16:29:17 +0200
From: Julien Cristau <julien.cristau@ens-lyon.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Linux v2.6.17 - PCI Bus hidden behind transparent bridge
Message-ID: <20060717142917.GJ5299@bryan.is-a-geek.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <20060716193452.GA5299@bryan.is-a-geek.org> <20060717141315.GB2771@colo.lackof.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20060717141315.GB2771@colo.lackof.org>
X-Operating-System: Linux 2.6.16-2-686 i686
User-Agent: Mutt/1.5.11+cvs20060403
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (shiva.jussieu.fr [134.157.0.166]); Mon, 17 Jul 2006 16:28:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2006 at 08:13:15 -0600, Grant Grundler wrote:

> I diff'ed the dmesg output and I think this is the chunk
> might be more explicit symptom of your problem:
> -Loaded prism54 driver, version 1.2
>=20
> This output comes from drivers/net/wireless/prism54/islpci_hotplug.c:
> 	printk(KERN_INFO "Loaded %s driver, version %s\n",
>=20
> You can verify if the driver isn't getting loaded until later (udev?)
> or not all by doing "modprobe prism54" and see of that starts
> working. If not, then my next guess would be something changed in the
> prism54 driver so it doesn't claim your device.
>=20
Hi Grant,

Loading the driver with modprobe doesn't change anything (it just
outputs the 'Loaded prism54 driver' line), the device still doesn't
appear in lspci or ifconfig -a.

Cheers,
Julien

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEu568mEvTgKxfcAwRAldXAKCwxsoevmp6jEJkScDtH1vrd5by6QCghQvd
b4WNWfuuYZVCl1KWJ+l9IjU=
=3elr
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
