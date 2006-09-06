Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWIFOT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWIFOT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIFOT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:19:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22474 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751142AbWIFOT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:19:27 -0400
Message-ID: <44FED8E3.5010900@fr.ibm.com>
Date: Wed, 06 Sep 2006 16:19:15 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 7/13] BC: kernel memory (marks)
References: <44FD918A.7050501@sw.ru> <44FD9717.1000709@sw.ru>
In-Reply-To: <44FD9717.1000709@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor issue bellow in arch/ia64/mm/init.c. I'm not sure what the charge
argument should be. Please check.

Regards,

C.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>

---
 arch/ia64/mm/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.18-rc5-mm1/arch/ia64/mm/init.c
===================================================================
--- 2.6.18-rc5-mm1.orig/arch/ia64/mm/init.c
+++ 2.6.18-rc5-mm1/arch/ia64/mm/init.c
@@ -95,7 +95,7 @@ check_pgt_cache(void)
        preempt_disable();
        while (unlikely((pages_to_free = min_pages_to_free()) > 0)) {
                while (pages_to_free--) {
-                       free_page((unsigned long)pgtable_quicklist_alloc());
+                       free_page((unsigned long)pgtable_quicklist_alloc(0));
                }
                preempt_enable();
                preempt_disable();
