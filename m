Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162933AbWLBLA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162933AbWLBLA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162932AbWLBLAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:00:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759465AbWLBK7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ms1+jS6kqxqFu74Avw+lq6zINtO5uI1GdXIZosciMVt9l6Sg1B/UFmGXjS2NoICG2R6dKLracheJ9zwOGxiL55EdyKbgNeI9p9Tk8Qg3E9zMkVjqZTZVBIcJmSc4BCZHXoqw2DDzQYwo/zYmA7Z9xSdawNJni0pfayBKm/jGIqQ=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/26] Dynamic kernel command-line - mips
Date: Sat, 2 Dec 2006 12:53:22 +0200
User-Agent: KMail/1.9.5
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021253.23807.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/mips/kernel/setup.c linux-2.6.19/arch/mips/kernel/setup.c
--- linux-2.6.19.org/arch/mips/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/mips/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -409,7 +409,7 @@ static void __init arch_mem_init(char **
 	print_memory_map();
 
 	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
-	strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 
 	*cmdline_p = command_line;
 
