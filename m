Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBZWtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBZWtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 17:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVBZWtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 17:49:45 -0500
Received: from ylpvm53-ext.prodigy.net ([207.115.57.84]:26533 "EHLO
	ylpvm53.prodigy.net") by vger.kernel.org with ESMTP id S261288AbVBZWtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 17:49:42 -0500
Message-ID: <4220FC1D.6010404@ecs.fullerton.edu>
Date: Sat, 26 Feb 2005 14:45:49 -0800
From: Eric Gaumer <gaumerel@ecs.fullerton.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orinoco rfmon
References: <4220BB87.2010806@ecs.fullerton.edu> <200502262259.30897.adobriyan@mail.ru>
In-Reply-To: <200502262259.30897.adobriyan@mail.ru>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57E91A97BCA8BD4A81DCF97E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57E91A97BCA8BD4A81DCF97E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Alexey Dobriyan wrote:
> On Saturday 26 February 2005 20:10, Eric Gaumer wrote:
>
>
>>If the code looks problematic could someone point out possible
>>deficiencies so we can work toward a satisfactory resolution? I didn't
>>write the code but I'm willing do what I have to in order to get this
>>(wireless scanning) into the official tree.
>
>
> Uhhh... Started to comment line-by-line but then realized it would take too
> much time.
>
> * Read Documentaion/CodingStyle.
> * Indent code with tabs where it is already indented with tabs.
> * Brackets around a single number in #define's are useless.
> * Use u8, u16, u32 (not uint*_t) where the code already uses them.
> * Comments are supposed to be anonymous.
> * Use appropriate KERN_* constant in printk()'s.
> * Don't pack simple types (uint32_t, ...)
> * Common convention is to return 0 on success, negative number on error.
>   Positive return values don't fit well into this scheme. If possible
>   follow it.
>
> Oh, and the type p80211item_uint32_t when in fact it is a 12-bytes long
> structure ...
>
> 	Alexey

What is the difference between u* and uint*_t ? Both are derived from the same basic data type.

typedef unsigned char __u8;
typedef         __u8            uint8_t;

And...

typedef unsigned char u8;

--
"Education is what remains after one has forgotten everything he learned in school."
	- Albert Einstein

--------------enig57E91A97BCA8BD4A81DCF97E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCIPweZWL8hfFdQekRAjs5AKCqKAZTpoJ0zv1vYwJt8KE3Ix4sEwCgu7HI
Y/g3AZwCBEjYX5RzejvPnEA=
=67nn
-----END PGP SIGNATURE-----

--------------enig57E91A97BCA8BD4A81DCF97E--
