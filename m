Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbUAKNL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUAKNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:11:25 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:137 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265881AbUAKNLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:11:12 -0500
Subject: Re: 2.6.1 and irq balancing
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <40008745.4070109@stinkfoot.org>
References: <40008745.4070109@stinkfoot.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-orI2VP5WPixPbT2z/CMw"
Message-Id: <1073826848.9096.116.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 15:14:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-orI2VP5WPixPbT2z/CMw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 01:14, Ethan Weinstein wrote:
> Greetings all,
>=20
> I upgraded my server to 2.6.1, and I'm finding I'm saddled with only=20
> interrupting on CPU0 again. 2.6.0 does this as well. This is the=20
> Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled.=20
> /proc/cpuinfo is normal as per HT, displaying 4 cpus.
> 2.4.2(3|4) exhibited this behaviour as well, until I applied patches=20
> from here:=20
> http://www.hardrock.org/kernel/2.4.23/irqbalance-2.4.23-jb.patch, et al.
>=20
>=20
>             CPU0       CPU1       CPU2       CPU3
>    0:    1572323          0          0          0    IO-APIC-edge  timer
>    2:          0          0          0          0          XT-PIC  cascad=
e
>    3:      23520          0          0          0    IO-APIC-edge  serial
>    8:          2          0          0          0    IO-APIC-edge  rtc
>    9:          0          0          0          0   IO-APIC-level  acpi
>   14:         10          0          0          0    IO-APIC-edge  ide0
>   16:         30          0          0          0   IO-APIC-level  sym53c=
8xx
>   22:       4162          0          0          0   IO-APIC-level  eth0
>   48:       7798          0          0          0   IO-APIC-level  aic79x=
x
>   49:       3385          0          0          0   IO-APIC-level  aic79x=
x
>   54:      17062          0          0          0   IO-APIC-level  eth1
> NMI:          0          0          0          0
> LOC:    1572002    1572251    1572250    1572243
> ERR:          0
> MIS:          0
>=20
>=20
> THey keyboard isn't working either, but we see the i8042..
>=20
> serio: i8042 KBD port at 0x60,0x64 irq 1
>=20

Are you running irqbalance ?


--=20
Martin Schlemmer

--=-orI2VP5WPixPbT2z/CMw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAUwgqburzKaJYLYRAu+xAJsFpUwFQd8Sg4yoPo7MzDeco6WIrQCffp5o
DzUzusIEC6ThyAyntjdSXhg=
=m1nz
-----END PGP SIGNATURE-----

--=-orI2VP5WPixPbT2z/CMw--

