Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUGIAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUGIAkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 20:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUGIAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 20:40:14 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:51941 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262006AbUGIAkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 20:40:06 -0400
Message-ID: <40EDE956.80705@kolivas.org>
Date: Fri, 09 Jul 2004 10:39:50 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Autotune swappiness
References: <40EC13C5.2000101@kolivas.org>	<40EC1930.7010805@comcast.net>	<40EC1B0A.8090802@kolivas.org>	<20040707213822.2682790b.akpm@osdl.org>	<cone.1089268800.781084.4554.502@pc.kolivas.org>	<20040708001027.7fed0bc4.akpm@osdl.org>	<cone.1089273505.418287.4554.502@pc.kolivas.org>	<20040708010842.2064a706.akpm@osdl.org>	<40ED7534.4010409@kolivas.org> <20040708094406.2b0293ea.akpm@osdl.org>
In-Reply-To: <20040708094406.2b0293ea.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD83EF73F5047581B5D24776"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD83EF73F5047581B5D24776
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> 
>>Here is another try at providing feedback to tune the vm_swappiness.
> 
> 
> I spent some time yesterday trying to demonstrate performance improvements
> from those two patches.  Using
> 
> 	make -j4 vmlinux with mem=64m
> 
> and
> 
> 	qsbench -p 4 -m 96 with mem=256m
> 
> and was not able to do so, which is what I expected.
> 
> We do need more quantitative testing on this work.

Sure thing.

I need to point out a few things:
The point of this patch was to improve the swap behaviour on desktop 
like loads.
The fact that it improved the "when swap is thrashing" scenario (in my 
testing) was an unintentional bonus.
I dont think your load of j4 will induce quite the same swap thrash as 
what I was testing. I actually suspect the faster cpu & more jobs over 
fixed memory shows it more.
I need someone with more varied hardware to test it for me. I can 
recreate equivalent results on my current machine which has similar 
hardware, but I think results showing improvement on different machines 
  and different loads is what you're looking for... and since I'm 
currently quite low on hardware I can only offer results from this one 
(and my wife is hating it being offline o_0)

Anyone willing to offer to do some tests?

Con

--------------enigCD83EF73F5047581B5D24776
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7elZZUg7+tp6mRURAlIyAJ0TkZtxQh7upF4azvbNLvwQ6iOUbgCdFCM8
OnxyqkYUebMVWHGYJehwPdc=
=VrTn
-----END PGP SIGNATURE-----

--------------enigCD83EF73F5047581B5D24776--
