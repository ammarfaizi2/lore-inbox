Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVBBMxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVBBMxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVBBMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:53:34 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:55740 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262623AbVBBMws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:52:48 -0500
Message-ID: <4200CD15.6080001@kolivas.org>
Date: Wed, 02 Feb 2005 23:52:37 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Hughes <ee21rh@surrey.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
References: <200502011257.40059.brade@informatik.uni-muenchen.de>  <pan.2005.02.01.20.21.46.334334@surrey.ac.uk> <1107299901.5624.28.camel@gaston> <loom.20050202T134427-571@post.gmane.org>
In-Reply-To: <loom.20050202T134427-571@post.gmane.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61119868DCE13E62F2B507E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61119868DCE13E62F2B507E3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Hughes wrote:
> Benjamin Herrenschmidt <benh <at> kernel.crashing.org> writes:
> 
>>This looks like bogus HW, or bogus list of IDE interfaces ...
> 
> 
> How can I test to see if this is the case?
> 
> 
>>The IDE layer waits up to 30 seconds for a device to drop it's busy bit,
>>which is necessary for some drives that aren't fully initialized yet.
> 
> 
> Sure, make sense.
> 
> 
>>I suspect in your case, it's reading "ff", which indicates either that
>>there is no hardware where the kernel tries to probe, or that there is
>>bogus IDE interfaces which don't properly have the D7 line pulled low so
>>that BUSY appears not set in absence of a drive.
> 
> 
> Right. How do I find the value of D7?
> 
> 
>>I'm not sure how the list of intefaces is probed on this machine, that's
>>probably where the problem is.

I've read that people have had this problem go away if they disable this 
option:

< >     generic/default IDE chipset support

If you have chipset support for your IDE controller this isn't needed, 
and I'd recommend disabling it. The "why" it made the problem go away is 
something I can't answer.

Cheers,
Con

--------------enig61119868DCE13E62F2B507E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCAM0VZUg7+tp6mRURAjaKAJ9dzbvsaPf8+UssstBiIgF8He+QOgCeODrC
LJAP0VjRIblvufzpdok1hwI=
=DN3g
-----END PGP SIGNATURE-----

--------------enig61119868DCE13E62F2B507E3--
