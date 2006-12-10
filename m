Return-Path: <linux-kernel-owner+w=401wt.eu-S1762584AbWLJU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762584AbWLJU43 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762586AbWLJU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:56:28 -0500
Received: from sccrmhc15.comcast.net ([63.240.77.85]:42606 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762584AbWLJU42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:56:28 -0500
Message-ID: <457C747A.6010702@comcast.net>
Date: Sun, 10 Dec 2006 15:56:26 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
References: <457B1F02.7030409@comcast.net>	 <1165743478.27217.187.camel@laptopd505.fenrus.org>	 <457C28F8.4050409@comcast.net> <1165779603.27217.231.camel@laptopd505.fenrus.org>
In-Reply-To: <1165779603.27217.231.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>> Too bad PAE can't be detected at boot time; someone else mentioned that
>> some recent Pentium M laptops (and anything older than PPro) don't boot
>> if PAE is on.
> 
> even Windows has 2 kernel binaries for this case btw, it's really really
> really hard.
> 

Yeah, I've been told Windows has 4 kernels (SMP/UP x PAE/NonPAE).  In
the case of a microkernel it'd be trivial; in the case of a monolith,
you'd basically be shoehorning uK behavior in, probably by compiling
both sets of functions and linking the appropriate set just-in-time
(i.e. before entering protected mode).  This would be an ugly hack.

>> I want my hardware NX bit working in Ubuntu without having to recompile
>> my kernel dammit.
> 
> other distros ship a PAE enabled kernel, and use that for NX enabled
> machines (all NX capable machines support PAE obviously). I'm surprised
> Ubuntu doesn't, maybe ask them? (Or use a distro that does have this)
> 

OpenSuSE and Fedora Core 6 both fail this; I checked the .config for the
default kernels (by proxy on OpenSuSE 10.2; I asked someone) and ran my
test case on FC6 (LiveCD from
http://www.fedoraunity.org/news-archives/fedora-core-6-zod-live-spins-released).



- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXx0eQs1xW0HCTEFAQIgvA/+PEGnseTwVbvk7OidaUc6aISYEwrp8vMs
nIZ+tJ5wB4bDkXbMPDE2TcrGwJiBsRapLw777QR//5xMww+Lnt0egXmpJhBWFcDu
VL+s0UxSukC/JcASKX3S/lYzhjjkSXkbEoaeqgq9ZRL/v49P8zsYCIJx39M20oOR
+qIv7TuC3LRPeZmJMiTDMIKzheAdzwofAfuV+7UfTOJB8dYHapHDQ4qZjEzUXr/K
FV/XjN2E9icSFeDgoE6KB6N5nVzpr9WkmXMIccy0HR148Ky2ee04y9/3Pdr40glG
+dNeDPwPxQEigv2GN21fxPNdYGu2JBX2/LadxJ9EB38g0xGjzT67NwEmUrBxyHOl
8I8mZTPiqf9+f1NpHMFo5jIFynaaaKS/F34TYa30CSULMZ8cRsCPK8Jk5JAFI2ay
NZofsjGZ2YwZVd8HkZVeDgBC38XHXwHmi0y4ZV2tMmwQrOe4c6Nr7U9J6CCMNK2c
nQVSjV94uAn8I0qCqG/NkkrBtVnc8XdYOXkwvkA2BM0vFTRhKC/UaYX73yBvJm09
4QNnWAOI0p78gWMoXYmowXggcI1ERc2ca2I+rVQRF7hsWbcco7SAdcItpbn+k1xl
w/Fr0ZhgVKSc7M1Nd/zIZ3e7uhF7xqUMd3kcqDcbu/SF4Fvalpww00Db99oZ5J08
sPSFno97ScM=
=pjHt
-----END PGP SIGNATURE-----
