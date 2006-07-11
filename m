Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWGKEed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWGKEed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWGKEed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:34:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:31372 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965144AbWGKEec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:34:32 -0400
Subject: [Patch 5/6] list_islast utility
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592469.14142.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:34:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add another list utility function to check for last element in a list.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/list.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: linux-2.6.18-rc1/include/linux/list.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/list.h	2006-07-10 23:04:28.000000000 -0400
+++ linux-2.6.18-rc1/include/linux/list.h	2006-07-10 23:44:59.000000000 -0400
@@ -265,6 +265,17 @@ static inline void list_move_tail(struct
 }
 
 /**
+ * list_islast - tests whether @list is the last entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_islast(const struct list_head *list,
+				const struct list_head *head)
+{
+	return list->next == head;
+}
+
+/**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */


