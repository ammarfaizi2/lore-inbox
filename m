Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWD0Tbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWD0Tbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 15:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWD0Tbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 15:31:44 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:23443 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S965069AbWD0Tbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 15:31:44 -0400
Date: Thu, 27 Apr 2006 16:24:30 -0300
From: Harald Welte <laforge@netfilter.org>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: CONFIG_KMOD in x86_64/defconfig (was Re: iptables is complaining with bogus unknown error 18446744073709551615)
Message-ID: <20060427192430.GE21823@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Maurice Volaski <mvolaski@aecom.yu.edu>,
	netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <200604210738.k3L7cBGO010103@mailgw.aecom.yu.edu> <a06230901c075ca078b8d@[129.98.90.227]> <20060427135119.GB5177@rama> <a06230904c07687df0a33@[129.98.90.227]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <a06230904c07687df0a33@[129.98.90.227]>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2006 at 11:41:40AM -0400, Maurice Volaski wrote:
> >On Wed, Apr 26, 2006 at 09:12:38PM -0400, Maurice Volaski wrote:
> >> Automatic kernel module loading! That is an option and it's off by
> >> default. When it's off, attempts to load kernel modules are ignored
> >> internally, and that's why iptables was failing. It tried to load
> >> xt_tcpudp, but was ignored by the kernel.
> >What do you mean by "it's an option" and "is off by default".  I would
> >claim that any major linux distribution that I've seen in the last ten
> >years has support for module auto loading (enabled by default).
>=20
> Distribution vendors are free to change it to whatever they want, I guess=
, but it's OFF by=20
> default in the official kernel (.config).

apparently architecture-specific:

grep KMOD arch/i386/defconfig
CONFIG_KMOD=3Dy

grep KMOD arch/x86_64/defconfig
CONFIG_KMOD is not set

don't know why x86_64 turns it off by default.  the help message says
'if unsure, say Y' (which makes sense!)
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEURpuXaXGVTD0i/8RAo70AJ4gXihEWtdsN/L0ft8JGl2XrY6DOACcCqgI
g7E79jG0ptEY7pOZIg69oKI=
=vcPr
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
