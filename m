Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRCaACl>; Fri, 30 Mar 2001 19:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRCaACb>; Fri, 30 Mar 2001 19:02:31 -0500
Received: from snorkel.uits.indiana.edu ([129.79.6.186]:2058 "EHLO
	snorkel.uits.indiana.edu") by vger.kernel.org with ESMTP
	id <S131730AbRCaACT>; Fri, 30 Mar 2001 19:02:19 -0500
Date: Fri, 30 Mar 2001 19:01:37 -0500
To: linux-kernel@vger.kernel.org
Subject: pcnet32 (maybe more) hosed in 2.4.3 
Message-ID: <20010330190137.A426@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: "Scott G. Miller" <scgmille@indiana.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linux 2.4.3, Debian Woody.  2.4.2 works without problems.  However, in
2.4.3, pcnet32 loads, gives an error message:

Mar 30 18:45:09 obsidian kernel: pcnet32_probe_pci: found device
0x001022.0x002000
Mar 30 18:45:09 obsidian kernel:     ioaddr=3D0x00b800
resource_flags=3D0x000101
Mar 30 18:45:09 obsidian kernel: <
Mar 30 18:45:09 obsidian kernel: 6>eth0: PCnet/FAST 79C971 at 0xb800,
warning: PROM address does not match CSR address 00 00 00 00 00 00
Mar 30 18:45:09 obsidian kernel:     tx_start_pt(0x0c00):~220 bytes,
BCR18(9861):BurstWrEn BurstRdEn NoUFlow
Mar 30 18:45:09 obsidian kernel:     SRAMSIZE=3D0x7f00, SRAM_BND=3D0x3f00,
Mar 30 18:45:09 obsidian kernel: pcnet32: pcnet32_private lp=3Dc3173000
lp_dma_addr=3D0x3173000 assigned IRQ 5.
Mar 30 18:45:09 obsidian kernel: pcnet32.c:v1.25kf 26.9.1999
tsbogend@alpha.franken.de


Though it does still load.

However, the interface does not come up.  (DHCP doesn't work, can't even
assign a manual address).=20

Worse, I get multiple entries for the driver in /proc/interrupts.  Each=20
time I attempt to bring the interface up another is added so I have:

  5:      11276      11416   IO-APIC-level  aic7xxx, PCnet/FAST 79C971,
PCnet/FAST 79C971, PCnet/FAST 79C971

When I attempt to rmmod the driver, even if there is only one, I get a
Kernel OOPS (in the interrupt handler, so it wasn't written
anywhere).  I'll attempt to copy it down by hand and post to the list in a
bit.  =20

	Scott


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6xR5hr9IW4v3mHtQRAqskAJ4krJiQLKiBXSf3/ENi7T6DudfHcACgkD+4
14T45OSJbpdBhlclpUvNsPM=
=+43b
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
