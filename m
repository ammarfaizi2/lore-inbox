Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTENVXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTENVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:23:11 -0400
Received: from web40503.mail.yahoo.com ([66.218.78.120]:60329 "HELO
	web40503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262820AbTENVXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:23:11 -0400
Message-ID: <20030514213554.52466.qmail@web40503.mail.yahoo.com>
Date: Wed, 14 May 2003 14:35:54 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: [PATCH] fix kernel link error with 2.4.21rc2ac2 using gcc 3.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./net/core/rtnetlink.c.old  Wed May 14 18:38:59 2003
+++ ./net/core/rtnetlink.c      Wed May 14 18:38:37 2003
@@ -394,7 +394,7 @@
  * Malformed skbs with wrong lengths of messages are discarded silently.
  */

-extern __inline__ int rtnetlink_rcv_skb(struct sk_buff *skb)
+extern int rtnetlink_rcv_skb(struct sk_buff *skb)
 {
        int err;
        struct nlmsghdr * nlh;


Note: this problem exists in 2.4.21rc1 as well.

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
