Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVE3KyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVE3KyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVE3KyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:54:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10119 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261389AbVE3KyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:54:19 -0400
Date: Mon, 30 May 2005 16:22:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc: patch 1/6] Fix rcu initializers
Message-ID: <20050530105228.GB5534@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050530105042.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530105042.GA5534@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


RCU head initilizer no longer needs the head varible name since
we don't use list.h lists anymore. 

Signed-off-by : Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/rcupdate.h~fix-rcu-initializer include/linux/rcupdate.h
--- linux-2.6.12-rc5-fd/include/linux/rcupdate.h~fix-rcu-initializer	2005-05-29 18:54:06.000000000 +0530
+++ linux-2.6.12-rc5-fd-dipankar/include/linux/rcupdate.h	2005-05-29 18:54:06.000000000 +0530
@@ -52,8 +52,8 @@ struct rcu_head {
 	void (*func)(struct rcu_head *head);
 };
 
-#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL }
-#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
+#define RCU_HEAD_INIT 	{ .next = NULL, .func = NULL }
+#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT
 #define INIT_RCU_HEAD(ptr) do { \
        (ptr)->next = NULL; (ptr)->func = NULL; \
 } while (0)

_
