Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWEQKzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWEQKzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEQKzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:55:06 -0400
Received: from kenobi.snowman.net ([70.84.9.186]:38028 "EHLO
	kenobi.snowman.net") by vger.kernel.org with ESMTP id S1751144AbWEQKzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:55:04 -0400
Date: Wed, 17 May 2006 06:55:03 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@davemloft.net>, azez@ufomechanic.net,
       willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060517105503.GR7774@kenobi.snowman.net>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	"David S. Miller" <davem@davemloft.net>, azez@ufomechanic.net,
	willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	marcelo@kvack.org
References: <20060515204142.GO7774@kenobi.snowman.net> <20060515210342.GP7774@kenobi.snowman.net> <446AC1FB.5070406@trash.net> <20060516.235910.71774114.davem@davemloft.net> <446ACE67.4030700@trash.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jcwRHPSxFqmwpRFb"
Content-Disposition: inline
In-Reply-To: <446ACE67.4030700@trash.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-1-vserver-686 (i686)
X-Uptime: 06:49:46 up 9 days,  4:45, 12 users,  load average: 1.05, 0.99, 0.83
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jcwRHPSxFqmwpRFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Patrick McHardy (kaber@trash.net) wrote:
> David S. Miller wrote:
> > Is there any reasonable reason to allow ip_pkt_list_tot to ever be
> > larger than say 255?  If we can accept that limit, we can shrink
> > the recent_entry considerably by packing the index and nstamps
> > into a single word next to ttl.
>=20
> My primary goal was full compatibility, I have no idea about real-life
> usage though. Maybe Stephen can answer this.

I don't recall ever seeing > 255 usage.  It's been pretty rare for it to
be changed from the default at all from what I've seen.  Making the
limit be 255 seems perfectly reasonable to me.

	Thanks,

		Stephen

--jcwRHPSxFqmwpRFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEawEHrzgMPqB3kigRAjMMAJ92CfODRrxPzNj0jUwyfK5FVJZpFACfcKqd
cyCkvPPUZnGhPWpgr80Pwfg=
=iweL
-----END PGP SIGNATURE-----

--jcwRHPSxFqmwpRFb--
