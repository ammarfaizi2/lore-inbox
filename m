Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUBQJP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 04:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUBQJP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 04:15:57 -0500
Received: from terra.irts.fr ([194.206.161.9]:30138 "EHLO ns1.terranet.fr")
	by vger.kernel.org with ESMTP id S264305AbUBQJPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 04:15:55 -0500
Message-ID: <4031DB3E.8000406@laposte.net>
Date: Tue, 17 Feb 2004 10:13:34 +0100
From: MALET JL <malet.jean-luc@laposte.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; fr-FR; rv:1.5) Gecko/20031007
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [drivers][sata-promise] TX4 has the cache enabled, it should be disabled
X-Priority: 2 (high)
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig948BA060515D4E2BB6216DD3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig948BA060515D4E2BB6216DD3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hello,
I've a TX4 150 card and encounter the following effects :
->"shorts" files (<1Mo) are copied at 35Mo/s av
->"long" files (>1Mo) are "burst" copied (ie a big "burst" then hangs, 
burst, hangs) this has the following effects :
1) average fall back to 12Mo/s
2) systems "hangs" (mouse, keyboard behave like a 100% used cpu) but cpu 
usage is still slow
3) mplayer reset the streams every second (cpu usage still low)

this is 1-2 week that I have this issue, but can't find where it comes 
from...... yesterday by chance when I loaded sata-promise I noticed 
"write through" this remembered be some issue I go when I first had the 
sata board, making a short research made me remember :

DISABLE THE BOARD CACHE! on windows this is the same when cache is 
enabled : performance drops, system interactive is awfull....

this should be made an option in module

regards

--------------enig948BA060515D4E2BB6216DD3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAMdtHcl3j/qUaL14RAhoDAJ0WvVTVBWiHgjuJD7JzwRDSjqpO4QCfbQRQ
wyXEZz8Gk8fbgsIMGj6uM14=
=/Urw
-----END PGP SIGNATURE-----

--------------enig948BA060515D4E2BB6216DD3--

