Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbULYLlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbULYLlf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 06:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULYLlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 06:41:35 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:6054 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261499AbULYLlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 06:41:32 -0500
Message-ID: <41CD51E6.1070105@kolivas.org>
Date: Sat, 25 Dec 2004 22:41:26 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc>
In-Reply-To: <m3mzw262cu.fsf@rajsekar.pc>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig58AF86F0D44503A45D067B90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58AF86F0D44503A45D067B90
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rajsekar wrote:
> I would like to try out the SCHED_BATCH.  Unfortunately, I am not able to
> find a patch for my kernel.  Could someone enlighten me on this?
> 
> I am running 2.6.10-rc1-mm2 with staircase scheduler patch.  My `uname -a'
> output is:
> 
> Linux rajsekar.pc 2.6.10-rc1-mm2staircase #2 Sat Dec 4 10:49:31 IST 2004 i686 AuthenticAMD unknown GNU/Linux
> 

Only the staircase scheduler currently has an implementation of 
sched_batch and you need 2 more patches on top of the staircase patch 
for it to work. The most current version for 2.6.10 you can get with 
this patch sequence from the latest -ck patchset (or you could just use 
the full -ck patch)

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck1/patches/

2.6.10_to_staircase9.2.diff
schedrange.diff
schedbatch2.6.diff

Cheers,
Con

--------------enig58AF86F0D44503A45D067B90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBzVHmZUg7+tp6mRURAo4WAJwMgOqBxwhImxANBkauK1p5zDDHnQCeNZ4f
36dZC6Vt9jakK170klcdO5U=
=IFO0
-----END PGP SIGNATURE-----

--------------enig58AF86F0D44503A45D067B90--
