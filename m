Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUJDKjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUJDKjM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUJDKjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:39:11 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:51339 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267984AbUJDKjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:39:07 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: akpm@osdl.org
Subject: Re: 2.6.9-rc3-mm2
Date: Mon, 4 Oct 2004 12:40:08 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041240.08490.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this lets it compile here:

>>>>
--- arch/i386/kernel/irq.c_rc3  2004-10-04 12:00:57.000000000 +0200
+++ arch/i386/kernel/irq.c      2004-10-04 12:34:30.000000000 +0200
@@ -199,6 +199,7 @@

 atomic_t irq_err_count;

+#ifdef CONFIG_4KSTACKS
 int is_irq_stack_ptr(struct task_struct *task, void *p)
 {
        unsigned long off;
@@ -213,7 +214,7 @@

        return 0;
 }
-
+#endif
 /*
  * /proc/interrupts printing:
  */
<<<<

Best regards,
Karsten
