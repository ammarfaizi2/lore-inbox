Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317899AbSFSPG2>; Wed, 19 Jun 2002 11:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317900AbSFSPG1>; Wed, 19 Jun 2002 11:06:27 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:57733 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317899AbSFSPG1>; Wed, 19 Jun 2002 11:06:27 -0400
Date: Wed, 19 Jun 2002 17:06:15 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] export ioremap_nocache to modules
Message-ID: <20020619150615.GA16023@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch exports ioremap_nocache to modules, used by at least
some of the sound drivers....

Stelian.

===== arch/i386/kernel/i386_ksyms.c 1.23 vs edited =====
--- 1.23/arch/i386/kernel/i386_ksyms.c	Mon May 20 19:51:16 2002
+++ edited/arch/i386/kernel/i386_ksyms.c	Wed Jun 19 16:55:00 2002
@@ -63,6 +63,7 @@
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);
 EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap_nocache);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(enable_irq);
 EXPORT_SYMBOL(disable_irq);
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
