Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWD1WtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWD1WtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWD1WtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:49:00 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:18397 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932080AbWD1Ws7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:48:59 -0400
Date: Fri, 28 Apr 2006 19:50:03 -0300
From: Harald Welte <laforge@netfilter.org>
To: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: linux/iptables + smp question
Message-ID: <20060428225003.GF5598@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Juan Pablo Abuyeres <jpabuyer@tecnoera.com>,
	linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
References: <44520085.3030909@tecnoera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <44520085.3030909@tecnoera.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2006 at 07:46:13AM -0400, Juan Pablo Abuyeres wrote:
> Hi guys,

Hi, please follow up to the netfilter mailinglist, since this is not a
kernel [development] question.

> I've been using an old single processor / linux 2.4 iptables based firewa=
ll for a few years.
>
> Now it's time to upgrade that machine, so, I am wondering, would it be of=
 real benefit if I put a=20
> two-processor system for a firewall? This machine is going to have 4 NICs=
, it's going to make=20
> routing (lots of routes), and firewall (iptables). I don't know if these =
kind of tasks take=20
> advantage from a multiple-processor architecture. Please enlighten me :)

some notes:

1) 2.6. network stack scales better on smp
2) iptables and routing both scale very good on smp systems, if you use
   multiple interfaces and distribute the interrupts over multiple cpus
3) connection tracking inherently scales less good on SMP systems

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUpwbXaXGVTD0i/8RApw2AKCFWxyvFb9TzA9mAQCmWXEUvAx62QCeNn/v
volpm1hk2KEzZvGUICE6kmo=
=wtmq
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
