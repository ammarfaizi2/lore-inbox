Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTJEHUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 03:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJEHUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 03:20:52 -0400
Received: from dp.samba.org ([66.70.73.150]:51139 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262987AbTJEHUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 03:20:51 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] [2.{4,5} TRIVIAL PATCH] Change list_emtpy() to take a const pointer
Date: Sun, 05 Oct 2003 16:51:27 +1000
Message-Id: <20031005072051.237422CC20@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>

  
  Hi Rusty, list
  
  Didn't know what was the best place to submit this one, I
  guessed trivial.
  
  Just change the definition of list_empty() to take a const
  pointer. I have some upper layers of code that do all the
  const/non-const thing and list_empty() breaks it without
  this.
  

--- trivial-2.6.0-test6-bk6/include/linux/list.h.orig	2003-10-05 16:50:40.000000000 +1000
+++ trivial-2.6.0-test6-bk6/include/linux/list.h	2003-10-05 16:50:40.000000000 +1000
@@ -203,7 +203,7 @@
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static inline int list_empty(struct list_head *head)
+static inline int list_empty(const struct list_head *head)
 {
 	return head->next == head;
 }
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>: [2.{4,5} TRIVIAL PATCH] Change list_emtpy() to take a const pointer
