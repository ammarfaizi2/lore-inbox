Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTI2Omy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTI2Omy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:42:54 -0400
Received: from h80ad2481.async.vt.edu ([128.173.36.129]:56775 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263467AbTI2Omw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:42:52 -0400
Message-Id: <200309291438.h8TEcVtH021550@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@fs.tum.de>,
       netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6 
In-Reply-To: Your message of "Mon, 29 Sep 2003 11:15:48 -0300."
             <20030929141548.GS1039@conectiva.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de> <20030929003229.GM1039@conectiva.com.br> <1064826174.29569.13.camel@hades.cambridge.redhat.com>
            <20030929141548.GS1039@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1830453198P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 10:38:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1830453198P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 11:15:48 -0300, Arnaldo Carvalho de Melo said:

> Humm, so the user will have, in this case, these choices:
> 
> 1. "I don't want IPV6 at all, not now, not ever":
> 	CONFIG_IPV6_SUPPORT=N
> 	CONFIG_IPV6=N  (this is implicit as this depends on
> 			CONFIG_IPV6_SUPPORT)
> 	
> 2. "I think I may well want it the future, who knows? but not now...":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=N
> 	
> 3. "Nah, some of the users of this pre-compiled kernel will need it":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=M
> 	
> 4. "Yeah, IPV6 is COOL, how can somebody not use this piece of art?":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=Y
> 
> Isn't this confusing for the I-wanna-triple-my-kernel-performance-by-compiling-
> the-kernel-for-exactly-what-I-have hordes of users?

No, this is the behavior we want, and we can write Kconfig help entries that
explain it.

Anybody want to do a sanity check against CONFIG_IP6_NF_IPTABLES - that
looks like another gotcha if it isn't implemented properly (it may be, I just haven't
actually looked it over)?

--==_Exmh_1830453198P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eEPmcC3lWbTT17ARAs7tAKCZSYrY97dttuyIPMbTMOriFuOSiwCgocI6
QeTeCGLBJLDUFiANiXNjAvU=
=LbCU
-----END PGP SIGNATURE-----

--==_Exmh_1830453198P--
