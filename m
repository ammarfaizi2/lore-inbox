Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbUJ1WSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbUJ1WSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbUJ1WOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:14:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48398 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263089AbUJ1WNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:13:06 -0400
Date: Fri, 29 Oct 2004 00:12:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ctindel@users.sourceforge.net, fubar@us.ibm.com
Cc: bonding-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.6 patch] bonding: remove an unused function
Message-ID: <20041028221227.GJ3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unsed function from 
drivers/net/bonding/bond_3ad.c


diffstat output:
 drivers/net/bonding/bond_3ad.c |   10 ----------
 1 files changed, 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/net/bonding/bond_3ad.c.old	2004-10-28 23:18:00.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/bonding/bond_3ad.c	2004-10-28 23:18:19.000000000 +0200
@@ -130,7 +130,6 @@
 static u16 __get_link_speed(struct port *port);
 static u8 __get_duplex(struct port *port);
 static inline void __initialize_port_locks(struct port *port);
- -static inline void __deinitialize_port_locks(struct port *port);
 //conversions
 static void __ntohs_lacpdu(struct lacpdu *lacpdu);
 static u16 __ad_timer_to_ticks(u16 timer_type, u16 Par);
@@ -445,15 +444,6 @@
 	spin_lock_init(&(SLAVE_AD_INFO(port->slave).rx_machine_lock));
 }
 
- -/**
- - * __deinitialize_port_locks - deinitialize a port's RX machine spinlock
- - * @port: the port we're looking at
- - *
- - */
- -static inline void __deinitialize_port_locks(struct port *port)
- -{
- -}
- -
 //conversions
 /**
  * __ntohs_lacpdu - convert the contents of a LACPDU to host byte order

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgW7LmfzqmE8StAARAk7TAJ0cVwlvMQ1fX3f9lEs9Rs6zQ17q9gCff6im
vqlZA3/rLdhqLNRTdU3aVgM=
=eHej
-----END PGP SIGNATURE-----
