Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbUKJLWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUKJLWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUKJLWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 06:22:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:9907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261689AbUKJLWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 06:22:18 -0500
X-Authenticated: #4512188
Message-ID: <4191F9E6.9010709@gmx.de>
Date: Wed, 10 Nov 2004 12:22:14 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Pedro Larroy <piotr@larroy.com>, linux-kernel@vger.kernel.org
Subject: Re: Ideas for a new io scheduler for desktop
References: <20041110013235.GA13691@larroy.com> <1100051419.18601.105.camel@localhost>
In-Reply-To: <1100051419.18601.105.camel@localhost>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D6795D82979122B3501291E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D6795D82979122B3501291E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Robert Love wrote:
> On Wed, 2004-11-10 at 02:32 +0100, Pedro Larroy wrote:
> 
> 
>>I think that a new io-scheduler that gave priority to bursty access to
>>block devices would be interesting for desktop and workstation use, and
>>even for some servers.
>>
>>I'm often waiting for graphical aplications, vim, mutt, and almost every
>>program to which I have to interact with because they are blocked
>>waiting for just a few blocks of IO that won't get served fast just
>>because there's a single process hog that's provoking that high latency.

[snip]

> 
> What you are seeing is the affect of read requests being synchronous,
> and thus the pain of read latency, and write requests to one part of the
> disk starving other requests.
> 
> Have you tried the new 2.6 I/O schedulers?  They should prevent this
> problem.
> 
> If you are using 2.6, then your problem might not lie with the I/O
> scheduler.  Read request deadlines are very low in both the deadline and
> anticipatory I/O scheduler.

BTW, I saw the same problem, though not with reading, but with writing 
to disk. See thread (well nobody answered to it yet):

[2.6.10-rc1 and prev] System unuseable while writing to disk

It really takes away the fun... :(

Prakash

--------------enig4D6795D82979122B3501291E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBkfnmxU2n/+9+t5gRAn6KAKDiRwLnr2+AXJ+xnHdkIhDUUTFe1QCfcPnI
dBlxInIDQ2C4k6SENH01i8I=
=y89+
-----END PGP SIGNATURE-----

--------------enig4D6795D82979122B3501291E--
