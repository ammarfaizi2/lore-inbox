Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUDIPh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUDIPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 11:37:28 -0400
Received: from mh57.com ([217.160.185.21]:6342 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S261410AbUDIPhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 11:37:25 -0400
Date: Fri, 9 Apr 2004 17:37:21 +0200
From: Martin Hermanowski <lkml@martin.mh57.de>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-mm2 (swsusp not working and acpi problem)
Message-ID: <20040409153720.GA5713@mh57.de>
References: <20040406223321.704682ed.akpm@osdl.org> <20040407065154.GG1139@ens-lyon.fr> <20040407001004.0360a049.akpm@osdl.org> <1081344258.10773.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <1081344258.10773.3.camel@mulgrave>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.0 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I tried updating from 2.6.4-rc1-mm2 to 2.6.5-mm2, and I found two
problems:

First, swsusp stopped working, I get a NULL pointer in
`poke_blanked_console' after all the other things seem to be fine.

I made a screenshot available under
http://mh57.de/~martin/oops-part1.png and
http://mh57.de/~martin/oops-part2.png

This happens regardless of starting X or using the framebuffer. The
hardware is an IBM Thinkpad T41p. In the screenshots above, the kernel
is tainted from the madwifi module, but not loading it before did not
change the oops.

The kernel contains two more patches, linux-iscsi-kernel-4.0.1.3.patch
and linux-2.6.3-mppe-mppc-0.99.patch.gz, but these two modules were not
loaded before during my tests.

The kernel config can be downloaded at
http://mh57.de/~martin/265-cfg-notworking , I am booting with noapic and
nolapic.

The other problem is less easy to describe, with 2.6.5-mm2, the notebook
seems to have a higher power consumption then with 2.6.4-rc1-mm2, ie. I
get about 20min less runtime out of my battery. I will investigate oh
this later.

LLAP, Martin

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAdsMwmGb6Npij0ewRArYmAJ97p34F8Hk5tfijPStcOhHfpDXy6QCgpxCQ
y2cF8Xt9wHL2pAbZJuVufCA=
=Tr8L
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
