Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266562AbUFQQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266562AbUFQQaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266564AbUFQQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:30:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:38070 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266562AbUFQQaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:30:39 -0400
Date: Thu, 17 Jun 2004 09:29:28 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove EXPORT_SYMBOL(kallsyms_lookup)
Message-ID: <20040617162927.GA12498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Distros have started to ship kernels with this patch, as it seems that
some unnamed binary module authors are already abusing this function (as
well as some open source modules, like the openib code.)  I could not
find any valid reason why this symbol should be exported, so here's a
patch against 2.6.7 that removes it.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

thanks,

greg k-h


diff -Nru a/kernel/kallsyms.c b/kernel/kallsyms.c
--- a/kernel/kallsyms.c	Thu Jun 17 09:26:17 2004
+++ b/kernel/kallsyms.c	Thu Jun 17 09:26:17 2004
@@ -320,5 +320,4 @@
 }
 __initcall(kallsyms_init);
 
-EXPORT_SYMBOL(kallsyms_lookup);
 EXPORT_SYMBOL(__print_symbol);
