Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUJ1XH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUJ1XH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbUJ1XHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:07:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45329 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261433AbUJ1XEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:04:25 -0400
Date: Fri, 29 Oct 2004 01:03:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sri@us.ibm.com
Cc: lksctp-developers@lists.sourceforge.net, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sctp/outqueue.c: remove an unused function
Message-ID: <20041028230353.GW3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from net/sctp/outqueue.c


diffstat output:
 net/sctp/outqueue.c |   10 ----------
 1 files changed, 10 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/net/sctp/outqueue.c.old	2004-10-28 23:52:37.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/net/sctp/outqueue.c	2004-10-28 23:52:50.000000000 +0200
@@ -98,16 +98,6 @@
 	return;
 }
 
- -/* Insert a chunk behind chunk 'pos'. */
- -static inline void sctp_outq_insert_data(struct sctp_outq *q,
- -					 struct sctp_chunk *ch,
- -					 struct sctp_chunk *pos)
- -{
- -	__skb_insert((struct sk_buff *)ch, (struct sk_buff *)pos->prev,
- -		     (struct sk_buff *)pos, pos->list);
- -	q->out_qlen += ch->skb->len;
- -}
- -
 /*
  * SFR-CACC algorithm:
  * D) If count_of_newacks is greater than or equal to 2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgXrZmfzqmE8StAARAlEHAKCevPmOKkcjYcF2vr7Mjg1wsJ85eQCgtAIH
io31PrS52XafNuCn8gJAu1Q=
=KiNr
-----END PGP SIGNATURE-----
