Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSLZS7i>; Thu, 26 Dec 2002 13:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSLZS7i>; Thu, 26 Dec 2002 13:59:38 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:34746 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S263039AbSLZS7h>; Thu, 26 Dec 2002 13:59:37 -0500
Date: Thu, 26 Dec 2002 20:07:48 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [OOPS] Re: Linux v2.5.53
Message-Id: <20021226200748.4d2cea0d.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.8claws1 (GTK+ 1.2.10; Linux 2.5.53)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.xaQ7F'NUKYh'nZ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.xaQ7F'NUKYh'nZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2002 21:45:30 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.52 to v2.5.53
LT> ============================================

Hello,

One of the changes between 2.5.52 and 2.5.53 broke parport autoprobing.
I have a 2.5.53 kernel with all of parport built into the kernel and on
the kernel's command line "parport=auto". If I remove that, the oops goes
away. Since I don't have a serial console I wrote down the most important
bits of the oops:

EIP is at dma_alloc_coherent +0x18/0x80

Trace:

parport_pc_probe_port +0x42b/0x720
vgacon_scroll +0x140/0x230
scrup +0x133/0x140
mod_timer +0x12a/0x180
alloc_inode +0x17f/0x1b0
__pci_conf1_read +0xc3/0x100
pci_conf1_read +0x4a/0x50
pci_bus_read_config_byte +0x81/0x90
register_sysctl_table +0x67/0x90
init +0x3a/0x160
init +0x0/0x160
kernel_thread_helper +0x5/0x18

Hope this helps anyone to sort this out. If more info is necessary,
let me know.

Regards,
-Udo.

--=.xaQ7F'NUKYh'nZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+C1OGnhRzXSM7nSkRAkocAJ0ZrjEdmbY+E+xM1CyeGK16qGR2agCfWJ4M
favMx38y9SRdRZifLXO+WK4=
=xG8y
-----END PGP SIGNATURE-----

--=.xaQ7F'NUKYh'nZ--
