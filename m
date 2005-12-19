Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVLSTy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVLSTy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbVLSTy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:54:58 -0500
Received: from mail.gmx.de ([213.165.64.21]:60858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964924AbVLSTy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:54:57 -0500
X-Authenticated: #5082238
Date: Mon, 19 Dec 2005 20:54:58 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Intel e1000 fails after RAM upgrade
Message-ID: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there!

First the basic system specs:
Athlon64 3500+ S939, Winchester
Kernel 2.6.14.4, X86_64
4*1 GB RAM DDR 333, Dual Channel [before: 2*1 GB RAM DDR 400, Dual Channel]
Intel Gigabit PCI (Intel Corporation 82540EM Gigabit Ethernet Controller (r=
ev 02))
Abit AV8

After upgrading the memory to 4 GB I noticed my e1000 did not work.
dmesg shows:

e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  TDH                  <2000>
  TDT                  <2000>
  next_to_use          <6>
  next_to_clean        <0>
buffer_info[next_to_clean]
  dma                  <13024c002>
  time_stamp           <ffffd8c7>
  next_to_watch        <0>
  jiffies              <ffffe096>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  TDH                  <2000>
  TDT                  <2000>
  next_to_use          <6>
  next_to_clean        <0>
buffer_info[next_to_clean]
  dma                  <13024c002>
  time_stamp           <ffffd8c7>
  next_to_watch        <0>
  jiffies              <ffffe28a>
  next_to_watch.status <0>
eth0: no IPv6 routers present
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  TDH                  <2000>
  TDT                  <2000>
  next_to_use          <6>
  next_to_clean        <0>
buffer_info[next_to_clean]
  dma                  <13024c002>
  time_stamp           <ffffd8c7>
  next_to_watch        <0>
  jiffies              <ffffe47e>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  TDH                  <2000>
  TDT                  <2000>
  next_to_use          <6>
  next_to_clean        <0>
buffer_info[next_to_clean]
  dma                  <13024c002>
  time_stamp           <ffffd8c7>
  next_to_watch        <0>
  jiffies              <ffffe672>
  next_to_watch.status <0>

ethtool -t eth0 offline:
The test result is FAIL
The test extra info:
Register test  (offline)         40
Eeprom test    (offline)         0
Interrupt test (offline)         4
Loopback test  (offline)         13
Link test   (on/offline)         1

I have two of these cards. Both run fine in my (old, 32bit) server. I
tested with both cards with both systems. Only in my 64bit machine this
error occurs - with both cards.

Please tell me what to do. I have to live with the VIA onboard in the
meantime and that is not the best network card...

Thanks a lot,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDpxASjUF4jpCSQBQRAkDDAJ9wHj+k0ij4rI6HSYHUariwQa9IkwCghKLr
xRzqguC24TxOMV1vs4JBkv0=
=l6+W
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
