Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVAJLZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVAJLZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVAJLZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:25:30 -0500
Received: from ozlabs.org ([203.10.76.45]:11160 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262208AbVAJLZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:25:26 -0500
Date: Mon, 10 Jan 2005 22:20:51 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Fix NUMA build
Message-ID: <20050110112051.GO14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We were missing an include of the new nodemask.h and NUMA enabled builds
broke.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/init.c~fix_bustage arch/ppc64/mm/init.c
--- foobar2/arch/ppc64/mm/init.c~fix_bustage	2005-01-10 20:53:31.346572046 +1100
+++ foobar2-anton/arch/ppc64/mm/init.c	2005-01-10 20:53:43.131521404 +1100
@@ -37,6 +37,7 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/idr.h>
+#include <linux/nodemask.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
_
