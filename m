Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWARPCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWARPCO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWARPCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:02:14 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:47080 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030328AbWARPCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:02:13 -0500
Date: Wed, 18 Jan 2006 16:01:58 +0100
From: Harald Welte <laforge@netfilter.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linuxppc-dev@ozlabs.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1: iptables broken on ppc32?
Message-ID: <20060118150158.GL4603@sunbeam.de.gnumonks.org>
Reply-To: netfilter-devel@lists.netfilter.org
Mail-Followup-To: netfilter-devel@lists.netfilter.org,
	Mikael Pettersson <mikpe@user.it.uu.se>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <17358.19458.555996.684819@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <17358.19458.555996.684819@alkaid.it.uu.se>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2006 at 03:09:06PM +0100, Mikael Pettersson wrote:
> When trying out kernel 2.6.16-rc1 on a ppc32 box (G4 eMac),
> the kernel refused to load my /etc/sysconfig/iptables. strace
> on /sbin/iptables-restore shows that the kernel returns EINVAL
> instead of accepting the configuration:

thanks for letting us know, you might have catched a very important bug.

We've introduced a number of changes (x_tables) that haven't received
testing on all architectures yet.

I will try to reproduce the bug on my debian ppc box here.

This is not meant as a fix, but you might try it to narrow down the
problem:  Try recompiling iptables on your own, and report back whether
that works or not.

Please Follow-up-to netfilter-devel@lists.netfilter.org

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzlhmXaXGVTD0i/8RAuxWAKCJEYDaJKIY62DJFMie5Xjc1MWGSQCcD87x
XWvW1z5qr4aJQ31RxIdj4Zg=
=f1wE
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
