Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUHUMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUHUMYO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUHUMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:24:14 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:23174 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263795AbUHUMYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:24:10 -0400
Message-ID: <41273EDE.5090407@kolivas.org>
Date: Sat, 21 Aug 2004 22:23:58 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Beppler <info@cbeppler.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: DMA over CPU" memory leak in Kernel 2.6.8.1
References: <41273CB1.1090302@cbeppler.de>
In-Reply-To: <41273CB1.1090302@cbeppler.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD0E5C40C04F29659580D3043"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0E5C40C04F29659580D3043
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christopher Beppler wrote:
> Hi... this is my first bug report. I hope that it will help you.
> 
> Thank You
> 
> 1.
> "DMA over CPU" memory leak if I burn Audio-CDs
> 
> 2.
> I installed Linux 2.6.8.1 and tried to burn an Audio-CD. Then the PC 
> swapped a lot until he freezes. I tried to increase the swap-partition 
> without a success. Then I stopped burning with xcdroast and burned on 
> the bash directly with cdrecord (dev=ATAPI:0,1,0). Then I saw always at 
> the same time. DMA over CPU-Error... an many memory dumps rushed over my 
> screen and he started "swapping to death" He killed some processes to 
> get more memory (I have 256MB RAM and 384 MB swap). I am not able to 
> print these Error-Messages, because I have no access to my PC then. Then 
> I installed Linux 2.6.7 again and everything works probably.

Known bug. There is a fix for this in the 2.6.8.1-mm3 patch. You can 
download just the required patches to fix this problem by applying these 
two patches:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak.patch
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/broken-out/bio_uncopy_user-mem-leak-fix.patch

Always worth checking the recent linux-kernel archives before filing a 
report but don't let that stop you from filing a bug report.

Thanks,
Con

--------------enigD0E5C40C04F29659580D3043
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJz7gZUg7+tp6mRURAvueAJ9crl/8n7NgA4aaQMnwU33G1uAXPQCggeJI
41bN5aqnrBAefV91wGYdJgk=
=e7Ma
-----END PGP SIGNATURE-----

--------------enigD0E5C40C04F29659580D3043--
