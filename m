Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUJDNVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUJDNVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUJDNTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:19:25 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:17536 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266117AbUJDNTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:19:10 -0400
Date: Mon, 4 Oct 2004 12:58:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Compilation problem in -rc3-mm2
Message-ID: <20041004105816.GA1469@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm getting

  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c:203: error: redefinition of `is_irq_stack_ptr'
include/asm/hardirq.h:25: error: `is_irq_stack_ptr' previously defined
here
arch/i386/kernel/irq.c: In function `is_irq_stack_ptr':
arch/i386/kernel/irq.c:207: error: `hardirq_stack' undeclared (first
use in this function)
arch/i386/kernel/irq.c:207: error: (Each undeclared identifier is
reported only once
arch/i386/kernel/irq.c:207: error: for each function it appears in.)
arch/i386/kernel/irq.c:210: error: `softirq_stack' undeclared (first
use in this function)
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2
7.80user 0.76system 21.45 (0m21.457s) elapsed 39.91%CPU
pavel@amd:/usr/src/linux-mm$

while trying to compile -rc2-mm3.

I tried to set...

Use 4Kb for kernel stacks instead of 8Kb (4KSTACKS) [N/y/?] (NEW) y

...and it helped.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
