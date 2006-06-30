Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWF3JEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWF3JEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWF3JEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:04:30 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:3648 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932156AbWF3JE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:04:29 -0400
Date: Fri, 30 Jun 2006 11:03:21 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 1/2] add __[start|end]_rodata sections to asm-generic/sections.h
Message-ID: <20060630090321.GA9457@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add __start_rodata and __end_rodata to sections.h to avoid extern declarations.
Needed by s390 code (see following patch).

Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-generic/sections.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 0b49f9e..962cad7 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -14,5 +14,6 @@ extern char _end[];
 extern char __per_cpu_start[], __per_cpu_end[];
 extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __initdata_begin[], __initdata_end[];
+extern char __start_rodata[], __end_rodata[];
 
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
