Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTDVKUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTDVKUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:20:17 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47854 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263036AbTDVKUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:20:16 -0400
Subject: Re: 2.5.67-mm4 & IRQ balancing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030422120630.4048a8b1.philippe.gramoulle@mmania.com>
References: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
	 <20030418175116.75c8aa7b.akpm@digeo.com>
	 <20030419153923.6d63e22b.philippe.gramoulle@mmania.com>
	 <20030419133837.0118907b.akpm@digeo.com>
	 <20030422120630.4048a8b1.philippe.gramoulle@mmania.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rQEd80+7brMe2rlKYEFu"
Organization: Red Hat, Inc.
Message-Id: <1051007533.1420.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 22 Apr 2003 12:32:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rQEd80+7brMe2rlKYEFu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> Booted with "noirqbalance" & started irqbalance:
>=20
> $ cat /proc/interrupts
>            CPU0       CPU1      =20
>   0:      73897  247288143    IO-APIC-edge  timer
>   1:      38421         56    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:        177          0    IO-APIC-edge  serial
>   8:     107607          0    IO-APIC-edge  rtc
>  12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
>  15:         32        118    IO-APIC-edge  ide1
>  18:      12602       1159   IO-APIC-level  EMU10K1
>  19:     454172      15987   IO-APIC-level  uhci-hcd
>  20:     494005          0   IO-APIC-level  eth0
>  22:     717483      38681   IO-APIC-level  aic7xxx
>  23:          0          0   IO-APIC-level  uhci-hcd
> NMI:          0          0=20
> LOC:  247366287  247364170=20
> ERR:          0
> MIS:          0

this looks reasonably in balance; your biggest irq source is the timer,
which gets a cpu all of it's own and the rest of your irq sources is
hardly noticable and all go together on the other cpu for that reason to
counterbalance the "high rate" timer.=20

--=-rQEd80+7brMe2rlKYEFu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+pRotxULwo51rQBIRAkefAKCGcIREu5sl2dYdYPJGtRB5SlGSCgCfewtq
MDQruxoTr29jsAiGVClzhMs=
=B4d4
-----END PGP SIGNATURE-----

--=-rQEd80+7brMe2rlKYEFu--
