Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUBTIzl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUBTIzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:55:41 -0500
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:36108 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S267744AbUBTIz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:55:29 -0500
In-Reply-To: <403596D8.8020509@pobox.com>
References: <1077242738.12567.76.camel@morsel.kungfoocoder.org> <403596D8.8020509@pobox.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-34-175863389"
Message-Id: <7D98D0B5-6382-11D8-B07A-000A95CD704C@kungfoocoder.org>
Content-Transfer-Encoding: 7bit
Cc: atulm@lsil.com, akpm@osdl.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       James.Bottomley@HansenPartnership.com, torvalds@osdl.org,
       Linux SCSI mailing list <linux-scsi@vger.kernel.org>
From: Paul Wagland <paul@kungfoocoder.org>
Subject: Re: [PATCH][BUGFIX] : Megaraid patch for 2.6 1/5
Date: Fri, 20 Feb 2004 09:55:11 +0100
To: Jeff Garzik <jgarzik@pobox.com>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-34-175863389
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Feb 20, 2004, at 6:10, Jeff Garzik wrote:

> Patches 1-5 look OK to me.
>
> If you are attempting to follow LSI's megaraid (in 2.4 only, sigh), 
> patch #4 may wind up causing you grief in the future.  Hopefully Atul 
> will pick it up, though :)

Thanks for looking them over! Patch 4 should not actually cause a 
problem, since this is actually one of the bigger changes introduced in 
the 2.00.9 patch. I think it was 2.00.9 anyway, just guessing from the 
changelogs, in any case it is definitely one of the "more widespread" 
changes between 2.00.3 and 2.10.1, which is the current 2.4 driver. The 
bigger problem is probably going to be patch 5, and the follow ons from 
it, since that factors out more common code between the /proc and /sys 
filesystems, which also results in smaller "common chunks" between the 
two drivers.

My plan at the moment is to pull forward all of the changes from the 
2.10.1 driver, and then to go back and add more sysfs support on top of 
what is there now.

Cheers,
Paul

--Apple-Mail-34-175863389
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFANct2tch0EvEFvxURAjHyAKC/fEzMWFajDwLBIVCU2VpdAXt2OgCfY03N
W8lmgZvV+UN45x7Z5rQqMiw=
=movj
-----END PGP SIGNATURE-----

--Apple-Mail-34-175863389--

