Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266714AbUFYL5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266714AbUFYL5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 07:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266713AbUFYL5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 07:57:06 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:14208 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266714AbUFYL45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:56:57 -0400
Date: Fri, 25 Jun 2004 13:56:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: swsusp: kill useless exports
Message-ID: <20040625115642.GA2307@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These exports seem totally unneccessary as swsusp can't be module
anyway. Idea by Patrick Mochel. Please apply,
							Pavel

--- linux-cvs//arch/i386/power/cpu.c	2004-06-25 13:08:23.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-06-24 23:37:00.000000000 +0200
@@ -147,7 +147,3 @@
 {
 	__restore_processor_state(&saved_context);
 }
-
-
-EXPORT_SYMBOL(save_processor_state);
-EXPORT_SYMBOL(restore_processor_state);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
