Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUJ1WNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUJ1WNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUJ1WM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:12:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40974 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263089AbUJ1WLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:11:18 -0400
Date: Fri, 29 Oct 2004 00:10:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: acme@conectiva.com.br
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] appletalk: remove an unused function
Message-ID: <20041028221046.GI3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unsed function from net/appletalk/ddp.c


diffstat output:
 net/appletalk/ddp.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/net/appletalk/ddp.c.old	2004-10-28 23:49:44.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/appletalk/ddp.c	2004-10-28 23:49:57.000000000 +0200
@@ -78,13 +78,6 @@
 	sk_add_node(sk, &atalk_sockets);
 }
 
- -static inline void atalk_insert_socket(struct sock *sk)
- -{
- -	write_lock_bh(&atalk_sockets_lock);
- -	__atalk_insert_socket(sk);
- -	write_unlock_bh(&atalk_sockets_lock);
- -}
- -
 static inline void atalk_remove_socket(struct sock *sk)
 {
 	write_lock_bh(&atalk_sockets_lock);

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgW5mmfzqmE8StAARAvaMAJ94zqUtcUYZKMtwHKnTtKof9ew9pACeJIoT
d7KwwwKipvnGxnCmnwf8U0E=
=xXRj
-----END PGP SIGNATURE-----
