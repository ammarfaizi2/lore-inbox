Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261551AbSJMPh3>; Sun, 13 Oct 2002 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSJMPh2>; Sun, 13 Oct 2002 11:37:28 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:6882 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261551AbSJMPh2>; Sun, 13 Oct 2002 11:37:28 -0400
Date: Sun, 13 Oct 2002 17:43:16 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Sleeping in illegal context
Message-Id: <20021013174316.732c4298.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.hlI?Wzlo4gFjdF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.hlI?Wzlo4gFjdF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hello,

This turned up in 2.5.42-ac1.

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c02ad282>] usb_hub_events+0x72/0x3b0
 [<c01155b3>] schedule+0x183/0x300
 [<c011a864>] reparent_to_init+0xe4/0x180
 [<c02ad5f5>] usb_hub_thread+0x35/0xf0
 [<c0115790>] default_wake_function+0x0/0x40
 [<c02ad5c0>] usb_hub_thread+0x0/0xf0
 [<c0105601>] kernel_thread_helper+0x5/0x14

Regards,
-Udo.

--=.hlI?Wzlo4gFjdF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9qZSWnhRzXSM7nSkRAmL7AJ4+EGN5lDF31NMPRWtAjxTJ0a1RWgCfcI+x
GeRP81gyy8Frdcdu5/wye0A=
=GuIf
-----END PGP SIGNATURE-----

--=.hlI?Wzlo4gFjdF--
