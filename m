Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbULFCfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbULFCfN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 21:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbULFCfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 21:35:12 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:15234 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261456AbULFCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 21:35:03 -0500
Message-ID: <41B3C54B.1080803@kolivas.org>
Date: Mon, 06 Dec 2004 13:34:51 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net>
In-Reply-To: <20041206022338.GA5472@optonline.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD593DA0CF5DF96DE9FABBCF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD593DA0CF5DF96DE9FABBCF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Sipek wrote:
> On Mon, Dec 06, 2004 at 12:59:43PM +1100, Con Kolivas wrote:
>>First the ioprio should be set to 
>>what the cpu 'nice' level is as a sort of global "this is the priority 
>>of this task" setting. Then it should also support changing of this 
>>priority with a different call separate from the cpu nice. That way we 
>>can take into account access privileges of the caller making it 
>>impossible to set a high ioprio if the task itself is heavily niced by a 
>>superuser and so on.
> 
> 
> This sounds very reasonable. How would a situation like this one get
> handeled:
> 
> nice = x
> io_prio = y
> 
> where x!=y
> 
> then, user changes nice. Does the nice level change alone? If so,
> providing some "reset to nice==io_prio" capability would make sense, no?

I think when nice is changed, ioprio needs to be changed with it as a 
sane default action. I suspect that most of the time people will not use 
the separate ioprio call, but using 'nice' is a regular linuxy thing to 
do. Ideally we make ioprio part of the 'nice' utility and we specify 
both at the same time. Something like:
nice -n 5 -i 20 blah

Cheers,
Con

--------------enigFD593DA0CF5DF96DE9FABBCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs8VLZUg7+tp6mRURAkqcAJ445QNkTOWLicgaFigELvhBY/Np5QCghvga
eAS7YoKSMyXWdJ+qL04VwfQ=
=pEhC
-----END PGP SIGNATURE-----

--------------enigFD593DA0CF5DF96DE9FABBCF--
