Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbTDIUys (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 16:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTDIUys (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 16:54:48 -0400
Received: from palrel11.hp.com ([156.153.255.246]:8928 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263820AbTDIUyr (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 16:54:47 -0400
Date: Wed, 9 Apr 2003 14:06:26 -0700
Message-Id: <200304092106.h39L6Qu0010881@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: David Mosberger <davidm@napali.hpl.hp.com>
Reply-To: davidm@hpl.hp.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.rutgers.edu
Subject: export map_vm_area()/get_vm_area()
X-Mailer: VM 7.07 under Emacs 21.2.1
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops, bad cc---fingers suffering from long-term-memory effects...]

Unless there are good reasons not to export
map_vm_area()/get_vm_area(), please accept the attached patch.  We
need the routines for AGP/DRM support on ia64.

	--david

diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Wed Apr  9 13:28:52 2003
+++ b/kernel/ksyms.c	Wed Apr  9 13:28:52 2003
@@ -109,6 +109,8 @@
 EXPORT_SYMBOL(vunmap);
 EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(remap_page_range);
+EXPORT_SYMBOL(map_vm_area);
+EXPORT_SYMBOL(get_vm_area);
 #ifndef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(contig_page_data);
 EXPORT_SYMBOL(mem_map);
