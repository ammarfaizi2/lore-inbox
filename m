Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWILWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWILWst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWILWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:48:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932331AbWILWst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:48:49 -0400
Date: Tue, 12 Sep 2006 18:48:44 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@redline.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>
cc: David Woodhouse <dwmw2@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH NET] add secmark headers to header-y
Message-ID: <Pine.LNX.4.44.0609121844450.26062-100000@redline.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes xt_SECMARK.h and xt_CONNSECMARK.h to the kernel 
headers which are exported via 'make headers_install'.  This is needed to 
allow userland code to be built correctly with these features.

Please apply, and consider for inclusion with 2.6.18 as a bugfix.

Signed-off-by: James Morris <jmorris@redhat.com>

---

 include/linux/netfilter/Kbuild |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -purN -X dontdiff linux-2.6.18-rc6.o/include/linux/netfilter/Kbuild linux-2.6.18-rc6.w/include/linux/netfilter/Kbuild
--- linux-2.6.18-rc6.o/include/linux/netfilter/Kbuild	2006-09-12 18:34:44.000000000 -0400
+++ linux-2.6.18-rc6.w/include/linux/netfilter/Kbuild	2006-09-12 18:41:39.000000000 -0400
@@ -5,7 +5,7 @@ header-y := nf_conntrack_sctp.h nf_connt
 	    xt_helper.h xt_length.h xt_limit.h xt_mac.h xt_mark.h	\
 	    xt_MARK.h xt_multiport.h xt_NFQUEUE.h xt_pkttype.h		\
 	    xt_policy.h xt_realm.h xt_sctp.h xt_state.h xt_string.h	\
-	    xt_tcpmss.h xt_tcpudp.h
+	    xt_tcpmss.h xt_tcpudp.h xt_SECMARK.h xt_CONNSECMARK.h
 
 unifdef-y := nf_conntrack_common.h nf_conntrack_ftp.h		\
 	nf_conntrack_tcp.h nfnetlink.h x_tables.h xt_physdev.h

