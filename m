Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbULPRaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbULPRaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 12:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbULPRaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 12:30:10 -0500
Received: from pop.gmx.de ([213.165.64.20]:25249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261797AbULPRaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 12:30:01 -0500
X-Authenticated: #4512188
Message-ID: <41C1C616.9070007@gmx.de>
Date: Thu, 16 Dec 2004 18:29:58 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Data Corruption when both ports of SiI3112 used
References: <41AA2607.2090906@gmx.de>
In-Reply-To: <41AA2607.2090906@gmx.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF77824F531723CC7E4B7F0F"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF77824F531723CC7E4B7F0F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam schrieb:
> I get some tiny but nevertheless destastrous errors in following 
> situation. (And no, Jeff, my cables are alright. ;-)
> 
> SiI3112A chip on nforce2 board.
> Samsung 160 GB PATA drive on first connector via PATA->SATA convertor
> Samsung 80 GB SATA drive on second connector
> 
> I copy two ~200MB big tgz archive from sdb to sda. I remount partition 
> on sda and test files for integrity. Usually at least one of those 
> fails. (The more files I copy the more files differ in tiny places. 

I haven't tried on my box yet, but another guy did it and he could 
reproduce this, and also fix it: It seems to be nforce2 specific issue. 
In bios you have the option ext-p2p. though bios states that 30us will 
prevent data corruption on si3112, it is not true. It seems that is must 
be set to 1ms.

Is it possible to do this in linux kernel just for safety? I think this 
is rather crucial...

Prakash

--------------enigEF77824F531723CC7E4B7F0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBwcYZxU2n/+9+t5gRAnHnAKD24dYhKQaVDGl4z/5YFJ4c+RNcjgCg9Ys2
maxCRTVS0ItvGgZvAwkIYbs=
=7t9X
-----END PGP SIGNATURE-----

--------------enigEF77824F531723CC7E4B7F0F--
