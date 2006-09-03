Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWICWOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWICWOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWICWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:08:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750830AbWICWIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fWqHhra4XgP7SwiThkgAlHhBr96Waub2Jtc8jbiQgHV00jfpWQieBtl0g6iU4dkMVpKyY1vEEVw5vP9+6Y7Pb7wjcVR/f8455QLIBOZVM5Mxb/Z+amUrsAgkspdgisXEHKRoxtnMMlREjpWuDKeflk3CptEfqFwPS82w3Y2CC9o=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 14/26] Dynamic kernel command-line - mips
Date: Mon, 4 Sep 2006 00:58:42 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040050.13410.alon.barlev@gmail.com>
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040058.45412.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/mips/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/mips/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/mips/kernel/setup.c	
2006-09-03 18:55:11.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/mips/kernel/setup.c	2006-09-03 
19:47:58.000000000 +0300
@@ -145,7 +145,7 @@ static void __init print_memory_map(void
 
 static inline void parse_cmdline_early(void)
 {
-	char c = ' ', *to = command_line, *from = 
saved_command_line;
+	char c = ' ', *to = command_line, *from = 
boot_command_line;
 	unsigned long start_at, mem_size;
 	int len = 0;
 	int usermem = 0;
@@ -473,7 +473,7 @@ static void __init arch_mem_init(char **
 	plat_mem_setup();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, 
COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, 
COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 

-- 
VGER BF report: H 0.0445688
