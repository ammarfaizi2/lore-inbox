Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVGZITY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGZITY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGZIRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:17:22 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:63921 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261851AbVGZIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:16:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=hZFlbhH9I7DSwnrgCK2LoNdcDw2TEkmOBvrMiS25NBxlnwpBcw2qHib9dbdKRj+l9n1qfbCjd4eHI0pfyV6r58TKAYylTwoxwzkb3QcZqTyTWagQWyTjYfFM7f5VQa3qwfgcTlNymB5PYhb3zLNqfx+xmKu+hYNQ9ZfPkkIEZkY=  ;
Message-ID: <42E5F173.3010409@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:16:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 1/6] mm: comment rmap
References: <42E5F139.70002@yahoo.com.au>
In-Reply-To: <42E5F139.70002@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030200040706000708090507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030200040706000708090507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/6


--------------030200040706000708090507
Content-Type: text/plain;
 name="mm-comment-rmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-comment-rmap.patch"

Just be clear that VM_RESERVED pages here are a bug, and the test
is not there because they are expected.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/rmap.c
===================================================================
--- linux-2.6.orig/mm/rmap.c
+++ linux-2.6/mm/rmap.c
@@ -532,6 +532,8 @@ static int try_to_unmap_one(struct page 
 	 * If the page is mlock()d, we cannot swap it out.
 	 * If it's recently referenced (perhaps page_referenced
 	 * skipped over this mm) then we should reactivate it.
+	 *
+	 * Pages belonging to VM_RESERVED regions should not happen here.
 	 */
 	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
 			ptep_clear_flush_young(vma, address, pte)) {

--------------030200040706000708090507--
Send instant messages to your online friends http://au.messenger.yahoo.com 
