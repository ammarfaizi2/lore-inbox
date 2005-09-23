Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVIWRL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVIWRL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIWRL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:11:26 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:38823 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750827AbVIWRLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:11:25 -0400
Date: Fri, 23 Sep 2005 19:11:20 +0200
From: Harald Welte <laforge@netfilter.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050923171120.GO731@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Eric Dumazet <dada1@cosmosbay.com>,
	Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	netdev@vger.kernel.org
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de> <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com> <4332D2D9.7090802@cosmosbay.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zX3fAKQGR/qU2rkc"
Content-Disposition: inline
In-Reply-To: <4332D2D9.7090802@cosmosbay.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zX3fAKQGR/qU2rkc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 05:50:49PM +0200, Eric Dumazet wrote:
> Christoph Lameter a =E9crit :
> >It should really be do_set_mempolicy instead to be cleaner. I got a patc=
h here that fixes the=20
> >policy layer.
> >But still I agree with Christoph that a real vmalloc_node is better. The=
re will be no fuzzing=20
> >around with memory policies etc and its certainly better performance wis=
e.
>=20
> vmalloc_node() should be seldom used, at driver init, or when a new
> ip_tables is loaded. If it happens to be a performance problem, then
> we can optimize it.  Why should we spend days of work for a function
> that is yet to be used ?

I see a contradiction in your sentence.  "a new ip_tables is loaded"
every time a user changes a single rule.  There are numerous setups that
dynamically change the ruleset (e.g. at interface up/down point, or even
think of your typical wlan hotspot, where once a user is authorized,
he'll get different rules.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--zX3fAKQGR/qU2rkc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNDc4XaXGVTD0i/8RAqnBAKCfRMNevxMlSGWrxG2MlM7f2lIyZACfXojX
3F5CLPAAbQeVya9mb1m8Nv4=
=cndT
-----END PGP SIGNATURE-----

--zX3fAKQGR/qU2rkc--
