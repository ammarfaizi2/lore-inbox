Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbUJ1XMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUJ1XMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUJ1XJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:09:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261589AbUJ1XHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:07:07 -0400
Date: Fri, 29 Oct 2004 01:06:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Dillow <dave@thedillows.org>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/typhoon.c: remove an unused function
Message-ID: <20041028230629.GY3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from drivers/net/typhoon.c


diffstat output:
 drivers/net/typhoon.c |    8 --------
 1 files changed, 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/drivers/net/typhoon.c.old	2004-10-28 23:21:30.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/net/typhoon.c	2004-10-28 23:21:44.000000000 +0200
@@ -372,14 +372,6 @@
 	typhoon_inc_index(index, count, TXLO_ENTRIES);
 }
 
- -static inline void
- -typhoon_inc_rx_index(u32 *index, const int count)
- -{
- -	/* sizeof(struct rx_desc) != sizeof(struct cmd_desc) */
- -	*index += count * sizeof(struct rx_desc);
- -	*index %= RX_ENTRIES * sizeof(struct rx_desc);
- -}
- -
 static int
 typhoon_reset(void __iomem *ioaddr, int wait_type)
 {

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXt1mfzqmE8StAARAkWAAJ0dshTZ/dXqh+UdamvhZCzGA6cqvQCggWQf
JtBs+VjssQpn02lnVV9MhmA=
=6yW2
-----END PGP SIGNATURE-----
