Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUILHcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUILHcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUILHcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:32:16 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:7840 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S268511AbUILHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:32:14 -0400
Date: Sun, 12 Sep 2004 00:29:45 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: Possible dcache BUG
Message-ID: <20040912002945.29a976ad@laptop.delusion.de>
In-Reply-To: <20040912001626.759e2d17.akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040912000354.7243a328@laptop.delusion.de>
	<20040912001626.759e2d17.akpm@osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__12_Sep_2004_00_29_45_-0700_PObuK35=dzSJ/dZf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__12_Sep_2004_00_29_45_-0700_PObuK35=dzSJ/dZf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 12 Sep 2004 00:16:26 -0700 Andrew Morton (AM) wrote:

AM> Random guess: acpi_evaluate_object() is returning an error but is
AM> allocating memory anyway.
AM> 
AM> In acpi_battery_get_status():
AM> 
AM> 	status = acpi_evaluate_object(battery->handle, "_BST", NULL, &buffer);
AM> 	if (ACPI_FAILURE(status)) {
AM> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _BST\n"));
AM> 		return_VALUE(-ENODEV);
AM> 	}
AM> 
AM> Is that failure path being taken?

Is there a way for me to find that out without recompiling and rebooting?

-Udo.

--Signature=_Sun__12_Sep_2004_00_29_45_-0700_PObuK35=dzSJ/dZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBQ/runhRzXSM7nSkRAk0pAJ9uKi1w3cfOt5TimchJZsA/I9uFmACeMRw3
/yBCjASbcdrcOC/5GWVbzac=
=pEvV
-----END PGP SIGNATURE-----

--Signature=_Sun__12_Sep_2004_00_29_45_-0700_PObuK35=dzSJ/dZf--
