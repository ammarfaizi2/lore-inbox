Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUGZVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUGZVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbUGZVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:36:29 -0400
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:9684 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265932AbUGZVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:36:11 -0400
Message-ID: <41057940.6090104@kolivas.org>
Date: Tue, 27 Jul 2004 07:36:00 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au
Subject: Hackbench broken by 2.6.8-rc1+
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF6D0D6D319A384EE345842A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF6D0D6D319A384EE345842A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

After a brief discussion with Rusty about hackbench he explained that it 
was more a pass/fail benchmark than anything else - failing by running 
forever. Well recently I noticed all kernels were doing it so did some 
regression testing to see when it started. 2.6.7 runs fine, but 
2.6.8-rc1 onwards get hard rebooted after 12 hours.

I've been using the 8x boxen at osdl with
TEST: hackbench on stp8-001 running PLM ID 3049 [ linux-2.6.7 ]
LILO: append = 'profile=2'
Script Params: 25 200

I'll investigate further to see if I can track down the patch that 
started this but it may take some time. Suffice to say that the 
2.6.8-rc* versions may not be safe in certain server settings until that 
time.

Cheers,
Con

--------------enigBF6D0D6D319A384EE345842A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBBXlAZUg7+tp6mRURAsP1AJ4vxM96oN5rZbakA5qxLKfwUO3VFwCfWjJb
kQ4q4kQGGOo6usMhICgGkqQ=
=OaXA
-----END PGP SIGNATURE-----

--------------enigBF6D0D6D319A384EE345842A--
