Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268303AbRGWQ7C>; Mon, 23 Jul 2001 12:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268300AbRGWQ6l>; Mon, 23 Jul 2001 12:58:41 -0400
Received: from sncgw.nai.com ([161.69.248.229]:64482 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S268299AbRGWQ6d>;
	Mon, 23 Jul 2001 12:58:33 -0400
Message-ID: <XFMail.20010723100059.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 23 Jul 2001 10:00:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] small include/linux/list.h integration ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Subject says it all.


- Davide





diff -Nru linux-2.4.7.vanilla/include/linux/list.h linux-2.4.7/include/linux/list.h
--- linux-2.4.7.vanilla/include/linux/list.h    Fri Feb 16 16:06:17 2001
+++ linux-2.4.7/include/linux/list.h    Sun Jul 22 16:22:36 2001
@@ -149,6 +149,11 @@
 #define list_for_each(pos, head) \
        for (pos = (head)->next; pos != (head); pos = pos->next)
 
+#define list_first(head)       (((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
+#define list_last(head)        (((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
+#define list_next(pos, head)   (((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
+#define list_prev(pos, head)   (((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif


