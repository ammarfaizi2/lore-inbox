Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUGCQme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUGCQme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUGCQmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 12:42:33 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16578 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265148AbUGCQmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 12:42:32 -0400
Date: Sat, 3 Jul 2004 17:41:43 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: MTRR __initdata confusion.
Message-ID: <20040703164143.GV7101@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smp_changes_mask is used by generic_set_all() which isn't __init

Signed-off-by: Dave Jones <davej@redhat.com>

		Dave


		
--- FC2/arch/i386/kernel/cpu/mtrr/generic.c~	2004-07-03 17:40:00.408094696 +0100
+++ FC2/arch/i386/kernel/cpu/mtrr/generic.c	2004-07-03 17:40:05.666295328 +0100
@@ -18,7 +18,7 @@
 	mtrr_type def_type;
 };
 
-static unsigned long smp_changes_mask __initdata = 0;
+static unsigned long smp_changes_mask = 0;
 struct mtrr_state mtrr_state = {};
 
 
