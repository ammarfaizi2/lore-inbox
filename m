Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVAXAk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVAXAk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVAXAk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:40:28 -0500
Received: from smtp.ono.com ([62.42.230.12]:2709 "EHLO resmta05.ono.com")
	by vger.kernel.org with ESMTP id S261396AbVAXAjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:39:35 -0500
Message-ID: <41F443BE.1030108@usuarios.retecal.es>
Date: Mon, 24 Jan 2005 01:39:26 +0100
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <rrey@usuarios.retecal.es>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [2.6.11-rc2] Badness in local_bh_enable at kernel/softirq.c:140
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I get this with 2.6.11-rc2

Badness in local_bh_enable at kernel/softirq.c:140
~ [<c01162c0>] local_bh_enable+0x60/0x80
~ [<d0abee37>] destroy_conntrack+0xb7/0xe0 [ip_conntrack]
~ [<c0209580>] sock_wfree+0x0/0x40
~ [<c020a7ec>] __kfree_skb+0x6c/0xe0
~ [<d0a7a0d5>] rtl8139_start_xmit+0x75/0x120 [8139too]
~ [<c02199b1>] qdisc_restart+0x51/0xe0
~ [<c020f93a>] dev_queue_xmit+0x15a/0x1e0
~ [<c021488c>] neigh_resolve_output+0xcc/0x160
~ [<c022530b>] ip_finish_output2+0x8b/0x180
~ [<c0225280>] ip_finish_output2+0x0/0x180
~ [<c0218cf1>] nf_hook_slow+0x91/0xc0
~ [<c0225240>] dst_output+0x0/0x40
~ [<c02230ab>] ip_finish_output+0x1ab/0x1c0
~ [<c0225280>] ip_finish_output2+0x0/0x180
~ [<c0225240>] dst_output+0x0/0x40
~ [<c022524b>] dst_output+0xb/0x40
~ [<c0218cf1>] nf_hook_slow+0x91/0xc0
~ [<c0224e8e>] ip_push_pending_frames+0x3ce/0x440
~ [<c0225240>] dst_output+0x0/0x40
~ [<c02251aa>] ip_send_reply+0x18a/0x1e0
~ [<d0b10c18>] ip_nat_setup_info+0x78/0x200 [iptable_nat]
~ [<d0b10005>] ip_nat_fn+0x5/0x1c0 [iptable_nat]
~ [<c023798a>] tcp_v4_send_reset+0xca/0x120
~ [<c02386a2>] tcp_v4_checksum_init+0x82/0x140
~ [<c0238bc9>] tcp_v4_rcv+0x389/0x6a0
~ [<c0220960>] ip_local_deliver_finish+0x0/0x120
~ [<c02209f7>] ip_local_deliver_finish+0x97/0x120
~ [<c0218cf1>] nf_hook_slow+0x91/0xc0
~ [<c0220510>] ip_local_deliver+0x150/0x180
~ [<c0220960>] ip_local_deliver_finish+0x0/0x120
~ [<c0220c30>] ip_rcv_finish+0x1b0/0x220
~ [<c0220a80>] ip_rcv_finish+0x0/0x220
~ [<c0218cf1>] nf_hook_slow+0x91/0xc0
~ [<c02208a8>] ip_rcv+0x368/0x420
~ [<c0220a80>] ip_rcv_finish+0x0/0x220
~ [<c020fd95>] netif_receive_skb+0x115/0x180
~ [<c020a4d2>] alloc_skb+0x32/0xe0
~ [<d0a7a5ae>] rtl8139_rx+0x16e/0x2e0 [8139too]
~ [<d0a7a894>] rtl8139_poll+0x34/0xc0 [8139too]
~ [<c020ff5f>] net_rx_action+0x5f/0xe0
~ [<c011623a>] __do_softirq+0x7a/0xa0
~ [<c0103c19>] do_softirq+0x39/0x40
~ =======================
~ [<c0103b1d>] do_IRQ+0x3d/0x60
~ [<c010253a>] common_interrupt+0x1a/0x20

- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
Planet AUGCyL - http://augcyl.org/planet/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9EO+w4Wp058o43cRAuJ+AJ9XcoOKoBtRT21O5R4u4uVGR6LhMACfe+/p
npPvZJZFoki0MvUcu9HKQ1w=
=0BBb
-----END PGP SIGNATURE-----
