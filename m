Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUIWExU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUIWExU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbUIWExU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:53:20 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:19425 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268278AbUIWExB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:53:01 -0400
Date: Thu, 23 Sep 2004 06:51:14 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] xsa_use_interrupts flag [WAS: xilinx_sysace]
Message-ID: <20040923045114.GF6889@thundrix.ch>
References: <35fb2e5904090607241087442d@mail.gmail.com> <35fb2e59040919131864c26952@mail.gmail.com> <35fb2e59040922181249d18af6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <35fb2e59040922181249d18af6@mail.gmail.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Sep 23, 2004 at 02:12:07AM +0100, Jon Masters wrote:
> @@ -832,10 +859,17 @@
>  	register_disk(&xsa_gendisk, MKDEV(xsa_major, 0),
>  		      NR_HD << PARTN_BITS, &xsa_fops, size);
> =20
> -	printk(KERN_INFO
> -	       "%s at 0x%08X mapped to 0x%08X, irq=3D%d, %ldKB\n",
> -	       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
> -	       size / 2);
> +	if (xsa_use_interrupts) {
> +		printk(KERN_INFO
> +		       "%s at 0x%08X mapped to 0x%08X, irq=3D%d, %ldKB\n",
> +		       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
> +		       size / 2);
> +	} else {
> +		printk(KERN_INFO
> +		       "%s at 0x%08X mapped to 0x%08X, polled IO, %ldKB\n",
> +		       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress,
> +		       size / 2);

(No XSA_IRQ here!)

> +	}
> =20
>  	/* Hook our reset function into system's restart code. */
>  	old_restart =3D ppc_md.restart;

				    Tonnerre

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBUlZB/4bL7ovhw40RApA4AKCm0TbU32ZFJTIMEo+KK3ehKZ/S2wCgwVyx
/3cWwaBghkgxNCSovpeyqIw=
=7ks8
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
