Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269082AbUINAcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269082AbUINAcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 20:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUINAcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 20:32:36 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:1743 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269082AbUINAbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 20:31:18 -0400
Date: Tue, 14 Sep 2004 02:29:33 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Hanna Linder <hannal@us.ibm.com>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       greg@kroah.com, wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_sio.c] [2/2] convert pci_find_device to pci_get_device
Message-ID: <20040914002933.GA20390@thundrix.ch>
References: <806430000.1095118643@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <806430000.1095118643@w-hlinder.beaverton.ibm.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 13, 2004 at 04:37:23PM -0700, Hanna Linder wrote:
> diff -Nrup linux-2.6.9-rc1/arch/alpha/kernel/sys_sio.c linux-2.6.9-rc1-al=
pha/arch/alpha/kernel/sys_sio.c
> --- linux-2.6.9-rc1/arch/alpha/kernel/sys_sio.c	2004-08-13 22:36:12.00000=
0000 -0700
> +++ linux-2.6.9-rc1-alpha/arch/alpha/kernel/sys_sio.c	2004-09-13 16:04:58=
=2E135130904 -0700
> @@ -105,7 +105,7 @@ sio_collect_irq_levels(void)
>  	struct pci_dev *dev =3D NULL;
> =20
>  	/* Iterate through the devices, collecting IRQ levels.  */
> -	while ((dev =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) !=3D NULL=
) {
> +	while ((dev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) !=3D NULL)=
 {
>  		if ((dev->class >> 16 =3D=3D PCI_BASE_CLASS_BRIDGE) &&
>  		    (dev->class >> 8 !=3D PCI_CLASS_BRIDGE_PCMCIA))
>  			continue;
> @@ -229,7 +229,7 @@ alphabook1_init_pci(void)
>  	 */
> =20
>  	dev =3D NULL;
> -	while ((dev =3D pci_find_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
> +	while ((dev =3D pci_get_device(PCI_VENDOR_ID_NCR, PCI_ANY_ID, dev))) {
>                  if (dev->device =3D=3D PCI_DEVICE_ID_NCR_53C810
>  		    || dev->device =3D=3D PCI_DEVICE_ID_NCR_53C815
>  		    || dev->device =3D=3D PCI_DEVICE_ID_NCR_53C820

Don't we need to put these devices in some place?

				   Tonnerre

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBRjts/4bL7ovhw40RAl//AKC9YNvrr0KETveZ3y46vyUN790CdQCfXbYW
oDWixZkJrGbcgpPHhZWgNVs=
=3ZoP
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
