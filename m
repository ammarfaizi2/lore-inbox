Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVCCLIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVCCLIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCCLIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:08:24 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:2996 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262511AbVCCKlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:41:44 -0500
Date: Thu, 3 Mar 2005 11:41:30 +0100
Message-Id: <200503031041.j23AfUkf020695@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 3/16] DocBook: update function parameter description in network code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: update function parameter description in network code
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2027  -> 1.2028 
#	  drivers/net/8390.c	1.27    -> 1.28   
#	   net/core/skbuff.c	1.41    -> 1.42   
#	include/linux/skbuff.h	1.59    -> 1.60   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2028
# DocBook: update function parameter description in network code
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/drivers/net/8390.c b/drivers/net/8390.c
--- a/drivers/net/8390.c	Thu Mar  3 11:41:34 2005
+++ b/drivers/net/8390.c	Thu Mar  3 11:41:34 2005
@@ -999,6 +999,7 @@
 
 /**
  * alloc_ei_netdev - alloc_etherdev counterpart for 8390
+ * @size: extra bytes to allocate
  *
  * Allocate 8390-specific net_device.
  */
diff -Nru a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	Thu Mar  3 11:41:34 2005
+++ b/include/linux/skbuff.h	Thu Mar  3 11:41:34 2005
@@ -187,6 +187,8 @@
  *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
  *      @private: Data which is private to the HIPPI implementation
  *	@tc_index: Traffic control index
+ *	@tc_verd: traffic control verdict
+ *	@tc_classid: traffic control classid
  */
 
 struct sk_buff {
diff -Nru a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	Thu Mar  3 11:41:34 2005
+++ b/net/core/skbuff.c	Thu Mar  3 11:41:34 2005
@@ -1444,7 +1444,7 @@
 
 			if (pos < len) {
 				/* Split frag.
-				 * We have to variants in this case:
+				 * We have two variants in this case:
 				 * 1. Move all the frag to the second
 				 *    part, if it is possible. F.e.
 				 *    this approach is mandatory for TUX,
@@ -1467,6 +1467,9 @@
 
 /**
  * skb_split - Split fragmented skb to two parts at length len.
+ * @skb: the buffer to split
+ * @skb1: the buffer to receive the second part
+ * @len: new length for skb
  */
 void skb_split(struct sk_buff *skb, struct sk_buff *skb1, const u32 len)
 {
