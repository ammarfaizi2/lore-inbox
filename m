Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVCGGNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVCGGNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVCGGNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:13:36 -0500
Received: from smtp2.oregonstate.edu ([128.193.4.8]:32911 "EHLO
	smtp2.oregonstate.edu") by vger.kernel.org with ESMTP
	id S261640AbVCGGMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:12:05 -0500
Message-ID: <422BF0B0.3030109@engr.orst.edu>
Date: Sun, 06 Mar 2005 22:12:00 -0800
From: Micheal Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] Treat ALPS mouse buttons as mouse buttons
References: <422BA727.1030506@engr.orst.edu> <20050307055019.GA1541@ucw.cz>
In-Reply-To: <20050307055019.GA1541@ucw.cz>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27C43C6646BF0209B706E412"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27C43C6646BF0209B706E412
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> On Sun, Mar 06, 2005 at 04:58:15PM -0800, Micheal Marineau wrote:
> 
> 
>>The following patch changes the ALPS touchpad driver to treat some mouse
>>buttons as mouse buttons rather than what appears to be joystick buttons.
>>This is needed for the Dell Inspiron 8500's DualPoint stick buttons. Without
>>this patch only the touchpad buttons behave properly.
> 
> 
> Thanks for the patch. I'll try to put this change into my the latest
> version of the ALPS driver, which, unfortunately, has been reworked
> significantly.
> 
> Can you send me the output of /proc/bus/input/devices on your machine?
> I'd like to know the ID of your ALPS dualpoint.
> 

I just looked at the new version in 2.6.11-mm1 and it appears that my
change as already been covered in different ways and I'm not having any
problem with the buttons on mm1.  Just in case you still want to know,
the following is the ouptput if /proc/bus/input/devices.

I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="AlpsPS/2 ALPS TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=f
B: KEY=420 0 670000 0 0 0 0 0 0 0 0
B: REL=3
B: ABS=1000003


-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------enig27C43C6646BF0209B706E412
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCK/C0iP+LossGzjARAk/yAJ0SaLnnKYgy6pSEnCaIrLyHAueN9wCdEkYS
hTM+87/qZrxOkjuhtCMLfxU=
=T9NO
-----END PGP SIGNATURE-----

--------------enig27C43C6646BF0209B706E412--
