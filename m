Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTEGUe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTEGUe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:34:26 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:55282 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264271AbTEGUeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:34:25 -0400
Subject: Re: x86_64 interrupts handled by CPU0 only
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Will Dinkel <wdinkel@atipa.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1052326953.22518.184.camel@zappa>
References: <1052326953.22518.184.camel@zappa>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZODK32aD7kZexl85JZEP"
Organization: Red Hat, Inc.
Message-Id: <1052340377.1404.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 07 May 2003 22:46:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZODK32aD7kZexl85JZEP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-05-07 at 19:02, Will Dinkel wrote:
> Are all interrupts supposed to be handled by CPU0 on x86_64, or is
> something amiss?  I'm getting the following on Mandrake Corporate Server
> 2.1:
>=20
> ---
> [root@lab180 root]# uname -r -v -m -o
> 2.4.19-31mdksmp #1 SMP Thu Apr 17 09:34:46 EDT 2003 x86_64 GNU/Linux
> [root@lab180 root]# cat /proc/interrupts
>            CPU0       CPU1
>   0:     447602          0    IO-APIC-edge  timer
>   1:        424          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>  12:        851          0    IO-APIC-edge  PS/2 Mouse
>  14:      25038          1    IO-APIC-edge  ide0
>  15:       4930          1    IO-APIC-edge  ide1
>  19:          0          0   IO-APIC-level  usb-ohci, usb-ohci
>  24:     105196          0   IO-APIC-level  ioc0, eth0
>  25:         46          0   IO-APIC-level  ioc1
> NMI:       2235       3808
> LOC:     447494     447555
> ERR:          0
> MIS:          0
> ---
>=20
> I see this behavior on systems using either the MSI or Tyan dual-opteron
> boards.  I also see it on RedHat's preview x86_64 distribution (kernel
> version 2.4.20-9.2).


please use irqbalanced ;)

--=-ZODK32aD7kZexl85JZEP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+uXCZxULwo51rQBIRAiaIAJ9vurl9cXJrKai41X6U0l+DNy/p6ACeNepV
DxB5B+rNNqdQ2cOUkFQThJ0=
=Pq7P
-----END PGP SIGNATURE-----

--=-ZODK32aD7kZexl85JZEP--
