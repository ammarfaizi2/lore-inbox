Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUHXKjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUHXKjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHXKjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:39:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:27908 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267421AbUHXKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:39:02 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Try 2: compile fix for ipv4/ip_conntrack_proto_udp.c
Date: Tue, 24 Aug 2004 12:39:03 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HrxKBQZOuGknBxJ"
Message-Id: <200408241239.03908.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_HrxKBQZOuGknBxJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry, the patch I sent in a previous messages was empty.
This should work fine.

--Boundary-00=_HrxKBQZOuGknBxJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ip_conntrack_proto_udp-compile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ip_conntrack_proto_udp-compile-fix.patch"

--- linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_udp.c.old	2004-08-24 12:31:13.732307065 +0200
+++ linux-2.6.9-rc1/net/ipv4/netfilter/ip_conntrack_proto_udp.c	2004-08-24 12:31:08.618786469 +0200
@@ -13,7 +13,7 @@
 #include <linux/in.h>
 #include <linux/udp.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
 
 unsigned long ip_ct_udp_timeout = 30*HZ;

--Boundary-00=_HrxKBQZOuGknBxJ--
