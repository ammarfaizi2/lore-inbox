Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUDENwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUDENwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:52:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262488AbUDENw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:52:27 -0400
Date: Mon, 5 Apr 2004 09:52:23 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [SELINUX] 2/2 Remove duplicate assignment
In-Reply-To: <Xine.LNX.4.44.0404050949220.14610-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0404050951170.14610-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a harmless duplicate assignment from the IPv6 code.

Please apply.


diff -urN -X dontdiff linux-2.6.5-mm1.p/security/selinux/hooks.c linux-2.6.5-mm1.w/security/selinux/hooks.c
--- linux-2.6.5-mm1.p/security/selinux/hooks.c	2004-04-05 09:20:26.000000000 -0400
+++ linux-2.6.5-mm1.w/security/selinux/hooks.c	2004-04-05 09:49:17.060382256 -0400
@@ -2712,7 +2712,7 @@
 static int selinux_parse_skb_ipv6(struct sk_buff *skb, struct avc_audit_data *ad)
 {
 	u8 nexthdr;
-	int ret, offset = skb->nh.raw - skb->data;
+	int ret, offset;
 	struct ipv6hdr ipv6h;
 
 	offset = skb->nh.raw - skb->data;

