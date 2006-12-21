Return-Path: <linux-kernel-owner+w=401wt.eu-S1423127AbWLUXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423127AbWLUXPw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423128AbWLUXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:15:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55522 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423127AbWLUXPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:15:51 -0500
Date: Fri, 22 Dec 2006 00:13:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] mm: export cancel_dirty_page()
Message-ID: <20061221231328.GA21217@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] export cancel_dirty_page()

export cancel_dirty_page() - it's used by hugetlbfs which can be 
modular. (This makes my -git based kernel yum repository build again.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/mm/truncate.c
===================================================================
--- linux.orig/mm/truncate.c
+++ linux/mm/truncate.c
@@ -65,6 +65,7 @@ void cancel_dirty_page(struct page *page
 		task_io_account_cancelled_write(account_size);
 	}
 }
+EXPORT_SYMBOL(cancel_dirty_page);
 
 /*
  * If truncate cannot remove the fs-private metadata from the page, the page
