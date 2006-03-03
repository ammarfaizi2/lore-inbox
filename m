Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWCCFYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWCCFYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 00:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWCCFYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 00:24:44 -0500
Received: from ozlabs.org ([203.10.76.45]:63408 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750844AbWCCFYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 00:24:43 -0500
Date: Fri, 3 Mar 2006 16:24:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: powerpc: Fix pud_ERROR() message
Message-ID: <20060303052406.GK23766@localhost.localdomain>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulus, please apply

The powerpc pud_ERROR() function misleadingly prints a message
indicating a pmd error.  This patch fixes.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/include/asm-powerpc/pgtable-4k.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-4k.h	2006-03-03 16:21:31.000000000 +1100
+++ working-2.6/include/asm-powerpc/pgtable-4k.h	2006-03-03 16:21:53.000000000 +1100
@@ -93,4 +93,4 @@
     (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 
 #define pud_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pud_val(e))
+	printk("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
