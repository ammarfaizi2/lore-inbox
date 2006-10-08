Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWJHNdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWJHNdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWJHNde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:33:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31159 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751140AbWJHNde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:33:34 -0400
Date: Sun, 8 Oct 2006 14:33:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] m68k pt_regs fixes, part 2
Message-ID: <20061008133333.GM29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fallout from previous patch:
	* actually add include/asm-m68k/irq_regs.h
	* missed the prototype of sun3_sched_init()

NB: git diff without argumentgs sucks when you've added
some files...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/sun3/config.c     |    2 +-
 include/asm-m68k/irq_regs.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index db930f9..43e4aa3 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -35,7 +35,7 @@ extern char _text, _end;
 char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
 
 extern unsigned long sun3_gettimeoffset(void);
-extern void sun3_sched_init(irqreturn_t (*handler)(int, void *, struct pt_regs *));
+extern void sun3_sched_init(irqreturn_t (*handler)(int, void *));
 extern void sun3_get_model (char* model);
 extern void idprom_init (void);
 extern int sun3_hwclk(int set, struct rtc_time *t);
diff --git a/include/asm-m68k/irq_regs.h b/include/asm-m68k/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-m68k/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
-- 
1.4.2.GIT

