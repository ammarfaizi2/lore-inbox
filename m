Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUAKSTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUAKSTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:19:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11153 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265928AbUAKSTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:19:50 -0500
Date: Sun, 11 Jan 2004 19:19:32 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.1 and irq balancing
Message-ID: <20040111181932.GA6192@devserv.devel.redhat.com>
References: <40008745.4070109@stinkfoot.org> <1073814681.4431.5.camel@laptop.fenrus.com> <20040111165012.GA24746@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20040111165012.GA24746@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2004 at 11:50:12AM -0500, Joe Korty wrote:
> On Sun, Jan 11, 2004 at 10:51:22AM +0100, Arjan van de Ven wrote:
> > On Sun, 2004-01-11 at 00:14, Ethan Weinstein wrote:
> > > Greetings all,
> > >=20
> > > I upgraded my server to 2.6.1, and I'm finding I'm saddled with only=
=20
> > > interrupting on CPU0 again. 2.6.0 does this as well. This is the=20
> > > Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled.=20
> > > /proc/cpuinfo is normal as per HT, displaying 4 cpus.
> >=20
> > you should run the userspace irq balance daemon:
> > http://people.redhat.com/arjanv/irqbalance/
>=20
> I have long wondered what is so evil about most interrupts going to
> CPU 0 that we felt we had to have a pair of irqdaemons in 2.6.

well irqbalanced is a userspace balancer

> Earlier APICs had a variation where the search for where each new
> interrupt was to go started with first cpu after the one that got the
> last interrupt.  If we call this 'round-robin' allocation, then today's
> technique could be described as 'first fit'.

if it's really busy it starves cpu0 ....=20

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAZOzxULwo51rQBIRAgFrAKCNVN2WD5zaK522JZTM4B/QAdjOowCfTcc7
uvdOIKkZN4Fq/QJelPABOjY=
=GmKk
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
