Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbULOJDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbULOJDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbULOJDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:03:32 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:25024 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261869AbULOJDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:03:24 -0500
Date: Wed, 15 Dec 2004 10:03:22 +0100
From: Harald Welte <laforge@netfilter.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: coreteam@netfilter.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [netfilter-core] [2.6 patch] net/ipv4/netfilter/: misc possible cleanups
Message-ID: <20041215090322.GA2862@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Adrian Bunk <bunk@stusta.de>, coreteam@netfilter.org,
	netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20041215011931.GD12937@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20041215011931.GD12937@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2004 at 02:19:31AM +0100, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - ip_conntrack_core.c: ip_conntrack_expect_find_get
>   - ip_conntrack_core.c: ip_conntrack_unexpect_related
>   - ip_nat_standalone.c: ip_nat_protocol_register
>   - ip_nat_standalone.c: ip_nat_protocol_unregister
>   - ip_nat_helper.c: ip_nat_find_helper
> - remove the following unneeded EXPORT_SYMBOL's:
>   - ip_conntrack_standalone.c: ip_ct_find_helper
>   - ip_conntrack_standalone.c: ip_conntrack_unexpect_related
>   - ip_conntrack_standalone.c: ip_conntrack_expect_list
>   - ip_conntrack_standalone.c: ip_conntrack_put
>   - ip_nat_standalone.c: ip_nat_protocol_register
>   - ip_nat_standalone.c: ip_nat_protocol_unregister
>   - ip_nat_standalone.c: ip_nat_find_helper
> - remove the following unneeded EXPORT_SYMBOL_GPL:
>   - ip_conntrack_standalone.c: ip_conntrack_expect_find_get

As you might be aware, netfilter/iptables has an enormously large
codebase (I'd say even larger than what is in the tree) in the so-called
patch-o-matic subsystem.  The abovementioned exports facilitate those
modulse, and A certain amount of those new modules (especially the ones
requiring the functions above) are scheduled for mainline inclusion over
the next couple of months.

>   - ipfwadm_core.c: ip_acct_ctl

This can be removed, yes.  Please be aware that ipfwadm and ipchains
will be removed soon (after 2.6.10 is out), so that won't be a problem
any more :)

> - remove the following variables that never change their values:
>   - ip_conntrack_ftp.c: ip_conntrack_ftp
>   - ip_conntrack_irc.c: ip_conntrack_irc

Mh, I don't really understand why this change was introduced.  My
original _irc code didn't have this global variable...  I'll try to
track the change and get back to you.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBv/3ZXaXGVTD0i/8RAoTLAKCMebmX0BaH+KMxoq2A+peqvkylDwCglJKO
cZtj+5CjN6pU60yX43ERto0=
=t3FD
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
