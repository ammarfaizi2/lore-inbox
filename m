Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWJBTJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWJBTJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965359AbWJBTJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:09:03 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26326 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965356AbWJBTJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:09:00 -0400
Message-Id: <200610021908.k92J8wql015006@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.18 (git 95f3ef...)
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 02 Oct 2006 15:08:58 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 02 Oct 2006 15:08:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sparc64 I'm getting:

  CC      arch/sparc64/kernel/signal.o
In file included from include/linux/compat.h:16,
                 from arch/sparc64/kernel/signal.c:12:
include/asm/signal.h:177: error: expected specifier-qualifier-list before 'compat_sigset_t'

AFAICS this is defined in include/linux/compat.h, which is included by
signal.c only if CONFIG_SPARC32_COMPAT is defined (yep, that's a 'y' in my
.configure), but is included again in signal.h. This also looks broken to me.

I can't see what the compiler is complaining about (gcc-4.1.1-14.sparc on
Aurora Corona), as this is a typedef for a struct.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

