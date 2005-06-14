Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFNOal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFNOal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFNOak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:30:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:46020 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261242AbVFNOaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:30:21 -0400
Date: Tue, 14 Jun 2005 19:57:35 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: fix rcu initializers
Message-ID: <20050614142735.GB4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614142612.GA4557@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



RCU head initilizer no longer needs the head varible name since
we don't use list.h lists anymore. 

Signed-off-by : Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/rcupdate.h~fix-rcu-initializer include/linux/rcupdate.h
--- linux-2.6.12-rc6-fd/include/linux/rcupdate.h~fix-rcu-initializer	2005-06-14 14:05:02.000000000 +0530
+++ linux-2.6.12-rc6-fd-dipankar/include/linux/rcupdate.h	2005-06-14 14:05:02.000000000 +0530
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
