Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTBDAZ6>; Mon, 3 Feb 2003 19:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBDAZ5>; Mon, 3 Feb 2003 19:25:57 -0500
Received: from marionberry.cc.columbia.edu ([128.59.59.100]:38023 "EHLO
	marionberry.cc.columbia.edu") by vger.kernel.org with ESMTP
	id <S267068AbTBDAZ4>; Mon, 3 Feb 2003 19:25:56 -0500
Message-ID: <05db01c2cbe5$4b4c34f0$9c2a3b80@zhengthinkpad>
From: "Haoqiang Zheng" <hzheng@cs.columbia.edu>
To: <linux-kernel@vger.kernel.org>
Subject: linux hangs with printk on schedule()
Date: Mon, 3 Feb 2003 19:35:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found Linux hangs when printk is inserted to the function schedule().
Sure, it doesn't make much sense to add such a line to schedule(). But Linux
shouldn't hang anyway, right? It's assumed that printk can be inserted
safely to anywhere. So, is it a bug of Linux?

The linux I am running is 2.4.18-14, the same version used by Redhat 8.0.
The scheduler is Ingo's O(1) scheduler.


Here is a fragment of the code
****************************************************************
 switch (prev->state) {
     ------
     default:
            printk("deactivating task pid=%d
comm=%s\n",prev->pid,prev->comm);
             deactivate_task(prev, rq);
  }
******************************************************************

