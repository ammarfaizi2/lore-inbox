Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTDFRws (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 13:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbTDFRws (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 13:52:48 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:1733 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S263040AbTDFRwq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 13:52:46 -0400
Date: Sun, 6 Apr 2003 20:04:11 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: poweroff problem
Message-Id: <20030406200411.2c33a06f.us15@os.inf.tu-dresden.de>
In-Reply-To: <1049642082.1218.3.camel@dhcp22.swansea.linux.org.uk>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	<20030406233319.042878d3.sfr@canb.auug.org.au>
	<20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	<20030407002703.16993dc4.sfr@canb.auug.org.au>
	<20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
	<1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
	<20030406183713.3435d742.us15@os.inf.tu-dresden.de>
	<1049642082.1218.3.camel@dhcp22.swansea.linux.org.uk>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws3 (GTK+ 1.2.10; Linux 2.4.21-pre7)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.1LB6C8cVHFw8kY"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.1LB6C8cVHFw8kY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 06 Apr 2003 16:14:42 +0100 Alan Cox (AC) wrote:

AC> Different options for reboot (16 v 32) perhaps, might even be something is
AC> random as which way the carry flag is when the bios code is called. If you
AC> want to be sure for the APM case stick a printk just before we drop into
AC> the BIOS and make sure we oops after and not before..

I just tried with APM; machine powers down without problems. It's ACPI which
doesn't power down. Last thing it prints during powerdown is:

hwsleep-0178 [-24] Acpi_enter_sleep_state: Entering S5

I can't find any specific A7V workarounds in 2.5.66 ACPI code, so I guess
the ACPI code in 2.4 isn't up-to-date.

The original poster's problem is then probably indeed related to a buggy BIOS
if it doesn't even powerdown with APM.

-Udo.

--=.1LB6C8cVHFw8kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+kGwdnhRzXSM7nSkRAqz5AJ4+XL9ysRJ1SxRhWFoFLhAgUh+htgCbBBwb
Zro7pwLJs+zjb5/ljaT0YIY=
=5g+K
-----END PGP SIGNATURE-----

--=.1LB6C8cVHFw8kY--
