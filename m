Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJQBnv>; Tue, 16 Oct 2001 21:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJQBnm>; Tue, 16 Oct 2001 21:43:42 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:27655 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S273648AbRJQBni>;
	Tue, 16 Oct 2001 21:43:38 -0400
Date: Wed, 17 Oct 2001 03:44:10 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011017034410.A3722@gondor.com>
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com> <20011016183243.B18541@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
In-Reply-To: <20011016183243.B18541@one-eyed-alien.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, Oct 16, 2001 at 06:32:43PM -0700, Matthew Dharm wrote:
> No, I think something different is best.
> 
> Your first change to push the US_FL_FIX_INQUIRY code down after the test
> for pusb_dev is good.. but, in the case where that pointer is bad, we need
> to cook up something totally fake, like INQUIRY data that says
> "DISCONNECTED" "USB-STORAGE DEVICE" or somesuch.....

Then I don't understand why we have to answer the INQUIRY at all. 
This could as well be a disconnected / turned off external scsi 
device. I often turn off my external scsi scanner while the system
is running, without a problem up to now. The scanner surely doesn't
answer to INQUIRYs when it's turned off...

By the way - a device not needing the US_FL_FIX_INQUIRY code wouldn't
answer to INQUIRYs either, when it's disconnected. So the patch I sent
first gives the same behaviour for devices with and without 
US_FL_FIX_INQUIRY set.

Jan

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zOJqnIUccvEtoGURAsf2AKCeLHIRZQ0OZvDkfOYVeihO+Q1izwCfV2NH
kmYJCxqlFALOaUPjZcomjy4=
=T2Uu
-----END PGP SIGNATURE-----
