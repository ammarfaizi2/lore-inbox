Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTLaPGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTLaPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:06:16 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:13331 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S265162AbTLaPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:06:12 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 31 Dec 2003 09:06:08 -0600
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Trivial C99 change to rcupdate.h
Message-ID: <20031231150608.GD29322@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a trivial patch that replaces the GNU initializers with
C99 initializers.

Art Haas

===== include/linux/rcupdate.h 1.4 vs edited =====
--- 1.4/include/linux/rcupdate.h	Thu Oct  2 02:12:13 2003
+++ edited/include/linux/rcupdate.h	Tue Dec 30 19:54:24 2003
@@ -55,7 +55,7 @@
 };
 
 #define RCU_HEAD_INIT(head) \
-		{ list: LIST_HEAD_INIT(head.list), func: NULL, arg: NULL }
+		{ .list = LIST_HEAD_INIT(head.list), .func = NULL, .arg = NULL }
 #define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
 #define INIT_RCU_HEAD(ptr) do { \
        INIT_LIST_HEAD(&(ptr)->list); (ptr)->func = NULL; (ptr)->arg = NULL; \
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
