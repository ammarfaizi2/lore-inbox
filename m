Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268413AbTBWOCx>; Sun, 23 Feb 2003 09:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268464AbTBWOCx>; Sun, 23 Feb 2003 09:02:53 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11247 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S268413AbTBWOCw>; Sun, 23 Feb 2003 09:02:52 -0500
Subject: Re: SMP and CPU1 not showing interrupts in /proc/interrupts
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: James Harper <james.harper@bigpond.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E589799.3000105@bigpond.com>
References: <3E589799.3000105@bigpond.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eqalYVN55dQIg0OA/h5m"
Organization: 
Message-Id: <1046008358.1964.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 23 Feb 2003 14:52:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eqalYVN55dQIg0OA/h5m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-02-23 at 10:42, James Harper wrote:
> somewhere between about 2.5.53 and 2.5.62 my /proc/interrupts has gone=20
> from an approximately even distribution of interrupts between CPU0 and=20
> CPU1 to grossly uneven:
>=20
>            CPU0       CPU1      =20
>   0:   13223321    2233217    IO-APIC-edge  timer
>   1:      13442          0    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:     291874          0    IO-APIC-edge  serial
>   8:          3          0    IO-APIC-edge  rtc
>   9:          0          0    IO-APIC-edge  acpi
>  14:      18932          0    IO-APIC-edge  ide0
>  15:         14          0    IO-APIC-edge  ide1
>  16:     190607          1   IO-APIC-level  eth0, nvidia
>  17:       3214          0   IO-APIC-level  bttv0
>  18:      14249          1   IO-APIC-level  ide2
>  19:     121942          0   IO-APIC-level  uhci-hcd, wlan0
> NMI:          0          0
> LOC:   15458218   15458423
> ERR:          0
> MIS:          0
>=20
> if i really hit the system hard then CPU1 will start accruing interrupts=20
> but in a mostly idle state CPU1 just sits on its bum and lets CPU0=20
> handle them all, with the exception of irq #0, for some reason.

could you try the irqbalanced daemon for interrupt balancing:

http://people.redhat.com/arjanv/irqbalance/irqbalance-0.05.tar.gz


--=-eqalYVN55dQIg0OA/h5m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+WNImxULwo51rQBIRAowgAJ9Sv62dyKxj0Nmzj1HDGriYwIDHdACaAnAO
jFEsMjosamwZwWcNRtk0HZw=
=JWu9
-----END PGP SIGNATURE-----

--=-eqalYVN55dQIg0OA/h5m--
