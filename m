Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270798AbTGVLgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270799AbTGVLgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:36:49 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:61327 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S270798AbTGVLgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:36:48 -0400
Date: Tue, 22 Jul 2003 13:51:47 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
Message-Id: <20030722135147.166742eb.us15@os.inf.tu-dresden.de>
In-Reply-To: <1058869462.2352.79.camel@mtross2.csintern.de>
References: <0001F3D0@gwia.compu-shack.com>
	<1058869462.2352.79.camel@mtross2.csintern.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.aYD4t4rpMwT7TD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.aYD4t4rpMwT7TD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22 Jul 2003 12:24:24 +0200 Michael Tro=DF (MT) wrote:

UAS> I can provide more information wrt. hardware, config etc.
UAS> on request.

MT> Would be really useful if you do so.

I have put the following information at: http://www.wh8.tu-dresden.de/fddi/

* My .config for 2.4.22-pre6
* dmesg output of 2.4.22-pre6 (both 2.4.21 and 2.4.22-pre6 behave the same)
* the ksymoops output of the lockup
* the output of lspci -v
* the fddi patch i used (applies cleanly to 2.4.21 and with fuzz to -pre6)

Note that the fddi patch includes a patch you've previously sent me, which
isn't present in the driver on your website.

If you need more information, let me know. Also if you have any tips or
patches that would help in debugging the issue, I'm happy to try them.

MT> What makes you believe this? There is no matching code sequence like the
MT> one from your dump in the driver, to be exact: in a driver compiled with
MT> gcc 3.3 and kernel 2.4.21.

The fact that the backtrace in the decoded oops looks like the lockup
happened in the fddi driver led me to the conclusion that this may be
the culprit. I have compiled the 2.4.22-pre6 kernel with gcc-3.3 also.

Regards,
-Udo.

--=.aYD4t4rpMwT7TD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/HSVWnhRzXSM7nSkRAuOvAJ96QwSnHNq0ryMkIHGoLFn5TXluKQCeP35I
rOCKZUoBbVRzbYJuVIqRNus=
=qBZk
-----END PGP SIGNATURE-----

--=.aYD4t4rpMwT7TD--
