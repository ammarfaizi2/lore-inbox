Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTDJIf1 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 04:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTDJIf1 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 04:35:27 -0400
Received: from [151.38.226.92] ([151.38.226.92]:47890 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264005AbTDJIf0 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 04:35:26 -0400
Date: Thu, 10 Apr 2003 10:46:50 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New radeonfb fork
Message-ID: <20030410084650.GA728@renditai.milesteg.arr>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1049642954.550.41.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1049642954.550.41.camel@zion.wanadoo.fr>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21-pre7
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I tried your patch for Radeon framebuffer on kernel 2.4.21-pre7, it
works better than before, but still I have some problems:

the cursor is visible only at 8 bit depth, with 16 or 32 bit it just
disappears, and at 8 bit it is a big full scale rectangular cursor
(no underline).

I couldn't find a way to set the resolution at boot time (I use the
driver compiled in), I tried the following, all being ignored:
radeonfb:1024x768-8@60
radeon:1024x768-8@60

I am using an ugly fbset in a random boot script, but it just changes the
resolution for the first console. This is probably the biggest problem I
saw until now...

Finally dmesg says:

PCI: Found IRQ 11 for device 01:00.0
radeonfb: ref_clk=3D2700, ref_div=3D12, xclk=3D20000 from BIOS
Console: switching to colour frame buffer device 80x30
radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
                   ^^^
But I have an LCD on the CRT port, I saw some LCD support in radeonfb.c,
but perhaps it was only on DVI port.

I have a:
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Rad=
eon 9000] (rev 01)

with 64Mb DDR on a PIII 500Mhz, Asus P3C2000 (i820 chipset) motherboard.

Thanks for your work.

--=20
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+lS962rmHZCWzV+0RAgNFAJ9M1aVWHF7bmwAMWGd/7Yf/cfi+jACdFKZF
1zPL0rQoW2xciP+AsK0yKUQ=
=UG2c
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
