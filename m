Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262928AbVCJSXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVCJSXB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVCJSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:22:58 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:12244 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262848AbVCJSSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:18:46 -0500
Date: Thu, 10 Mar 2005 10:18:35 -0800
From: Chris Wedgwood <cw@f00f.org>
To: linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Matt Mackall <mpm@selenic.com>
Subject: [PATCH] silence sort(..., swap) warning on ia64
Message-ID: <20050310181835.GA8348@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not tested but seems plausible :-)

===== arch/ia64/mm/extable.c 1.11 vs edited =====
--- 1.11/arch/ia64/mm/extable.c	2005-03-07 20:41:46 -08:00
+++ edited/arch/ia64/mm/extable.c	2005-03-10 10:14:55 -08:00
@@ -20,7 +20,7 @@ static int cmp_ex(const void *a, const v
 	return lip - rip;
 }
 
-static void swap_ex(void *a, void *b)
+static void swap_ex(void *a, void *b, int _unused_size)
 {
 	struct exception_table_entry *l = a, *r = b, tmp;
 	u64 delta = (u64) r - (u64) l;
