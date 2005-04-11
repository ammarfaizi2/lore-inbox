Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVDKHys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDKHys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVDKHys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:54:48 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:10969 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261724AbVDKHyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:54:44 -0400
Date: Mon, 11 Apr 2005 09:54:43 +0200
To: Andreas Steinmetz <ast@domdv.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 0/3] encrypted swsusp image
Message-ID: <20050411075441.GT29797@vanheusden.com>
References: <4259B46D.9020402@domdv.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <4259B46D.9020402@domdv.de>
User-Agent: Mutt/1.3.28i
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Apr 11 21:15:42 CEST 2005
X-MSMail-Priority: High
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The following patches allow for encryption of the on-disk swsusp image
> to prevent data gathering of e.g. in-kernel keys or mlocked data after
> resume.
> For this purpose the aes cipher must be compiled into the kernel as
> module load is not possible at resume time.
> A random key is generated at suspend time, stored in the suspend header
> on disk and deleted from the header at resume time. If you don't resume
> a mkswap on the suspend partition will also delete the temporary key.
> Only the data pages are encrypted as only these may contain sensitive data.
> This works on my x86_64 laptop (64bit mode) and probably needs testing
> on other platforms.

What about an option for an user-defined key? One that can be set when
suspending?


Folkert van Heusden

Auto te koop! Zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iIMEARECAEMFAkJaLUE8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuEvMAniZF8fS6
2YeJKTEMB3Vb/VVc6uCsAJ4mjC3huP5IyzWRXUokgzGaU6PF/Q==
=/4tC
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
