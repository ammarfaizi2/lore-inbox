Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVDLC4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVDLC4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 22:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVDLC4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 22:56:04 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:1748 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S261949AbVDLCzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 22:55:47 -0400
Message-ID: <425B3864.8050401@tin.it>
Date: Mon, 11 Apr 2005 21:54:28 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>
In-Reply-To: <20050412015018.GA3828@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB6D6DFCB8798308568B4571"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB6D6DFCB8798308568B4571
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> You say API but talk about ABI.

As long as we want to guarantee abi, we must use the same names. Api 
names, not implementation should be the same. You can't substitute 
get_namei with get_my_own_namei_version_I_know...

> You said you've read stable_api_nonsense.txt .
> 
> stable_api_nonsense.txt talks about exactly these issues.

Yes.

> The right solution for this issue is simple:
> 
> Get the module into the kernel.
> 
> Not that e.g. your pwc module will be in kernel 2.6.12.

Of course not... I don't expect nobody doing that! :)

> Please check the facts:
> 
> QT 1 is _not_ binary compatible with QT 3.
> 
> There's a reason why the library changed the so-name...

Yes! That's my point. I didn't mean to say that the library has the same 
classes as the first version. Qt 3 is *not* compatible with Qt 1. Qt 
3.3.0 is binary compatible with qt 3.3.1, 3.3.2, and so on... unless 
someone makes an error.

My point is that versioning should be, in come cases, less restrictive, 
letting the 2.4 kernel being not compatible with 2.6, but all 2.6.x 
series being binary compatible with each other. If versioning means 
something, the last number should be a revision, additions, but since 
they belong to 2.6 version, they would be compatible.

Major kernel changes should probably result in major version change... 
I'm supposing it. Of course, note that ABI can be achieved stating that 
all the binaries must be compiled with the same gcc. So, the kernel 
module library could possibly be simply /lib/modules/2.6/.

I'm probably (surely) not getting the point about this issue. It's not 
that bad... I don't see awkward issues in guaranteeing 2.6, 2.8 and so 
on compatibility with the ``major second number''.

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enigDB6D6DFCB8798308568B4571
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCWzhk4LBKhYmYotsRAmxCAJkBpio3LHUyOhP32TZ2RpSRsApBKwCdEdT6
GcH83d4x38lbUwXIZHmXBWg=
=LxaJ
-----END PGP SIGNATURE-----

--------------enigDB6D6DFCB8798308568B4571--
