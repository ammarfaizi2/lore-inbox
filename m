Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWBLP3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBLP3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 10:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWBLP3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 10:29:09 -0500
Received: from master.altlinux.org ([62.118.250.235]:37647 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750799AbWBLP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 10:29:08 -0500
Date: Sun, 12 Feb 2006 18:28:47 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/2] [PCI] Secure Digital Host Controller id and regs
Message-Id: <20060212182847.375d7907.vsu@altlinux.ru>
In-Reply-To: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
References: <20060211001523.10315.34499.stgit@poseidon.drzeus.cx>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__12_Feb_2006_18_28_47_+0300_5VexQ3YGb62ogmBT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__12_Feb_2006_18_28_47_+0300_5VexQ3YGb62ogmBT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Feb 2006 01:15:23 +0100 Pierre Ossman wrote:

> Class code and register definitions for the Secure Digital Host Controller
> standard.
>=20
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> ---
>=20
>  include/linux/pci_ids.h  |    1 +
>  include/linux/pci_regs.h |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 7a61ccd..5fa8ebe 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -69,6 +69,7 @@
>  #define PCI_CLASS_SYSTEM_TIMER		0x0802
>  #define PCI_CLASS_SYSTEM_RTC		0x0803
>  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
> +#define PCI_CLASS_SYSTEM_SDHCI		0x0805
>  #define PCI_CLASS_SYSTEM_OTHER		0x0880
> =20
>  #define PCI_BASE_CLASS_INPUT		0x09
> diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
> index d27a78b..e6deda5 100644
> --- a/include/linux/pci_regs.h
> +++ b/include/linux/pci_regs.h
> @@ -108,6 +108,9 @@
>  #define PCI_INTERRUPT_PIN	0x3d	/* 8 bits */
>  #define PCI_MIN_GNT		0x3e	/* 8 bits */
>  #define PCI_MAX_LAT		0x3f	/* 8 bits */
> +#define PCI_SLOT_INFO		0x40	/* 8 bits */
> +#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
> +#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07

Does this really belong here?  This register is specific to the SDHCI
class, while all other definitions in pci_regs.h apply to all PCI
devices.

drivers/mmc/sdhci.h seems to be a more logical place for SLOT_INFO
definitions.

> =20
>  /* Header type 1 (PCI-to-PCI bridges) */
>  #define PCI_PRIMARY_BUS		0x18	/* Primary bus number */
>=20

--Signature=_Sun__12_Feb_2006_18_28_47_+0300_5VexQ3YGb62ogmBT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFD71QvW82GfkQfsqIRAuseAJwMy96Sj++5znwfemh10OndibtR6QCdF5ay
UeyYibgrLCun/n8DosE9tvc=
=7gFg
-----END PGP SIGNATURE-----

--Signature=_Sun__12_Feb_2006_18_28_47_+0300_5VexQ3YGb62ogmBT--
