Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbUJ1U7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUJ1U7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUJ1U7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:59:07 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45805 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262226AbUJ1U6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:58:50 -0400
Date: Thu, 28 Oct 2004 13:58:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.10-rc1-bk7] Fix ppc32 compile (Was: Re: prep_setup.c syntax error)
Message-ID: <20041028205848.GE2097@smtp.west.cox.net>
References: <20041028201534.GA6248@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028201534.GA6248@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:15:34PM +0200, Olaf Hering wrote:

> the last patch doesnt compile.
> 
> linux-2.6.10-rc1-bk7/arch/ppc/platforms/prep_setup.c:967: error: parse error before "return"
> 
> 
> http://linux.bkbits.net:8080/linux-2.5/gnupatch@41801ba70RWW4DIxeswrgPg6ExEg2w

D'oh.  Something got cut-off there on Randy's end.  Obviously correct
fix follows.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.57/arch/ppc/platforms/prep_setup.c	2004-10-27 15:05:16 -07:00
+++ edited/arch/ppc/platforms/prep_setup.c	2004-10-28 13:55:20 -07:00
@@ -964,7 +964,8 @@
 	if (OpenPIC_Addr != NULL)
 		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
 		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-				return 0;
+				i8259_irq);
+	return 0;
 }
 arch_initcall(prep_request_cascade);
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
