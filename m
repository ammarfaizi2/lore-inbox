Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbULGKzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbULGKzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 05:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbULGKzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 05:55:13 -0500
Received: from smtpout4.uol.com.br ([200.221.4.195]:62105 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261778AbULGKzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 05:55:04 -0500
Date: Tue, 7 Dec 2004 08:55:00 -0200
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: "Luis A. Montes" <luismontes@isp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gameport and USB joysticks/gamepads
Message-ID: <20041207105459.GE21902@cathedrallabs.org>
References: <1102406337.5938.9.camel@penguin.montes2.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <1102406337.5938.9.camel@penguin.montes2.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> How is the gameport_register_port() supposed to be called for USB
> devices? There doesn't seem to be any kernel hook for that. Is it
> supposed to happen in userspace?
you should use gameport_register_port() only to hardware game ports (e.g.
those found on soundcards).
USB joysticks don't need a gameport, so USB joystick drivers should call
directly input_register_device().

> Also, it seems to me that gameport_register_device is always going to
> add a null pointer (dev->node) to the gameport_dev_list, and that
> doesn't seem terribly useful. What's the purpose of that?
'node' is a kernel style linked list (struct list_head). I don't know
any URL which explains how it works but you may find it in Robert Love's
Linux Kernel Development book.

--
Aristeu


--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBtYwDRRJOudsVYbMRAuwIAJ4nrwD/Y+54gOymYpNeMipiYBetVQCdEUo4
Y115Q5FzeevGaz0/JkPIjbs=
=owhK
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
