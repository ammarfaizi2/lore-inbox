Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSEGBKj>; Mon, 6 May 2002 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSEGBKi>; Mon, 6 May 2002 21:10:38 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:1464 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315276AbSEGBKc>;
	Mon, 6 May 2002 21:10:32 -0400
Date: Tue, 7 May 2002 11:10:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: TRIVIAL: Remove warning in mm/memory.c
Message-ID: <20020507011013.GD1163@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This patch removes an unused variable in
mm/memory.c.

diff -urN /home/dgibson/kernel/linuxppc-2.5/mm/memory.c linux-bluefish/mm/memory.c
--- /home/dgibson/kernel/linuxppc-2.5/mm/memory.c	Fri May  3 22:55:10 2002
+++ linux-bluefish/mm/memory.c	Tue May  7 10:06:44 2002
@@ -874,7 +874,6 @@
 		end = PMD_SIZE;
 	pfn = phys_addr >> PAGE_SHIFT;
 	do {
-		struct page *page;
 		pte_t oldpage = ptep_get_and_clear(pte);
 
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
