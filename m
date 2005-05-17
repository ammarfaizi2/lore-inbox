Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVEQVXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVEQVXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEQVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:23:37 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:25227 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261960AbVEQVX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:23:29 -0400
Subject: CONFIG_KALLSYMS_EXTRA_PASS
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 17 May 2005 17:23:26 -0400
Message-Id: <1116365006.9737.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm working on a custom kernel, and suddenly I'm getting the compile
error "Try setting CONFIG_KALLSYMS_EXTRA_PASS".  I've also just did a
debian update, but that doesn't seem to bother the vanilla kernel.

What did I screw up to cause this kind of error?  For now I'll just set
this CONFIG option, but I would like to also know how to fix this. Where
do I start to look?

Thanks,

-- Steve


FYI:

$ diff -u System.map .tmp_System.map
--- System.map  2005-05-17 17:00:45.000000000 -0400
+++ .tmp_System.map     2005-05-17 17:00:45.000000000 -0400
@@ -25485,9 +25485,9 @@
 c03a1290 D kallsyms_addresses
 c03aae14 D kallsyms_num_syms
 c03aae18 D kallsyms_names
-c03c2b98 D kallsyms_markers
-c03c2c34 D kallsyms_token_table
-c03c300c D kallsyms_token_index
+c03c2b80 D kallsyms_markers
+c03c2c1c D kallsyms_token_table
+c03c2ff4 D kallsyms_token_index
 c03c4000 D idt_table
 c03c4000 A __nosave_begin
 c03c4000 A __nosave_end

Looks to me that the kallsyms_names have changed.
System.map has 0x17d80 bytes and .tmp_System.map has 0x17d68 bytes with
the difference of 0x18 or 24 bytes (six 32bit words). 

