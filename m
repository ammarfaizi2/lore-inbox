Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314329AbSDRLuc>; Thu, 18 Apr 2002 07:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314328AbSDRLub>; Thu, 18 Apr 2002 07:50:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:38673 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S314327AbSDRLua>; Thu, 18 Apr 2002 07:50:30 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 18 Apr 2002 13:46:09 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] export vmalloc_to_page (2.4)
Message-ID: <20020418134609.A4566@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch exports the vmalloc_to_page() without _GPL.  It is taken from
the 2.5 tree, it should go into 2.4 too to keep the interface for
drivers identical in both kernel trees.

  Gerd

==============================[ cut here ]==============================
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.369.90.124 -> 1.369.90.125
#	      kernel/ksyms.c	1.72    -> 1.73   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/03	torvalds@penguin.transmeta.com	1.369.90.125
# vmalloc_to_page() should be usable for everybody (see discussion
# on kernel mailing list)
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Apr 18 13:32:11 2002
+++ b/kernel/ksyms.c	Thu Apr 18 13:32:11 2002
@@ -107,7 +107,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
-EXPORT_SYMBOL_GPL(vmalloc_to_page);
+EXPORT_SYMBOL(vmalloc_to_page);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
 EXPORT_SYMBOL(max_mapnr);
