Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVBALT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVBALT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVBALT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:19:59 -0500
Received: from ONRC.cluj.astral.ro ([82.208.135.134]:24523 "EHLO cj.onrc.ro")
	by vger.kernel.org with ESMTP id S261994AbVBALTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:19:51 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Date: Tue, 1 Feb 2005 13:14:54 +0200 (EET)
From: Tompa Septimius Paul <subzero@cj.onrc.ro>
To: linux-kernel@vger.kernel.org
Cc: netfilter@lists.netfilter.org
Subject: iptables and ip_conntrack_tuple.h compile fix
Message-ID: <Pine.LNX.4.58.0502011255020.24684@cj.onrc.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I try to recompile iptables iptables-1.2.11 with kernel 2.6.11-rc2
(and mm2) running and I don't succeed. It complains about
/usr/src/linux/include/linux/netfilter_ipv4/ip_conntrack_tuple.h
after this small changes iptables is compiling again.



--- ip_conntrack_tuple.h.old    2005-02-01 12:49:52.000000000 +0200
+++ ip_conntrack_tuple.h        2005-02-01 12:55:43.983819584 +0200
@@ -62,12 +62,11 @@
                                u_int16_t port;
                        } sctp;
                } u;

                /* The protocol. */
-               u8 protonum;
+               u_int16_t protonum;

                /* The direction (for tuplehash) */
-               u8 dir;
+               u_int16_t dir;
        } dst;
 };


A good day,

Tompa Septimius Paul <subzero@cj.onrc.ro>







________ Information from NOD32 ________
This message was checked by NOD32 Antivirus System for Linux Mail Server.
http://www.nod32.com
