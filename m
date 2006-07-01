Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWGABGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWGABGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 21:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWGABGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 21:06:08 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:50773 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932515AbWGABGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 21:06:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cgX2puDqytkYi0W/mtoeuWg6VjVtPwY1Yy8itvIGKrURrkQO7oO/ItX/KpnViNorrz7VWbaprlXMh+FTNI6vRqb3k9doCND2OEKtEfa4ZgN1rOUqXBQ+CtY8wJK0ekxQBb79pj9nlvAFNfv7utMO9W3JTq4O5YtEAQSaTWUc8+o=  ;
Message-ID: <20060701010606.4694.qmail@web31809.mail.mud.yahoo.com>
Date: Fri, 30 Jun 2006 18:06:06 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is 4 byte aligned anyway.  This way we can use
up to 19+1 chars.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 include/linux/sched.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 18f12cb..3fc11bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -154,7 +154,7 @@ #define set_current_state(state_value)		
 	set_mb(current->state, (state_value))
 
 /* Task command name length */
-#define TASK_COMM_LEN 16
+#define TASK_COMM_LEN 20
 
 /*
  * Scheduling policies
-- 
1.4.1.rc2.g4ce4


