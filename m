Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbUKXIUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUKXIUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 03:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUKXIOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 03:14:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:32921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262486AbUKXIKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 03:10:49 -0500
X-Authenticated: #4512188
Message-ID: <41A44071.9040101@gmx.de>
Date: Wed, 24 Nov 2004 09:04:01 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org> <20041122155106.GG2714@holomorphy.com> <41A30D3E.9090506@gmx.de> <20041124082736.E6205230@wobbly.melbourne.sgi.com>
In-Reply-To: <20041124082736.E6205230@wobbly.melbourne.sgi.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7FC9CFB6AB2257070C9636CC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FC9CFB6AB2257070C9636CC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Scott schrieb:
> On Tue, Nov 23, 2004 at 11:13:18AM +0100, Prakash K. Cheemplavam wrote:
>>using ck's preemp big kernel lock?) I got following using a raid0 setup 
>>with xfs. I thought it would be a driver issue, but reformatting to ext3 
>>the stripe array runs now w/o probs for a few days. (xfs crapped out 
>>after a few hours on heavy disk activity.)
>>...
>>Nov 21 10:10:45 tachyon end_request: I/O error, dev sdb, sector 10480855
>>Nov 21 10:10:45 tachyon I/O error in filesystem ("md0") meta-data dev 
>>md0 block 0x13fd990       ("xfs_trans_read_buf") error 5 buf count 8192
> 
> 
> This looks like your driver passed an error back up to the
> filesystem while it was doing metadata IO and XFS chose to
> shut it down to prevent further damage.  It's unlikely to
> be a preempt/xfs problem.  Possibly hardware.  Did you see
> any of those device errors since switching to ext3?

No. That's why I am wondering. I read about such errors like I got 
before in lkml and usually they were not fs related but libata siimage 
driver related. It could be just a coincidence that it came up with xfs, 
but till now (I guess 5 days now, though not 24/7 running) ext3 is 
behaving nicely.

bye,

Prakash

--------------enig7FC9CFB6AB2257070C9636CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpEB2xU2n/+9+t5gRAi1gAKCZLobZpb3aMGDJYpUOfHMNvqm6uACgtOIq
+Zu7qGCu65ya/DFiwMFrdbo=
=kpOx
-----END PGP SIGNATURE-----

--------------enig7FC9CFB6AB2257070C9636CC--
