Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWA1UG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWA1UG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 15:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWA1UG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 15:06:29 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:11756 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750709AbWA1UG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 15:06:28 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] framebuffer: Remove old radeon driver
Date: Sat, 28 Jan 2006 21:06:15 +0100
User-Agent: KMail/1.7.2
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
       linux-kernel@hansmi.ch
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com>
In-Reply-To: <43DB0839.6010703@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1438616.5JCsMlfsIx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601282106.21664.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1438616.5JCsMlfsIx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 28 January 2006 06:59, Antonino A. Daplas wrote:
> The console layer has 5 blanking levels, with FB_BLANK_NORMAL defined
> as "soft blank" (or blank the display without turning off display sync
> signals) -- a console invention.  However, VESA has only 4 levels.
>=20
> This can be easily fixed by incrementing the blank value by one if
> the request originated from userspace.  I'll provide a patch
> soon.

May I suggest to hide this implementation detail?

E.g. please provide a macro/function blank_fb2vesa() just
for this detail instead of doing magic increments in those drivers.

Many thanks!


Regards

Ingo Oeser


--nextPart1438616.5JCsMlfsIx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD2869U56oYWuOrkARAh7HAJ9oIKamn6xSR6H22YXTP1Mgdj8KWQCgtXbf
DMxPDWtEo4fxMk3Fk46Y0j4=
=KTdn
-----END PGP SIGNATURE-----

--nextPart1438616.5JCsMlfsIx--
