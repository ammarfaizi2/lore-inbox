Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVJCS21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVJCS21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJCS21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:28:27 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48276 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932499AbVJCS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:28:26 -0400
Message-Id: <200510031828.j93ISITM019190@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [PATCH 6/7] AMD Geode GX/LX support 
In-Reply-To: Your message of "Mon, 03 Oct 2005 12:02:00 MDT."
             <20051003180200.GH29264@cosmic.amd.com> 
From: Valdis.Kletnieks@vt.edu
References: <20051003180200.GH29264@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128364098_5142P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 14:28:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128364098_5142P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Oct 2005 12:02:00 MDT, Jordan Crouse said:

> +static u32 geode_data_read(void) {
> +	u32 val;
> +
> +	val = *((u32 *) (geode_rng_base + GEODE_RNG_DATA_REG));
> +	return val;
> +}
> +
> +static unsigned int geode_data_present(void) {
> +	u32 val;
> +
> +	val = *((u32 *) (geode_rng_base + GEODE_RNG_STATUS_REG));
> +	return val;
> +}

Yowza.

At least the intel_* routines do this sort of thing to semi-check that the
sucker exists:

        assert (rng_mem != NULL);
        writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);

What does your code do if geode_init() manages to fail somehow?

--==_Exmh_1128364098_5142P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQXhCcC3lWbTT17ARAtlHAJ9UxW1LYJiCUmo/wRfYv1J4MtngjQCfQh2m
erC5CmjFjT+joKgoTa1nf+k=
=KPWz
-----END PGP SIGNATURE-----

--==_Exmh_1128364098_5142P--
