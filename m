Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTHFQkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHFQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:39:05 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:26879 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S270811AbTHFQhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:37:54 -0400
Date: Wed, 6 Aug 2003 09:37:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Pool <mbp@samba.org>
Cc: Richard Zidlicky <rz@linux-m68k.org>, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] [Kconfig] disable GEN_RTC on ia-64
Message-ID: <20030806163753.GB579@ip68-0-152-218.tc.ph.cox.net>
References: <20030806074312.GT22302@vexed.ozlabs.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20030806074312.GT22302@vexed.ozlabs.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2003 at 05:43:13PM +1000, Martin Pool wrote:

> IA-64 does not have a directly accessible real-time clock.  As far as
> I know the only method to access the clock on this platform is to go
> through EFI (Extensible Firmware Interface, like a BIOS), which is
> handled by efirtc.c.

I think that this is the wrong approach.  genrtc allows the platform to
specify how the rtc is to be accessed.  Therefore, efirtc.c could quite
probably be removed in favor of genrtc.c, if the proper read/write
functions are provided, and if genrtc gets alarm code, which is
something others (rmk at least) have asked for.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MS7hdZngf2G4WwMRAk3xAJwIIuAxhlCFxD/v4954DO1LEPvoNwCglil2
85WLnCoeCLCLdfdIjOPc7fQ=
=4aLM
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
