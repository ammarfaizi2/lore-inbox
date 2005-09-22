Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbVIVMsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVIVMsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVIVMsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:48:12 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:5808 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751465AbVIVMsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:48:10 -0400
Date: Thu, 22 Sep 2005 14:48:03 +0200
From: Harald Welte <laforge@netfilter.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050922124803.GH26520@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
	Andi Kleen <ak@suse.de>
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D168.6090604@cosmosbay.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <4331D168.6090604@cosmosbay.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 11:32:24PM +0200, Eric Dumazet wrote:
> Patch 2/3 (please apply after Patch 1/3)
>=20
> 2) Loop unrolling

First of all, thanks for your performance analysis and patches.  I'm
very inclined of merging them.

> It seems that with current compilers and CFLAGS, the code from
> ip_packet_match() is very bad, using lot of mispredicted conditional bran=
ches I made some patches=20
> and generated code on i386 and x86_64
> is much better.

This only describes your "compare_if_lstrings()" changes, and I'm happy
to merge them.

However, you also removed the use of the FWINV macro and replaced it by
explicit code (including the bool1/bool2 variables, which are not really
named intuitively).  Why was this neccessary?

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMqgDXaXGVTD0i/8RAmvEAKCh7h1gJQEEvLrGEh9tjU8XrdMRYACfWAzh
yA3cqNf2lwj5yn0fPfF+rAo=
=whE0
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
