Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUDHQKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUDHQKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:10:47 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:39299 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261943AbUDHQKD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:10:03 -0400
Message-Id: <200404081558.i38Fw2SU014685@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mathieu Giguere <Mathieu.Giguere@ericsson.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv4 and IPv6 stack multi-FIB, scalable in the million of entries. 
In-Reply-To: Your message of "Thu, 08 Apr 2004 10:40:46 EDT."
             <001a01c41d77$7a609440$0348858e@D4SF2B21> 
From: Valdis.Kletnieks@vt.edu
References: <001a01c41d77$7a609440$0348858e@D4SF2B21>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1676565424P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Apr 2004 11:58:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1676565424P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Apr 2004 10:40:46 EDT, Mathieu Giguere said:
>     We currently looking for a multi-FIB, scalable routing table in the
> million of entries, no routing cache for IPv4 and IPv6.  We want a IP stack
> that can have a log(n) (or better) insertion/deletion and lookup
> performance.  Predictable performance, even in the million of entries.

Gaak.

The guys at http://www.cidr-report.org are only showing 130K or so prefixes in
the global routing table (and estimate that it could be kicked down to 90K or
so with better CIDR aggregation.

I won't ask what sort of totally martian network design is leading to a routing
table of millions of entries - even the "stick PMTU info into a host route" trick
should expire routes to hosts you're not talking to, and you're probably going
to be wanting a load balancer if you're talking to hundreds of thousands of
machines at the same time.....



--==_Exmh_1676565424P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdXaKcC3lWbTT17ARAuIaAJ48P6xzXoSGnUR8l4mtT/d+H5Lm4wCfTq2x
3UhKjZ07+jjqhgosXQLxMsA=
=98kW
-----END PGP SIGNATURE-----

--==_Exmh_1676565424P--
