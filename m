Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWARUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWARUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWARUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:39:55 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:38842 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030428AbWARUjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:39:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rIp/07QFEdGkinu/JkQ0h+j/ox3FIU6MzBI72JKJzLYKM3BT/SWJpL0qt19RNUl9bvi6KOwJTBjchf2essJ8NZGG5cP3a18Lfyy4wdgrmOxKJF+KFiC566vaUEs6SQ8a1RFr+wU0NlTKLnPJlsGtRY4Bq+Wyfx6s4NPWFWQC+lg=
Date: Wed, 18 Jan 2006 23:57:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: remove irq_exit() from hardirq.h
Message-ID: <20060118205718.GC12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/hardirq.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

--- a/include/asm-arm26/hardirq.h
+++ b/include/asm-arm26/hardirq.h
@@ -27,13 +27,6 @@ typedef struct {
 
 extern asmlinkage void __do_softirq(void);
 
-#define irq_exit()                                                      \
-        do {                                                            \
-                preempt_count() -= IRQ_EXIT_OFFSET;                     \
-                if (!in_interrupt() && local_softirq_pending())         \
-                        __do_softirq();                                 \
-                preempt_enable_no_resched();                            \
-        } while (0)
 #endif
 
 

