Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUDEVHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUDEVHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:07:11 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:34432 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263202AbUDEVGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:06:43 -0400
Date: Mon, 5 Apr 2004 23:06:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: pmdisk needs asmlinkage
Message-ID: <20040405210633.GA3549@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, pmdisk neemore stuff, but asmlinkage is pretty clear; otherwise
it breaks with regparm. Please apply,
							Pavel

--- tmp/linux/kernel/power/pmdisk.c	2004-03-11 18:11:26.000000000 +0100
+++ linux/kernel/power/pmdisk.c	2004-03-11 18:18:32.000000000 +0100
@@ -35,7 +35,7 @@
 #include "power.h"
 
 
-extern int pmdisk_arch_suspend(int resume);
+extern asmlinkage int pmdisk_arch_suspend(int resume);
 
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
