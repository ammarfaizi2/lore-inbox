Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUFXV7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUFXV7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUFXV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:58:39 -0400
Received: from gherkin.frus.com ([192.158.254.49]:57229 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S265233AbUFXVzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:55:41 -0400
Subject: 2.6.7: fs/jfs/jfs_dtree.c compile error
To: linux-kernel@vger.kernel.org
Date: Thu, 24 Jun 2004 16:55:37 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040624215537.8B8ECDBE2@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Older compilers (including the currently recommended minimum, which is
2.95.3) cannot handle the declaration at line 388 in the 2.6.7 version
of linux/fs/jfs/jfs_dtree.c.  Moving the declaration to line 377 is a
trivial fix.

376         if (index == (MAX_INLINE_DIRTABLE_ENTRY + 1)) {
377                 /*
378                  * It's time to move the inline table to an external
379                  * page and begin to build the xtree
380                  */
381                 if (dbAlloc(ip, 0, sbi->nbperpage, &xaddr))
382                         goto clean_up;  /* No space */
383 
384                 /*
385                  * Save the table, we're going to overwrite it with the
386                  * xtree root
387                  */
388                 struct dir_table_slot temp_table[12];

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
