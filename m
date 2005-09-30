Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVI3G0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVI3G0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVI3G0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:26:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:58437 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932454AbVI3G0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:26:05 -0400
Message-ID: <433CDBF3.8080107@sw.ru>
Date: Fri, 30 Sep 2005 10:32:19 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] [x86_64] Add missing () around arguments of pte_index macro
Content-Type: multipart/mixed;
 boundary="------------020302090509050408060203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302090509050408060203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

x86-64: Add missing () around arguments of pte_index macro

Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill

--------------020302090509050408060203
Content-Type: text/plain;
 name="diff-x86_64-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-x86_64-3"

c45adb520392fc82ffd647c8c9ba57bbf89c7ca2
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -384,7 +384,7 @@ extern inline pte_t pte_modify(pte_t pte
 }
 
 #define pte_index(address) \
-		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
+		(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, address) ((pte_t *) pmd_page_kernel(*(dir)) + \
 			pte_index(address))
 


--------------020302090509050408060203--

