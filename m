Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbSJSE4q>; Sat, 19 Oct 2002 00:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSJSE4p>; Sat, 19 Oct 2002 00:56:45 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:46737 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S265515AbSJSE4h>; Sat, 19 Oct 2002 00:56:37 -0400
Message-Id: <200210190459.g9J4x8vk008923@pool-141-150-241-241.delv.east.verizon.net>
Date: Sat, 19 Oct 2002 00:59:08 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 net/ipv4/raw.c NF_IP_LOCAL_OUT undefined
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Sat, 19 Oct 2002 00:02:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/raw.c needs to include netfilter_ipv4.h instead of just
netfilter.h

--- linux/net/ipv4/raw.c~	Sat Oct 19 00:47:05 2002
+++ linux/net/ipv4/raw.c	Sat Oct 19 00:47:11 2002
@@ -64,7 +64,7 @@
 #include <net/raw.h>
 #include <net/inet_common.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 
 struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
 rwlock_t raw_v4_lock = RW_LOCK_UNLOCKED;

-- 
Skip
