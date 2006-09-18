Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbWIRBjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWIRBjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWIRBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:39:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:49140 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965223AbWIRBib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:31 -0400
Message-Id: <20060918013218.001248000@klappe.arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:27:48 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 8/8] annotate netfilter header for make headers_check
Content-Disposition: inline; filename=headercheck-netfilter.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more warning to avoid from checking the user space exported
headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/include/linux/netfilter/nf_conntrack_sctp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/nf_conntrack_sctp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/nf_conntrack_sctp.h	2006-09-18 00:54:13.000000000 +0200
@@ -2,6 +2,8 @@
 #define _NF_CONNTRACK_SCTP_H
 /* SCTP tracking. */
 
+/* @headercheck: -include linux/types.h @ */
+
 #include <linux/netfilter/nf_conntrack_tuple_common.h>
 
 enum sctp_conntrack {
Index: linux-cg/include/linux/netfilter/x_tables.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/x_tables.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/x_tables.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _X_TABLES_H
 #define _X_TABLES_H
 
+/* @headercheck:-include linux/types.h @ */
+
 #define XT_FUNCTION_MAXNAMELEN 30
 #define XT_TABLE_MAXNAMELEN 32
 
Index: linux-cg/include/linux/netfilter/xt_CLASSIFY.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_CLASSIFY.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_CLASSIFY.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_CLASSIFY_H
 #define _XT_CLASSIFY_H
 
+/* @headercheck:-include linux/types.h @ */
+
 struct xt_classify_target_info {
 	u_int32_t priority;
 };
Index: linux-cg/include/linux/netfilter/xt_CONNMARK.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_CONNMARK.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_CONNMARK.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_CONNMARK_H_target
 #define _XT_CONNMARK_H_target
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
  * by Henrik Nordstrom <hno@marasystems.com>
  *
Index: linux-cg/include/linux/netfilter/xt_MARK.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_MARK.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_MARK.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_MARK_H_target
 #define _XT_MARK_H_target
 
+/* @headercheck:-include sys/types.h@ */
+
 /* Version 0 */
 struct xt_mark_target_info {
 	unsigned long mark;
Index: linux-cg/include/linux/netfilter/xt_NFQUEUE.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_NFQUEUE.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_NFQUEUE.h	2006-09-18 00:54:13.000000000 +0200
@@ -3,8 +3,9 @@
  * (C) 2005 Harald Welte <laforge@netfilter.org>
  *
  * This software is distributed under GNU GPL v2, 1991
- * 
-*/
+ *
+ */
+/* @headercheck:-include linux/types.h@ */
 #ifndef _XT_NFQ_TARGET_H
 #define _XT_NFQ_TARGET_H
 
Index: linux-cg/include/linux/netfilter/xt_connbytes.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_connbytes.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_connbytes.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_CONNBYTES_H
 #define _XT_CONNBYTES_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum xt_connbytes_what {
 	XT_CONNBYTES_PKTS,
 	XT_CONNBYTES_BYTES,
Index: linux-cg/include/linux/netfilter/xt_connmark.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_connmark.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_connmark.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_CONNMARK_H
 #define _XT_CONNMARK_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
  * by Henrik Nordstrom <hno@marasystems.com>
  *
Index: linux-cg/include/linux/netfilter/xt_dccp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_dccp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_dccp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_DCCP_H_
 #define _XT_DCCP_H_
 
+/* @headercheck:-include linux/types.h@ */
+
 #define XT_DCCP_SRC_PORTS	        0x01
 #define XT_DCCP_DEST_PORTS	        0x02
 #define XT_DCCP_TYPE			0x04
Index: linux-cg/include/linux/netfilter/xt_esp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_esp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_esp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_ESP_H
 #define _XT_ESP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct xt_esp
 {
 	u_int32_t spis[2];	/* Security Parameter Index */
Index: linux-cg/include/linux/netfilter/xt_length.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_length.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_length.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_LENGTH_H
 #define _XT_LENGTH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct xt_length_info {
     u_int16_t	min, max;
     u_int8_t	invert;
Index: linux-cg/include/linux/netfilter/xt_limit.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_limit.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_limit.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_RATE_H
 #define _XT_RATE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* timings are in milliseconds. */
 #define XT_LIMIT_SCALE 10000
 
Index: linux-cg/include/linux/netfilter/xt_mac.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_mac.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_mac.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _XT_MAC_H
 #define _XT_MAC_H
 
+/* @headercheck:-include linux/types.h @ */
+/* @headercheck:-include linux/if_ether.h @ */
+
 struct xt_mac_info {
     unsigned char srcaddr[ETH_ALEN];
     int invert;
Index: linux-cg/include/linux/netfilter/xt_mark.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_mark.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_mark.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_MARK_H
 #define _XT_MARK_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct xt_mark_info {
     unsigned long mark, mask;
     u_int8_t invert;
Index: linux-cg/include/linux/netfilter/xt_multiport.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_multiport.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_multiport.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_MULTIPORT_H
 #define _XT_MULTIPORT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum xt_multiport_flags
 {
 	XT_MULTIPORT_SOURCE,
Index: linux-cg/include/linux/netfilter/xt_physdev.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_physdev.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_physdev.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,7 +1,10 @@
 #ifndef _XT_PHYSDEV_H
 #define _XT_PHYSDEV_H
 
-#ifdef __KERNEL__
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if.h@ */
+
+#ifdef __KERNEL
 #include <linux/if.h>
 #endif
 
Index: linux-cg/include/linux/netfilter/xt_policy.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_policy.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_policy.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,10 @@
 #ifndef _XT_POLICY_H
 #define _XT_POLICY_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/in.h@ */
+/* @headercheck:-include linux/in6.h@ */
+
 #define XT_POLICY_MAX_ELEM	4
 
 enum xt_policy_flags
Index: linux-cg/include/linux/netfilter/xt_realm.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_realm.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_realm.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_REALM_H
 #define _XT_REALM_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct xt_realm_info {
 	u_int32_t id;
 	u_int32_t mask;
Index: linux-cg/include/linux/netfilter/xt_sctp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_sctp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_sctp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_SCTP_H_
 #define _XT_SCTP_H_
 
+/* @headercheck:-include linux/types.h@ */
+
 #define XT_SCTP_SRC_PORTS	        0x01
 #define XT_SCTP_DEST_PORTS	        0x02
 #define XT_SCTP_CHUNK_TYPES		0x04
Index: linux-cg/include/linux/netfilter/xt_string.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_string.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_string.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_STRING_H
 #define _XT_STRING_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define XT_STRING_MAX_PATTERN_SIZE 128
 #define XT_STRING_MAX_ALGO_NAME_SIZE 16
 
Index: linux-cg/include/linux/netfilter/xt_tcpmss.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_tcpmss.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_tcpmss.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_TCPMSS_MATCH_H
 #define _XT_TCPMSS_MATCH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct xt_tcpmss_match_info {
     u_int16_t mss_min, mss_max;
     u_int8_t invert;
Index: linux-cg/include/linux/netfilter/xt_tcpudp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter/xt_tcpudp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter/xt_tcpudp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _XT_TCPUDP_H
 #define _XT_TCPUDP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* TCP matching stuff */
 struct xt_tcp
 {
Index: linux-cg/include/linux/netfilter_arp/arp_tables.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_arp/arp_tables.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_arp/arp_tables.h	2006-09-18 01:04:28.000000000 +0200
@@ -9,10 +9,14 @@
 #ifndef _ARPTABLES_H
 #define _ARPTABLES_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/if.h @ */
+/* @headercheck: -include linux/in.h @ */
+
 #ifdef __KERNEL__
 #include <linux/if.h>
-#include <linux/types.h>
 #include <linux/in.h>
+#include <linux/types.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #endif
Index: linux-cg/include/linux/netfilter_arp/arpt_mangle.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_arp/arpt_mangle.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_arp/arpt_mangle.h	2006-09-18 01:06:51.000000000 +0200
@@ -1,5 +1,10 @@
 #ifndef _ARPT_MANGLE_H
 #define _ARPT_MANGLE_H
+
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/in.h @ */
+/* @headercheck: -include linux/if.h @ */
+
 #include <linux/netfilter_arp/arp_tables.h>
 
 #define ARPT_MANGLE_ADDR_LEN_MAX sizeof(struct in_addr)
Index: linux-cg/include/linux/netfilter_bridge.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge.h	2006-09-18 00:54:13.000000000 +0200
@@ -5,9 +5,11 @@
  */
 
 #include <linux/netfilter.h>
-#if defined(__KERNEL__) && defined(CONFIG_BRIDGE_NETFILTER)
+#ifdef __KERNEL__
+#ifdef CONFIG_BRIDGE_NETFILTER
 #include <linux/if_ether.h>
 #endif
+#endif
 
 /* Bridge Hooks */
 /* After promisc drops, checksum checks. */
Index: linux-cg/include/linux/netfilter_bridge/ebt_802_3.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_802_3.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_802_3.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_802_3_H
 #define __LINUX_BRIDGE_EBT_802_3_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_802_3_SAP 0x01
 #define EBT_802_3_TYPE 0x02
 
Index: linux-cg/include/linux/netfilter_bridge/ebt_among.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_among.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_among.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_AMONG_H
 #define __LINUX_BRIDGE_EBT_AMONG_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_AMONG_DST 0x01
 #define EBT_AMONG_SRC 0x02
 
Index: linux-cg/include/linux/netfilter_bridge/ebt_arp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_arp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_arp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef __LINUX_BRIDGE_EBT_ARP_H
 #define __LINUX_BRIDGE_EBT_ARP_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/if_ether.h @ */
+
 #define EBT_ARP_OPCODE 0x01
 #define EBT_ARP_HTYPE 0x02
 #define EBT_ARP_PTYPE 0x04
Index: linux-cg/include/linux/netfilter_bridge/ebt_arpreply.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_arpreply.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_arpreply.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_ARPREPLY_H
 #define __LINUX_BRIDGE_EBT_ARPREPLY_H
 
+/* @headercheck:-include linux/if_ether.h@ */
+
 struct ebt_arpreply_info
 {
 	unsigned char mac[ETH_ALEN];
Index: linux-cg/include/linux/netfilter_bridge/ebt_ip.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_ip.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_ip.h	2006-09-18 00:54:13.000000000 +0200
@@ -11,6 +11,7 @@
  *    Innominate Security Technologies AG <mhopf@innominate.com>
  *    September, 2002
  */
+/* @headercheck:-include linux/if_ether.h@ */
 
 #ifndef __LINUX_BRIDGE_EBT_IP_H
 #define __LINUX_BRIDGE_EBT_IP_H
Index: linux-cg/include/linux/netfilter_bridge/ebt_limit.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_limit.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_limit.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_LIMIT_H
 #define __LINUX_BRIDGE_EBT_LIMIT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_LIMIT_MATCH "limit"
 
 /* timings are in milliseconds. */
Index: linux-cg/include/linux/netfilter_bridge/ebt_log.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_log.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_log.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_LOG_H
 #define __LINUX_BRIDGE_EBT_LOG_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_LOG_IP 0x01 /* if the frame is made by ip, log the ip information */
 #define EBT_LOG_ARP 0x02
 #define EBT_LOG_NFLOG 0x04
Index: linux-cg/include/linux/netfilter_bridge/ebt_mark_m.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_mark_m.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_mark_m.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_MARK_M_H
 #define __LINUX_BRIDGE_EBT_MARK_M_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_MARK_AND 0x01
 #define EBT_MARK_OR 0x02
 #define EBT_MARK_MASK (EBT_MARK_AND | EBT_MARK_OR)
Index: linux-cg/include/linux/netfilter_bridge/ebt_nat.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_nat.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_nat.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_NAT_H
 #define __LINUX_BRIDGE_EBT_NAT_H
 
+/* @headercheck: -include linux/if_ether.h @ */
+
 struct ebt_nat_info
 {
 	unsigned char mac[ETH_ALEN];
Index: linux-cg/include/linux/netfilter_bridge/ebt_pkttype.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_pkttype.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_pkttype.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_PKTTYPE_H
 #define __LINUX_BRIDGE_EBT_PKTTYPE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ebt_pkttype_info
 {
 	uint8_t pkt_type;
Index: linux-cg/include/linux/netfilter_bridge/ebt_stp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_stp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_stp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_STP_H
 #define __LINUX_BRIDGE_EBT_STP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_STP_TYPE		0x0001
 
 #define EBT_STP_FLAGS		0x0002
Index: linux-cg/include/linux/netfilter_bridge/ebt_ulog.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_ulog.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_ulog.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,10 @@
 #ifndef _EBT_ULOG_H
 #define _EBT_ULOG_H
 
+/* @headercheck: -include linux/types.h @ */
+/* @headercheck: -include linux/if.h    @ */
+/* @headercheck: -include linux/time.h  @ */
+
 #define EBT_ULOG_DEFAULT_NLGROUP 0
 #define EBT_ULOG_DEFAULT_QTHRESHOLD 1
 #define EBT_ULOG_MAXNLGROUPS 32 /* hardcoded netlink max */
Index: linux-cg/include/linux/netfilter_bridge/ebt_vlan.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_bridge/ebt_vlan.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_bridge/ebt_vlan.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_BRIDGE_EBT_VLAN_H
 #define __LINUX_BRIDGE_EBT_VLAN_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define EBT_VLAN_ID	0x01
 #define EBT_VLAN_PRIO	0x02
 #define EBT_VLAN_ENCAP	0x04
Index: linux-cg/include/linux/netfilter_decnet.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_decnet.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_decnet.h	2006-09-18 00:54:13.000000000 +0200
@@ -7,6 +7,7 @@
  * (C)1998 Rusty Russell -- This code is GPL.
  */
 
+/* @headercheck: -include limits.h @ */
 #include <linux/netfilter.h>
 
 /* only for userspace compatibility */
Index: linux-cg/include/linux/netfilter_ipv4.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4.h	2006-09-18 00:54:13.000000000 +0200
@@ -9,6 +9,8 @@
 
 /* only for userspace compatibility */
 #ifndef __KERNEL__
+#include <limits.h>
+
 /* IP Cache bits. */
 /* Src IP address. */
 #define NFC_IP_SRC		0x0001
Index: linux-cg/include/linux/netfilter_ipv4/Kbuild
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/Kbuild	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/Kbuild	2006-09-18 00:54:13.000000000 +0200
@@ -1,8 +1,7 @@
 
-header-y := ip_conntrack_helper.h ip_conntrack_helper_h323_asn1.h	\
-	    ip_conntrack_helper_h323_types.h ip_conntrack_protocol.h	\
+header-y := ip_conntrack_helper_h323_types.h				\
 	    ip_conntrack_sctp.h ip_conntrack_tcp.h ip_conntrack_tftp.h	\
-	    ip_nat_pptp.h ipt_addrtype.h ipt_ah.h	\
+	    ip_nat_pptp.h ipt_addrtype.h ipt_ah.h			\
 	    ipt_CLASSIFY.h ipt_CLUSTERIP.h ipt_comment.h		\
 	    ipt_connbytes.h ipt_connmark.h ipt_CONNMARK.h		\
 	    ipt_conntrack.h ipt_dccp.h ipt_dscp.h ipt_DSCP.h ipt_ecn.h	\
@@ -15,7 +14,8 @@
 	    ipt_TCPMSS.h ipt_tos.h ipt_TOS.h ipt_ttl.h ipt_TTL.h	\
 	    ipt_ULOG.h
 
-unifdef-y := ip_conntrack.h ip_conntrack_h323.h ip_conntrack_irc.h	\
+unifdef-y := ip_conntrack.h ip_conntrack_h323.h				\
+	ip_conntrack_helper_h323_asn1.h	ip_conntrack_irc.h		\
 	ip_conntrack_pptp.h ip_conntrack_proto_gre.h			\
 	ip_conntrack_tuple.h ip_nat.h ip_nat_rule.h ip_queue.h		\
 	ip_tables.h
Index: linux-cg/include/linux/netfilter_ipv4/ip_conntrack_helper.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_conntrack_helper.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_conntrack_helper.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,4 +1,5 @@
 /* IP connection tracking helpers. */
+
 #ifndef _IP_CONNTRACK_HELPER_H
 #define _IP_CONNTRACK_HELPER_H
 #include <linux/netfilter_ipv4/ip_conntrack.h>
Index: linux-cg/include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h	2006-09-18 00:54:13.000000000 +0200
@@ -85,6 +85,7 @@
 #define H323_ERROR_RANGE -2
 
 
+#ifdef __KERNEL__
 /*****************************************************************************
  * Decode Functions
  ****************************************************************************/
@@ -94,5 +95,6 @@
 int DecodeMultimediaSystemControlMessage(unsigned char *buf, size_t sz,
 					 MultimediaSystemControlMessage *
 					 mscm);
+#endif /* __KERNEL__ */
 
 #endif
Index: linux-cg/include/linux/netfilter_ipv4/ip_conntrack_pptp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_conntrack_pptp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_conntrack_pptp.h	2006-09-18 00:54:13.000000000 +0200
@@ -2,6 +2,8 @@
 #ifndef _CONNTRACK_PPTP_H
 #define _CONNTRACK_PPTP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* state of the control session */
 enum pptp_ctrlsess_state {
 	PPTP_SESSION_NONE,			/* no session present */
Index: linux-cg/include/linux/netfilter_ipv4/ip_conntrack_sctp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_conntrack_sctp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_conntrack_sctp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP_CONNTRACK_SCTP_H
 #define _IP_CONNTRACK_SCTP_H
 
+/* @headercheck:-include linux/types.h @ */
+
 #include <linux/netfilter/nf_conntrack_sctp.h>
 
 #endif /* _IP_CONNTRACK_SCTP_H */
Index: linux-cg/include/linux/netfilter_ipv4/ip_conntrack_tftp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP_CT_TFTP
 #define _IP_CT_TFTP
 
+/* @headercheck:-include linux/types.h @ */
+
 #define TFTP_PORT 69
 
 struct tftphdr {
@@ -13,8 +15,10 @@
 #define TFTP_OPCODE_ACK		4
 #define TFTP_OPCODE_ERROR	5
 
+#ifdef __KERNEL__
 extern unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
 				 enum ip_conntrack_info ctinfo,
 				 struct ip_conntrack_expect *exp);
+#endif
 
 #endif /* _IP_CT_TFTP */
Index: linux-cg/include/linux/netfilter_ipv4/ip_nat.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_nat.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_nat.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,5 +1,8 @@
 #ifndef _IP_NAT_H
 #define _IP_NAT_H
+
+/* @headercheck: -include linux/types.h @ */
+
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack_tuple.h>
 
Index: linux-cg/include/linux/netfilter_ipv4/ip_nat_pptp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_nat_pptp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_nat_pptp.h	2006-09-18 00:54:13.000000000 +0200
@@ -2,6 +2,8 @@
 #ifndef _NAT_PPTP_H
 #define _NAT_PPTP_H
 
+/* @headercheck:-include linux/types.h @ */
+
 /* conntrack private data */
 struct ip_nat_pptp {
 	u_int16_t pns_call_id;		/* NAT'ed PNS call id */
Index: linux-cg/include/linux/netfilter_ipv4/ip_nat_rule.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_nat_rule.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_nat_rule.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,5 +1,10 @@
 #ifndef _IP_NAT_RULE_H
 #define _IP_NAT_RULE_H
+
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if.h@ */
+/* @headercheck:-include linux/in.h@ */
+
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ip_nat.h>
Index: linux-cg/include/linux/netfilter_ipv4/ip_tables.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ip_tables.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ip_tables.h	2006-09-18 00:54:13.000000000 +0200
@@ -15,6 +15,10 @@
 #ifndef _IPTABLES_H
 #define _IPTABLES_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if.h@ */
+/* @headercheck:-include linux/in.h@ */
+
 #ifdef __KERNEL__
 #include <linux/if.h>
 #include <linux/types.h>
Index: linux-cg/include/linux/netfilter_ipv4/ipt_CLASSIFY.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_CLASSIFY.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_CLASSIFY.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_CLASSIFY_H
 #define _IPT_CLASSIFY_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_CLASSIFY.h>
 #define ipt_classify_target_info xt_classify_target_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_CLUSTERIP_H_target
 #define _IPT_CLUSTERIP_H_target
 
+/* @headercheck:-include linux/types.h @ */
+
 enum clusterip_hashmode {
     CLUSTERIP_HASHMODE_SIP = 0,
     CLUSTERIP_HASHMODE_SIP_SPT,
Index: linux-cg/include/linux/netfilter_ipv4/ipt_CONNMARK.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_CONNMARK.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_CONNMARK.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_CONNMARK_H_target
 #define _IPT_CONNMARK_H_target
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Copyright (C) 2002,2004 MARA Systems AB <http://www.marasystems.com>
  * by Henrik Nordstrom <hno@marasystems.com>
  *
Index: linux-cg/include/linux/netfilter_ipv4/ipt_DSCP.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_DSCP.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_DSCP.h	2006-09-18 00:54:13.000000000 +0200
@@ -8,6 +8,9 @@
  *
  * ipt_DSCP.h,v 1.7 2002/03/14 12:03:13 laforge Exp
 */
+
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IPT_DSCP_TARGET_H
 #define _IPT_DSCP_TARGET_H
 #include <linux/netfilter_ipv4/ipt_dscp.h>
Index: linux-cg/include/linux/netfilter_ipv4/ipt_ECN.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_ECN.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_ECN.h	2006-09-18 00:54:13.000000000 +0200
@@ -6,6 +6,9 @@
  * 
  * ipt_ECN.h,v 1.3 2002/05/29 12:17:40 laforge Exp
 */
+
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IPT_ECN_TARGET_H
 #define _IPT_ECN_TARGET_H
 #include <linux/netfilter_ipv4/ipt_DSCP.h>
Index: linux-cg/include/linux/netfilter_ipv4/ipt_MARK.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_MARK.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_MARK.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_MARK_H_target
 #define _IPT_MARK_H_target
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Backwards compatibility for old userspace */
 
 #include <linux/netfilter/xt_MARK.h>
Index: linux-cg/include/linux/netfilter_ipv4/ipt_NFQUEUE.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_NFQUEUE.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_NFQUEUE.h	2006-09-18 00:54:13.000000000 +0200
@@ -3,8 +3,11 @@
  * (C) 2005 Harald Welte <laforge@netfilter.org>
  *
  * This software is distributed under GNU GPL v2, 1991
- * 
-*/
+ *
+ */
+
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IPT_NFQ_TARGET_H
 #define _IPT_NFQ_TARGET_H
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_SAME.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_SAME.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_SAME.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _IPT_SAME_H
 #define _IPT_SAME_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/netfilter_ipv4/ip_nat.h@ */
+
 #define IPT_SAME_MAX_RANGE	10
 
 #define IPT_SAME_NODST		0x01
Index: linux-cg/include/linux/netfilter_ipv4/ipt_TCPMSS.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_TCPMSS.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_TCPMSS.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_TCPMSS_H
 #define _IPT_TCPMSS_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ipt_tcpmss_info {
 	u_int16_t mss;
 };
Index: linux-cg/include/linux/netfilter_ipv4/ipt_TOS.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_TOS.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_TOS.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_TOS_H_target
 #define _IPT_TOS_H_target
 
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef IPTOS_NORMALSVC
 #define IPTOS_NORMALSVC 0
 #endif
Index: linux-cg/include/linux/netfilter_ipv4/ipt_TTL.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_TTL.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_TTL.h	2006-09-18 00:54:13.000000000 +0200
@@ -4,6 +4,8 @@
 #ifndef _IPT_TTL_H
 #define _IPT_TTL_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum {
 	IPT_TTL_SET = 0,
 	IPT_TTL_INC,
Index: linux-cg/include/linux/netfilter_ipv4/ipt_ULOG.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_ULOG.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_ULOG.h	2006-09-18 00:54:13.000000000 +0200
@@ -4,6 +4,9 @@
  * 
  * Distributed under the terms of GNU GPL */
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if.h@ */
+
 #ifndef _IPT_ULOG_H
 #define _IPT_ULOG_H
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_addrtype.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_addrtype.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_addrtype.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_ADDRTYPE_H
 #define _IPT_ADDRTYPE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ipt_addrtype_info {
 	u_int16_t	source;		/* source-type mask */
 	u_int16_t	dest;		/* dest-type mask */
Index: linux-cg/include/linux/netfilter_ipv4/ipt_ah.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_ah.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_ah.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_AH_H
 #define _IPT_AH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ipt_ah
 {
 	u_int32_t spis[2];			/* Security Parameter Index */
Index: linux-cg/include/linux/netfilter_ipv4/ipt_connbytes.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_connbytes.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_connbytes.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_CONNBYTES_H
 #define _IPT_CONNBYTES_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_connbytes.h>
 #define ipt_connbytes_what xt_connbytes_what
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_connmark.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_connmark.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_connmark.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_CONNMARK_H
 #define _IPT_CONNMARK_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_connmark.h>
 #define ipt_connmark_info xt_connmark_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_dccp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_dccp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_dccp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_DCCP_H_
 #define _IPT_DCCP_H_
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_dccp.h>
 #define IPT_DCCP_SRC_PORTS	XT_DCCP_SRC_PORTS
 #define IPT_DCCP_DEST_PORTS	XT_DCCP_DEST_PORTS
Index: linux-cg/include/linux/netfilter_ipv4/ipt_dscp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_dscp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_dscp.h	2006-09-18 00:54:13.000000000 +0200
@@ -7,6 +7,9 @@
  *
  * ipt_dscp.h,v 1.3 2002/08/05 19:00:21 laforge Exp
 */
+
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IPT_DSCP_H
 #define _IPT_DSCP_H
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_ecn.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_ecn.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_ecn.h	2006-09-18 00:54:13.000000000 +0200
@@ -6,6 +6,8 @@
  * 
  * ipt_ecn.h,v 1.4 2002/08/05 19:39:00 laforge Exp
 */
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IPT_ECN_H
 #define _IPT_ECN_H
 #include <linux/netfilter_ipv4/ipt_dscp.h>
Index: linux-cg/include/linux/netfilter_ipv4/ipt_esp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_esp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_esp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_ESP_H
 #define _IPT_ESP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_esp.h>
 
 #define ipt_esp xt_esp
Index: linux-cg/include/linux/netfilter_ipv4/ipt_hashlimit.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_hashlimit.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_hashlimit.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _IPT_HASHLIMIT_H
 #define _IPT_HASHLIMIT_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if.h@ */
+
 /* timings are in milliseconds. */
 #define IPT_HASHLIMIT_SCALE 10000
 /* 1/10,000 sec period => max of 10,000/sec.  Min rate is then 429490
Index: linux-cg/include/linux/netfilter_ipv4/ipt_iprange.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_iprange.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_iprange.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_IPRANGE_H
 #define _IPT_IPRANGE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define IPRANGE_SRC		0x01	/* Match source IP address */
 #define IPRANGE_DST		0x02	/* Match destination IP address */
 #define IPRANGE_SRC_INV		0x10	/* Negate the condition */
Index: linux-cg/include/linux/netfilter_ipv4/ipt_length.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_length.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_length.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_LENGTH_H
 #define _IPT_LENGTH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_length.h>
 #define ipt_length_info xt_length_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_limit.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_limit.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_limit.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_RATE_H
 #define _IPT_RATE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_limit.h>
 #define IPT_LIMIT_SCALE XT_LIMIT_SCALE
 #define ipt_rateinfo xt_rateinfo
Index: linux-cg/include/linux/netfilter_ipv4/ipt_mac.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_mac.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_mac.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _IPT_MAC_H
 #define _IPT_MAC_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/if_ether.h@ */
+
 #include <linux/netfilter/xt_mac.h>
 #define ipt_mac_info xt_mac_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_mark.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_mark.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_mark.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_MARK_H
 #define _IPT_MARK_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Backwards compatibility for old userspace */
 #include <linux/netfilter/xt_mark.h>
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_multiport.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_multiport.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_multiport.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_MULTIPORT_H
 #define _IPT_MULTIPORT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_multiport.h>
 
 #define IPT_MULTIPORT_SOURCE		XT_MULTIPORT_SOURCE
Index: linux-cg/include/linux/netfilter_ipv4/ipt_owner.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_owner.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_owner.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_OWNER_H
 #define _IPT_OWNER_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* match and invert flags */
 #define IPT_OWNER_UID	0x01
 #define IPT_OWNER_GID	0x02
Index: linux-cg/include/linux/netfilter_ipv4/ipt_realm.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_realm.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_realm.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_REALM_H
 #define _IPT_REALM_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_realm.h>
 #define ipt_realm_info xt_realm_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_recent.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_recent.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_recent.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_RECENT_H
 #define _IPT_RECENT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define RECENT_NAME	"ipt_recent"
 #define RECENT_VER	"v0.3.1"
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_sctp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_sctp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_sctp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_SCTP_H_
 #define _IPT_SCTP_H_
 
+/* @headercheck:-include linux/types.h@ */
+
 #define IPT_SCTP_SRC_PORTS	        0x01
 #define IPT_SCTP_DEST_PORTS	        0x02
 #define IPT_SCTP_CHUNK_TYPES		0x04
Index: linux-cg/include/linux/netfilter_ipv4/ipt_string.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_string.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_string.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_STRING_H
 #define _IPT_STRING_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_string.h>
 
 #define IPT_STRING_MAX_PATTERN_SIZE XT_STRING_MAX_PATTERN_SIZE
Index: linux-cg/include/linux/netfilter_ipv4/ipt_tcpmss.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_tcpmss.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_tcpmss.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_TCPMSS_MATCH_H
 #define _IPT_TCPMSS_MATCH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_tcpmss.h>
 #define ipt_tcpmss_match_info xt_tcpmss_match_info
 
Index: linux-cg/include/linux/netfilter_ipv4/ipt_tos.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_tos.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_tos.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IPT_TOS_H
 #define _IPT_TOS_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ipt_tos_info {
     u_int8_t tos;
     u_int8_t invert;
Index: linux-cg/include/linux/netfilter_ipv4/ipt_ttl.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv4/ipt_ttl.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv4/ipt_ttl.h	2006-09-18 00:54:13.000000000 +0200
@@ -4,6 +4,8 @@
 #ifndef _IPT_TTL_H
 #define _IPT_TTL_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum {
 	IPT_TTL_EQ = 0,		/* equals */
 	IPT_TTL_NE,		/* not equals */
Index: linux-cg/include/linux/netfilter_ipv6.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6.h	2006-09-18 00:54:13.000000000 +0200
@@ -8,6 +8,7 @@
  *   it's amazing what adding a bunch of 6s can do =8^)
  */
 
+/* @headercheck: -include limits.h @ */
 #include <linux/netfilter.h>
 
 /* only for userspace compatibility */
@@ -72,6 +73,7 @@
 	NF_IP6_PRI_LAST = INT_MAX,
 };
 
+#ifdef __KERNEL__
 #ifdef CONFIG_NETFILTER
 extern unsigned int nf_ip6_checksum(struct sk_buff *skb, unsigned int hook,
 				    unsigned int dataoff, u_int8_t protocol);
@@ -82,5 +84,6 @@
 static inline int ipv6_netfilter_init(void) { return 0; }
 static inline void ipv6_netfilter_fini(void) { return; }
 #endif /* CONFIG_NETFILTER */
+#endif
 
 #endif /*__LINUX_IP6_NETFILTER_H*/
Index: linux-cg/include/linux/netfilter_ipv6/ip6_tables.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6_tables.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6_tables.h	2006-09-18 00:54:13.000000000 +0200
@@ -15,6 +15,11 @@
 #ifndef _IP6_TABLES_H
 #define _IP6_TABLES_H
 
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/in6.h@ */
+/* @headercheck:-include linux/if.h@ */
+/* @headercheck:-include limits.h@ */
+
 #ifdef __KERNEL__
 #include <linux/if.h>
 #include <linux/types.h>
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_HL.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_HL.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_HL.h	2006-09-18 00:54:13.000000000 +0200
@@ -2,6 +2,8 @@
  * Maciej Soltysiak <solt@dns.toxicfilms.tv>
  * Based on HW's TTL module */
 
+/* @headercheck:-include linux/types.h@ */
+
 #ifndef _IP6T_HL_H
 #define _IP6T_HL_H
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_MARK.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_MARK.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_MARK.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_MARK_H_target
 #define _IP6T_MARK_H_target
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Backwards compatibility for old userspace */
 #include <linux/netfilter/xt_MARK.h>
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_REJECT.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_REJECT.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_REJECT.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_REJECT_H
 #define _IP6T_REJECT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum ip6t_reject_with {
 	IP6T_ICMP6_NO_ROUTE,
 	IP6T_ICMP6_ADM_PROHIBITED,
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_ah.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_ah.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_ah.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_AH_H
 #define _IP6T_AH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ip6t_ah
 {
 	u_int32_t spis[2];			/* Security Parameter Index */
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_esp.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_esp.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_esp.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_ESP_H
 #define _IP6T_ESP_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_esp.h>
 
 #define ip6t_esp xt_esp
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_frag.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_frag.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_frag.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_FRAG_H
 #define _IP6T_FRAG_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ip6t_frag
 {
 	u_int32_t ids[2];			/* Security Parameter Index */
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_hl.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_hl.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_hl.h	2006-09-18 00:54:13.000000000 +0200
@@ -5,6 +5,8 @@
 #ifndef _IP6T_HL_H
 #define _IP6T_HL_H
 
+/* @headercheck:-include linux/types.h@ */
+
 enum {
 	IP6T_HL_EQ = 0,		/* equals */
 	IP6T_HL_NE,		/* not equals */
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_ipv6header.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_ipv6header.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_ipv6header.h	2006-09-18 00:54:13.000000000 +0200
@@ -8,6 +8,8 @@
 #ifndef __IPV6HEADER_H
 #define __IPV6HEADER_H
 
+/* @headercheck:-include linux/types.h@ */
+
 struct ip6t_ipv6header_info
 {
 	u_int8_t matchflags;
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_length.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_length.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_length.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_LENGTH_H
 #define _IP6T_LENGTH_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_length.h>
 #define ip6t_length_info xt_length_info
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_limit.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_limit.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_limit.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_RATE_H
 #define _IP6T_RATE_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_limit.h>
 #define IP6T_LIMIT_SCALE XT_LIMIT_SCALE
 #define ip6t_rateinfo xt_rateinfo
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_mac.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_mac.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_mac.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_MAC_H
 #define _IP6T_MAC_H
 
+/* @headercheck:-include linux/if_ether.h@ */
+
 #include <linux/netfilter/xt_mac.h>
 #define ip6t_mac_info xt_mac_info
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_mark.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_mark.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_mark.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_MARK_H
 #define _IP6T_MARK_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* Backwards compatibility for old userspace */
 #include <linux/netfilter/xt_mark.h>
 
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_multiport.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_multiport.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_multiport.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_MULTIPORT_H
 #define _IP6T_MULTIPORT_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #include <linux/netfilter/xt_multiport.h>
 
 #define IP6T_MULTIPORT_SOURCE		XT_MULTIPORT_SOURCE
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_opts.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_opts.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_opts.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_OPTS_H
 #define _IP6T_OPTS_H
 
+/* @headercheck:-include linux/types.h@ */
+
 #define IP6T_OPTS_OPTSNR 16
 
 struct ip6t_opts
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_owner.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_owner.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_owner.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _IP6T_OWNER_H
 #define _IP6T_OWNER_H
 
+/* @headercheck:-include linux/types.h@ */
+
 /* match and invert flags */
 #define IP6T_OWNER_UID	0x01
 #define IP6T_OWNER_GID	0x02
Index: linux-cg/include/linux/netfilter_ipv6/ip6t_rt.h
===================================================================
--- linux-cg.orig/include/linux/netfilter_ipv6/ip6t_rt.h	2006-09-18 00:47:50.000000000 +0200
+++ linux-cg/include/linux/netfilter_ipv6/ip6t_rt.h	2006-09-18 00:54:13.000000000 +0200
@@ -1,7 +1,8 @@
 #ifndef _IP6T_RT_H
 #define _IP6T_RT_H
 
-/*#include <linux/in6.h>*/
+/* @headercheck:-include linux/types.h@ */
+/* @headercheck:-include linux/in6.h@ */
 
 #define IP6T_RT_HOPS 16
 

--

