Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWAROOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWAROOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWAROOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:14:10 -0500
Received: from sipsolutions.net ([66.160.135.76]:3344 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1030319AbWAROOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:14:09 -0500
Subject: Re: [PATCH] hci_usb: implement suspend/resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, marcel@holtmann.org,
       maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <200601181425.35524.oliver@neukum.org>
References: <1137540084.4543.15.camel@localhost>
	 <200601181425.35524.oliver@neukum.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PxgNp3UbMxAM6l1wen3V"
Date: Wed, 18 Jan 2006 15:13:41 +0100
Message-Id: <1137593621.4543.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PxgNp3UbMxAM6l1wen3V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-01-18 at 14:25 +0100, Oliver Neukum wrote:

> This patch is wrong. usb_kill_urb() will sleep. You must not use it under
> a spinlock.

Whoops. Good catch. I'll have to analyse the logic with the lists being
used here (and probably add a temporary list). Will try to get a new
patch until tomorrow.

[side note: how about adding might_sleep() to usb_kill_urb? Then I'd at
least have noticed this right away]

johannes

--=-PxgNp3UbMxAM6l1wen3V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ85NE6Vg1VMiehFYAQKkGQ/+KcIjGoGVatDOrdMa8eFwnxmu398l49I4
7fNdWCnUCkYhdRvaiF8hH5zywE0NN74FEMZCAhqcKmuVg1JZ3T/YT+gk/Se0Wcgu
xCaRPp5Hjju0ol+4T3bXY/aLi+7NjECXX0VfZ4HA7iTGy7rHrdljKN/KOuDzu0J6
BrRUuIoqV9sdr45AmlhY79YXcvnNaBKU41HdeOCvX/YcRNDlVrbuJH7cOPgKdVsb
z7/C8OlMIhzj1YujBXGbAk2UJgFu5g1l+pZ9VqT3vx9gSRwc0QeRfddhCHm5UA/S
amDveZlLT3zyNU5Cc2tI+GOakAhG5bkzzNmLbMSitibdxpkBbRO0dsP+PwgxEiwP
zgZJvv0ecnSfY8pfFPR7tlQoF1+ZjfyXt2rRzo30MXrK0Hm8/aOkYhVV5dsJ0ouN
UWLSfk3QbXU9Th4wjaGwGjkTI7/O/EtPRt6wVFRRdc41/nrBXsaN12kXtYngMKCa
muZmQwlcv4YiXX4gQECItSp3ZpiksGueeMgCOX5eKpxektYgHfHLl1e3l/Zl2fcn
MfIiIdu29B697jlY5iiwZZLN9lAz1IPYG9mOZkPRJJF/qIrbgK1N+cpndUys1Q+E
VK4pETzuCb9K75x3Zy9aNsibQUTg8z4ftjKAjl1mkPxVLmMekh68y/3XNk5XAoLn
xbt2tNP+iRM=
=pQCo
-----END PGP SIGNATURE-----

--=-PxgNp3UbMxAM6l1wen3V--

