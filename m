Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275110AbTHRV3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275125AbTHRV3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:29:47 -0400
Received: from fmr06.intel.com ([134.134.136.7]:55032 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S275110AbTHRV2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:28:06 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [2.{4,5} TRIVIAL PATCH] Change list_emtpy() to take a const pointer
Date: Mon, 18 Aug 2003 14:28:03 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE6B8AA3@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.{4,5} TRIVIAL PATCH] Change list_emtpy() to take a const pointer
Thread-Index: AcNlz5xXhNMJYIx4QKGg8YhIq1WO8Q==
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
X-OriginalArrivalTime: 18 Aug 2003 21:28:03.0716 (UTC) FILETIME=[9B733440:01C365CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rusty, list

Didn't know what was the best place to submit this one, I
guessed trivial.

Just change the definition of list_empty() to take a const
pointer. I have some upper layers of code that do all the
const/non-const thing and list_empty() breaks it without
this.

--- linux/include/linux/list.h
+++ linux/include/linux/list.h
@@ -203,7 +203,7 @@
  * list_empty - tests whether a list is empty
  * @head: the list to test.
  */
-static inline int list_empty(struct list_head *head)
+static inline int list_empty(const struct list_head *head)
 {
 	return head->next == head;
 }
