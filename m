Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUHCI2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUHCI2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 04:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUHCI2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 04:28:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50320 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264665AbUHCI1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 04:27:22 -0400
Subject: Re: Initial bits to help pull jiffies out of drivers
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040727195939.GA20712@devserv.devel.redhat.com>
References: <20040727195939.GA20712@devserv.devel.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YrP7CZQDQNuG8jMzd6UW"
Organization: Red Hat UK
Message-Id: <1091521635.2816.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 10:27:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YrP7CZQDQNuG8jMzd6UW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-27 at 21:59, Alan Cox wrote:
> This is really for comment, the basic idea is to add some relative
> timer functionality. This gives us timeout objects as well as pulling
> jiffies use into one place in the timer code. The need for the old
> interfaces never goes away however because some code uses a previous
> event base to construct timeouts to avoid sliding due to the latency
> between service and re-addition.
>=20
> (please cc me on comments)

My gripe with this is that the interface still is relative-to-HZ time.
I'm convinced that driver(writers) are better off with an absolute time
interface, eg add_timeout_ms(), add_timeout_us() etc.
(which btw also give a hint about the accuracy required, so that the
kernel can group milisecond delays together even when they got scheduled
at different usecs, once we get timers that accurate)


--=-YrP7CZQDQNuG8jMzd6UW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBD0xjxULwo51rQBIRAoO8AJ0U0IdW2IlGIUk9ruhXIT0DSf04iwCfR0cZ
dkaEm1gWXr0G3uJTLcu3ZU0=
=Eth5
-----END PGP SIGNATURE-----

--=-YrP7CZQDQNuG8jMzd6UW--

