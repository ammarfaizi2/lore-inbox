Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752067AbWCIXpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbWCIXpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWCIXpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:45:05 -0500
Received: from simmts7.bellnexxia.net ([206.47.199.165]:64255 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1752067AbWCIXpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:45:04 -0500
Message-ID: <4410BDFB.3070401@ns.sympatico.ca>
Date: Thu, 09 Mar 2006 19:44:59 -0400
From: Kevin Winchester <kwin@ns.sympatico.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: akpm@osdl.org
CC: ak@muc.de, linux-kernel@vger.kernel.org
Subject: [PATCH -mm3] x86-64: Eliminate register_die_notifier symbol exported
 twice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


register_die_notifier is exported twice, once in traps.c and once in 
x8664_ksyms.c.  This results in a warning on build.

Signed-Off-By: Kevin Winchester <kwin@ns.sympatico.ca>

--- v2.6.16-rc5-mm3.orig/arch/x86_64/kernel/x8664_ksyms.c       
2006-03-09 19:34:11.000000000 -0400
+++ v2.6.16-rc5-mm3/arch/x86_64/kernel/x8664_ksyms.c    2006-03-09 
19:40:46.000000000 -0400
@@ -142,7 +142,6 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
 EXPORT_SYMBOL(empty_zero_page);

 EXPORT_SYMBOL(die_chain);
-EXPORT_SYMBOL(register_die_notifier);

 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_sibling_map);



