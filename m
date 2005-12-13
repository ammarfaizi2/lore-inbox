Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVLMNej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVLMNej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVLMNej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:34:39 -0500
Received: from kleinhenz.com ([213.239.205.196]:64953 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S932153AbVLMNei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:34:38 -0500
Message-ID: <439ECDCC.80707@hogyros.de>
Date: Tue, 13 Dec 2005 14:34:04 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, paulus@samba.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       dwmw2@infradead.org, linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
References: <20051211185212.GQ23349@stusta.de>	<20051211192109.GA22537@flint.arm.linux.org.uk>	<20051211193118.GR23349@stusta.de>	<20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de>
In-Reply-To: <20051213001028.GS23349@stusta.de>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig113C1197884926ACD3D8B3B4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig113C1197884926ACD3D8B3B4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Adrian Bunk wrote:

>>It's a problem introduced by your patch because the resulting defconfig
>>file becomes _wrong_ by your change, and other changes in the defconfig
>>are thereby hidden.
>>...

> No, CONFIG_BROKEN=y in a defconfig file is a bug.

Indeed, but that's not the point. A defconfig file should be the result 
of running one of the various configuration targets; yours are 
hand-patched. If you run the defconfig target, it will copy the config 
file and run oldconfig, thus resulting in a different configuration file 
(because options may now be gone and hence disabled) than what was in 
the defconfig, and thus people may come to the wrong conclusion that if 
a driver is enabled in a defconfig file, it will be built.

    Simon

--------------enig113C1197884926ACD3D8B3B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ57NzVYr4CN7gCINAQL+jAQAjf9uj07ZkTXInhywX9qoZN1m70XTuPxl
h0PVv4ms9q3sf7DFwasFyyq/39FhgSlivBKS3LdYzvssMIZCQ6qsS/v2znllqRGp
3rR2vSWjAhxnX25ekYUNYanRqSYtUBU3E9rNEDyPiKdxXfPWZd+3DzIWKHh//AdR
syvKAqLxHhE=
=sMLF
-----END PGP SIGNATURE-----

--------------enig113C1197884926ACD3D8B3B4--
