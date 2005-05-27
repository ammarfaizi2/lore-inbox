Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVE0NFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVE0NFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVE0NBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:01:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41640 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262470AbVE0M7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:59:04 -0400
Date: Fri, 27 May 2005 14:35:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: [patch] smp_processor_id() cleanup fix, 2.6.12-rc5
Message-ID: <20050527123509.GA6107@elte.hu>
References: <20050526104449.GA14289@elte.hu> <42966014.4070408@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42966014.4070408@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Dobson <colpatch@us.ibm.com> wrote:

> > + * lib/kernel_lock.c

> Nope.  It's lib/smp_processor_id.c.

indeed. Fix below.

	Ingo

--

fix comments in lib/smp_processor_id.c.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/lib/smp_processor_id.c.orig
+++ linux/lib/smp_processor_id.c
@@ -1,7 +1,7 @@
 /*
- * lib/kernel_lock.c
+ * lib/smp_processor_id.c
  *
- * DEBUG_PREEMPT variant of smp_processor_id.
+ * DEBUG_PREEMPT variant of smp_processor_id().
  */
 #include <linux/module.h>
 #include <linux/kallsyms.h>
