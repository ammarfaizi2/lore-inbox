Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUGHTgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUGHTgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGHTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:36:46 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:40914 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S261857AbUGHTgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:36:41 -0400
Date: Thu, 8 Jul 2004 20:36:34 +0100
From: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
To: greg@kroah.com, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Hinds <dhinds@sonic.net>
Cc: linux-kernel@vger.kernel.org
Subject: PCI subsystem related - kernel panic on boot
Message-ID: <20040708193634.GF3895@jsambrook>
Reply-To: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>
References: <A6974D8E5F98D511BB910002A50A6647615FF248@hdsmsx403.hd.intel.com> <1089080891.15653.430.camel@dhcppc4> <200407060914.29830.vda@port.imtp.ilyichevsk.odessa.ua> <01F2769B-CF26-11D8-BFEC-000A956E7DA6@thomasrepro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <01F2769B-CF26-11D8-BFEC-000A956E7DA6@thomasrepro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 01:25 on Tue 06/07/04, afeldhacker@thomasrepro.com masquerading as 'Andr=
ew Feldhacker' wrote:
>=20
> Thanks so much for your replies; if there's anything else you might=20
> need, please let me know.
>=20
> --Andrew Feldhacker

I've been getting the same problem on a somewhat different setup (see
below for details).

However I've narrowed things down the situation where if I remove one
PCI card the machine boots. I replace it and get exactly the same crash
as Feldhacker.

The card in question in the CardBus bridge: Texas Instruments PCI1410 PC
card Cardbus Controller as listed below.

Of note is that recent 2.4 kernels have failed to set this card up
properly. Older 2.4's, up to 2.4.22 (or maybe 2.4.23 - untested) work
fine, but later ones misdetect the inserted Cardbus card.

Any suggestions on how to proceed welcome.

Anyhow, those details I mentioned:

$ cat /proc/cpuinfo   =20
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 1800+
stepping        : 1
cpu MHz         : 1529.402
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3053.97



$ lspci=20
00:00.0 Host bridge: nVidia Corporation nForce CPU bridge=20
00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller
00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa=20
00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge=20
00:01.1 SMBus: nVidia Corporation nForce PCI System Management=20
00:02.0 USB Controller: nVidia Corporation nForce USB Controller
00:03.0 USB Controller: nVidia Corporation nForce USB Controller
00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet
Controller=20
00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device
01b0=20
00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio
00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge=20
00:09.0 IDE interface: nVidia Corporation nForce IDE=20
00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge=20
01:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus
Controller=20
01:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
02:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro
Ultra TF



Regards,
Jonathan

__
                  =20
 Jonathan Sambrook=20
Software  Developer=20
 Designer  Servers

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA7aJCSUOTbbpGXDwRAt2SAJ0UcxMqNG/xoQDzWKmuQMIHU6+oYgCfS/K5
X3MQNYBykeeTBxzZY5Kb9aw=
=0z3H
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
