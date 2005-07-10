Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVGJIEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVGJIEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 04:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVGJIED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 04:04:03 -0400
Received: from smtp1.oregonstate.edu ([128.193.0.11]:17364 "EHLO
	smtp1.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261869AbVGJIEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 04:04:02 -0400
Message-ID: <42D0D669.1010706@engr.orst.edu>
Date: Sun, 10 Jul 2005 01:03:53 -0700
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net> <42CB63AD.4070208@engr.orst.edu> <200507100136.49735.dtor_core@ameritech.net>
In-Reply-To: <200507100136.49735.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6727E6B001A21800986B7762"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6727E6B001A21800986B7762
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitry Torokhov wrote:
> On Tuesday 05 July 2005 23:53, Micheal Marineau wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>>On Monday 04 July 2005 16:14, Mike Waychison wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>I just upgrade my Tecra M2 this weekend to the latest GIT tree and
>>>>noticed that my mouse pointer/touchpad is now broken on resume.
>>>>
>>>>Investigating, it appears that mouse device gets confused due to the
>>>>introduced psmouse_reset(psmouse) during reconnect:
>>>>
>>>>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940
>>>
>>>
>>>Hi,
>>>
>>>Please try the following patch:
>>>
>>>	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
>>> 
>>
>>This fixed the problem for mylaptop, but ONLY if I had #define DEBUG in
>>alps.c, switch it back to the usual #undef and the exact same problem
>>happens.  I've got no idea what's going on, I'll poke at it more when
>>I'm awake....
>>
> 
> 
> Hi,
> 
> Sorry, any update on this topic? Does it still only work with DEBUG?
> 
> Thanks!
> 

Yey! fixed it, simple little patch, just updates the alps_model_info
struct. Here's a link so my mail client won't mess up the white space:
http://dev.gentoo.org/~marineam/files/alps-dell8500-dualpoint.patch

(note, this sill requires the alps-suspend-typo fix)

-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig6727E6B001A21800986B7762
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC0NZviP+LossGzjARAr04AKDCiwpPlUtajfn1NauE6mSE4uLPKgCguzeE
atNzOjHs9y3UHDi6M0dsiuU=
=q5OE
-----END PGP SIGNATURE-----

--------------enig6727E6B001A21800986B7762--
