Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVI3HJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVI3HJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVI3HJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:09:17 -0400
Received: from carbon.nocdirect.com ([69.73.156.63]:7610 "EHLO
	carbon.nocdirect.com") by vger.kernel.org with ESMTP
	id S932565AbVI3HJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:09:16 -0400
Message-ID: <433CE491.90305@ipom.com>
Date: Fri, 30 Sep 2005 00:09:05 -0700
From: Phil Dibowitz <phil@ipom.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-usb-storage@lists.one-eyed-alien.net
Subject: Re: [linux-usb-devel] RFC drivers/usb/storage/libusual
References: <20050927205559.078ba9ed.zaitcev@redhat.com>
In-Reply-To: <20050927205559.078ba9ed.zaitcev@redhat.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig273E7C2CBA6B3FFA193E8E86"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - carbon.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - ipom.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig273E7C2CBA6B3FFA193E8E86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
> Patch is attached. I would like someone to look it over and challenge it.
> The thing looks too complex to me, but I see no other way. Anyone?

OK, so I'm not very familiar with a lot of the code affected here, but
since it diddles with unusual_devs, I feel I should chime in. But I'll
chime in with a question. ;)

A quick look over the patch shows that there are now two kinds of
unusual_dev entries: unusual_dev() and unusual_dev_fl(), where the
latter is for entries that don't need to specify SC or PR (i.e., just
had US_SC_DEVICE, US_PR_DEVICE in them). While I think that's a
reasonable change, it's not clear to me why that's useful to the rest of
the patch, or it's just making unusual_devs.h artificially shorter?

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759


--------------enig273E7C2CBA6B3FFA193E8E86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDPOSSN5XoxaHnMrsRAtJXAJ47RlB0tGmtDE52C1xKAZlsvyK6BwCfbsn5
ZjfngZD3pIEAwU/hnxMg9IQ=
=nC3d
-----END PGP SIGNATURE-----

--------------enig273E7C2CBA6B3FFA193E8E86--
