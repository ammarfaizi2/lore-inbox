Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbVFWITZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVFWITZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVFWIP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:15:56 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:8276 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262530AbVFWHGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:06:22 -0400
Message-ID: <42BA5F5C.3080101@yahoo.com.au>
Date: Thu, 23 Jun 2005 17:06:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
CC: Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: [patch][rfc] 1/5: comment for mm/rmap.c
References: <42BA5F37.6070405@yahoo.com.au>
In-Reply-To: <42BA5F37.6070405@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070204050208010906070700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070204050208010906070700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/5

--------------070204050208010906070700
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

--------------070204050208010906070700--
Send instant messages to your online friends http://au.messenger.yahoo.com 
