Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVBNMB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVBNMB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVBNMB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:01:57 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52917 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261415AbVBNMBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:01:55 -0500
Subject: [PATCH 2.6.11-rc3-mm2] drivers/connector/connector.c: remove dead
	code
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: johnpol@2ka.mipt.ru, lkml <linux-kernel@vger.kernel.org>
Date: Mon, 14 Feb 2005 13:01:52 +0100
Message-Id: <1108382512.16745.36.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 13:10:36,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 13:10:38,
	Serialize complete at 14/02/2005 13:10:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unreachable code in cn_netlink_send() function.

Signed-off-by: Guillaume Thouvenin <guillaume.thouvenin@bull.net>

--- drivers/connector/connector.c.orig	2005-02-14 12:52:32.000000000 +0100
+++ drivers/connector/connector.c	2005-02-14 12:52:44.000000000 +0100
@@ -119,11 +119,6 @@ void cn_netlink_send(struct cn_msg *msg,
 	netlink_broadcast(dev->nls, skb, 0, groups, GFP_ATOMIC);
 
 	return;
-
-      nlmsg_failure:
-	printk(KERN_ERR "Failed to send %u.%u\n", msg->seq, msg->ack);
-	kfree_skb(skb);
-	return;
 }
 
 static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)


