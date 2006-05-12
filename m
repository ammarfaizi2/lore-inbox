Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWELKCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWELKCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWELKCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:02:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47268 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751104AbWELKCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:02:41 -0400
Date: Fri, 12 May 2006 12:02:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsusp: fix typo in cr0 handling
Message-ID: <20060512100201.GA28762@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing cr0 to cr2 register can't be right. This fixes the typo. I
wonder how it could survive so long.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/i386/power/cpu.c b/arch/i386/power/cpu.c
index 50a0bef..79b2370 100644
--- a/arch/i386/power/cpu.c
+++ b/arch/i386/power/cpu.c
@@ -92,7 +92,7 @@ void __restore_processor_state(struct sa
 	write_cr4(ctxt->cr4);
 	write_cr3(ctxt->cr3);
 	write_cr2(ctxt->cr2);
-	write_cr2(ctxt->cr0);
+	write_cr0(ctxt->cr0);
 
 	/*
 	 * now restore the descriptor tables to their proper values

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
