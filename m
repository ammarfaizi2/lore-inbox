Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbUKQAIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUKQAIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbUKQAIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:08:00 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:28811 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261873AbUKQAEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 19:04:15 -0500
Message-ID: <419A95AC.9030201@us.ibm.com>
Date: Tue, 16 Nov 2004 18:05:00 -0600
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make ibmveth link always up
Content-Type: multipart/mixed;
 boundary="------------060008060404050801090409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008060404050801090409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

The attached patch makes the ibmveth driver indicate that its link is 
always up rather than always down, thus allowing the userspace side of 
booting to configure the network interface correctly.

Please apply,

Signed-Off-By: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------060008060404050801090409
Content-Type: text/plain;
 name="ibmveth_link_up.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_link_up.patch"

===== drivers/net/ibmveth.c 1.18 vs edited =====
--- 1.18/drivers/net/ibmveth.c	Mon Sep 13 19:23:15 2004
+++ edited/drivers/net/ibmveth.c	Tue Nov 16 18:24:42 2004
@@ -598,7 +598,7 @@
 }
 
 static u32 netdev_get_link(struct net_device *dev) {
-	return 0;
+	return 1;
 }
 
 static struct ethtool_ops netdev_ethtool_ops = {

--------------060008060404050801090409--
