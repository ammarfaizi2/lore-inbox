Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTGMNAl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbTGMNAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:00:37 -0400
Received: from [203.59.3.38] ([203.59.3.38]:47625 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S265624AbTGMNAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:00:33 -0400
Subject: mis-identified cisco aironet pccard (and Re: hang with pcmcia wlan
	card)
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Jean Tourrilhes <jt@hpl.hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RiJaR6kuYXRcXMVQDsxk"
Message-Id: <1058100731.778.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Jul 2003 22:57:58 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RiJaR6kuYXRcXMVQDsxk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
i just noticed with 2.5.75 that if I boot with the cisco airo 340 wifi
card in, this kernel thinks it is a memory card. when i remove it and
re-insert it after boot, it then works .... see the following log :) I
am running debian unstable, on an ibm t21 pIII-850 notebook

the cisco card works at boot time using 2.5.70.

as for the two patches for the pcmcia hang, this time i am running the
one Russell posted, but the result is the same for the other.

as i shutdown i get a number of kernel stack dumps related to airo_stat,
but the machine reboots before i can do anything about them..(what do i
need to log them?)

if i replace the cisco card with a dlink orinoco card, it get recognised
correctly at boot.=20

to make this story more interesting, i put the thinkpad into the docking
station and the cisco card into the dock's pccard (something that has
locked up 2.5 every time that i tried it), and the card is recogised
correctly at boot, and runs fine (there was a kernel stack dump during
boot - *what do i need to do to get them logged?*)

thanks for the great work!

sven
--

Jul 13 21:36:43 [kernel] Linux Kernel Card Services 3.1.22
Jul 13 21:36:43 [kernel]   options:  [pci] [cardbus] [pm]
Jul 13 21:36:43 [kernel] PCI: Found IRQ 9 for device 0000:00:02.0
Jul 13 21:36:43 [kernel] PCI: Sharing IRQ 9 with 0000:00:05.0
Jul 13 21:36:43 [kernel] PCI: Sharing IRQ 9 with 0000:01:00.0
Jul 13 21:36:43 [kernel] Yenta IRQ list 00b8, PCI irq9
Jul 13 21:36:43 [kernel] Socket status: 30000010
Jul 13 21:36:43 [kernel] PCI: Found IRQ 9 for device 0000:00:02.1
Jul 13 21:36:43 [kernel] Yenta IRQ list 00b8, PCI irq9
Jul 13 21:36:43 [kernel] Socket status: 30000006
Jul 13 21:36:44 [cardmgr] watching 2 sockets
Jul 13 21:36:44 [kernel] cs: IO port probe 0x0c00-0x0cff: clean.
Jul 13 21:36:44 [kernel] cs: IO port probe 0x0800-0x08ff: clean.
Jul 13 21:36:44 [kernel] cs: IO port probe 0x0100-0x04ff: excluding
0x3c0-0x3df 0x4d0-0x4d7
Jul 13 21:36:44 [kernel] cs: IO port probe 0x0a00-0x0aff: clean.
Jul 13 21:36:44 [cardmgr] starting, version is 3.2.2
Jul 13 21:36:44 [kernel] cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jul 13 21:36:44 [cardmgr] socket 0: Anonymous Memory
Jul 13 21:36:44 [cardmgr] executing: 'modprobe memory_cs'
Jul 13 21:36:44 [cardmgr] + FATAL: Module memory_cs not found.
Jul 13 21:36:44 [cardmgr] modprobe exited with status 1
Jul 13 21:36:44 [cardmgr] module /lib/modules/2.5.75/pcmcia/memory_cs.o
not available
Jul 13 21:36:44 [cardmgr] bind 'memory_cs' to socket 0 failed: Invalid
argument
Jul 13 21:36:44 [cardmgr] socket 0: Anonymous Memory

......


Jul 13 21:53:01 [cardmgr] executing: 'modprobe -r memory_cs'
Jul 13 21:53:01 [cardmgr] + FATAL: Module memory_cs not found.
Jul 13 21:53:01 [cardmgr] modprobe exited with status 1

.......

Jul 13 21:56:11 [cardmgr] socket 0: Aironet PC4800
Jul 13 21:56:12 [cardmgr] executing: 'modprobe airo_cs'
Jul 13 21:56:12 [kernel] airo:  Probing for PCI adapters
Jul 13 21:56:12 [kernel] airo:  Finished probing for PCI adapters
Jul 13 21:56:12 [kernel] airo: MAC enabled eth1 0:40:96:33:e:a4
Jul 13 21:56:12 [cardmgr] executing: './network start eth1'
Jul 13 21:56:12 [kernel] bad: scheduling while atomic!
Jul 13 21:56:12 [kernel] bad: scheduling while atomic!
Jul 13 21:56:12 [dhclient] Internet Software Consortium DHCP Client
2.0pl5
Jul 13 21:56:12 [dhclient] Copyright 1995, 1996, 1997, 1998, 1999 The
Internet Software Consortium.
Jul 13 21:56:12 [dhclient] All rights reserved.
Jul 13 21:56:12 [dhclient]=20
Jul 13 21:56:12 [dhclient] Please contribute if you find this software
useful.
Jul 13 21:56:12 [kernel] bad: scheduling while atomic!
Jul 13 21:56:12 [dhclient] For info, please visit
http://www.isc.org/dhcp-contrib.html
Jul 13 21:56:12 [dhclient]=20
Jul 13 21:56:12 [dhclient] wifi0: unknown hardware address type 801
Jul 13 21:56:14 [dhclient] wifi0: unknown hardware address type 801
Jul 13 21:56:14 [dhclient] Listening on LPF/eth1/00:40:96:33:0e:a4
Jul 13 21:56:14 [dhclient] Sending on   LPF/eth1/00:40:96:33:0e:a4
Jul 13 21:56:14 [dhclient] Sending on   Socket/fallback/fallback-net
Jul 13 21:56:14 [dhclient] DHCPREQUEST on eth1 to 255.255.255.255 port
67
Jul 13 21:56:14 [dhclient] DHCPACK from 10.11.11.1
Jul 13 21:56:14 [dhclient] bound to 10.11.11.34 -- renewal in 21600
seconds.


--=-RiJaR6kuYXRcXMVQDsxk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EVX6PAwzu0QrW+kRAsOOAJ466lHXokiC+7iR/kvLAzjR/nfALwCeJcPK
JZGWSk6vLdp/UdaZ7ee/mN8=
=2Hh9
-----END PGP SIGNATURE-----

--=-RiJaR6kuYXRcXMVQDsxk--

