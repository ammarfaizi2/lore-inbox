Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291840AbSBTNNd>; Wed, 20 Feb 2002 08:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291835AbSBTNNX>; Wed, 20 Feb 2002 08:13:23 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:27410 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291841AbSBTNNN>; Wed, 20 Feb 2002 08:13:13 -0500
Date: Wed, 20 Feb 2002 14:13:10 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: mingo@redhat.com
Subject: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020220131310.GE8539@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following trivial patch exports the new vmalloc_to_page primitive to
the modules (following mingo's modifications to, at least, the v4l drivers).

Stelian.

===== kernel/ksyms.c 1.62 vs edited =====
--- 1.62/kernel/ksyms.c	Mon Feb 18 18:09:54 2002
+++ edited/kernel/ksyms.c	Wed Feb 20 12:08:42 2002
@@ -107,6 +107,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
+EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
 EXPORT_SYMBOL(max_mapnr);
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
