Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWCPD1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWCPD1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCPD1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:27:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19386 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752039AbWCPD1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:27:15 -0500
Date: Thu, 16 Mar 2006 12:26:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [5/19] loopback device.
Message-Id: <20060316122603.e6c7e26c.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/drivers/net/loopback.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/drivers/net/loopback.c
+++ linux-2.6.16-rc6-mm1/drivers/net/loopback.c
@@ -172,7 +172,7 @@ static struct net_device_stats *get_stat
 
 	memset(stats, 0, sizeof(struct net_device_stats));
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		struct net_device_stats *lb_stats;
 
 		lb_stats = &per_cpu(loopback_stats, i);
