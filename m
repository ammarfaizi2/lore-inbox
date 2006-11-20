Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966279AbWKTWzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966279AbWKTWzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966538AbWKTWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:55:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966279AbWKTWzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:55:11 -0500
Date: Mon, 20 Nov 2006 17:55:01 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: remove duplicate printk
Message-ID: <20061120225501.GA20638@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We do the exact same printk about a dozen lines above
with no intermediate printk's.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/arch/i386/kernel/cpu/amd.c~	2006-11-20 17:53:17.000000000 -0500
+++ linux-2.6/arch/i386/kernel/cpu/amd.c	2006-11-20 17:53:40.000000000 -0500
@@ -104,10 +104,7 @@ static void __cpuinit init_amd(struct cp
 					f_vide();
 				rdtscl(d2);
 				d = d2-d;
-				
-				/* Knock these two lines out if it debugs out ok */
-				printk(KERN_INFO "AMD K6 stepping B detected - ");
-				/* -- cut here -- */
+
 				if (d > 20*K6_BUG_LOOP) 
 					printk("system stability may be impaired when more than 32 MB are used.\n");
 				else 
-- 
http://www.codemonkey.org.uk
