Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbULWWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbULWWrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULWWqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:46:24 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7655 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261325AbULWWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:44:23 -0500
Subject: [RFC PATCH 7/10] Replace 'numnodes' with 'node_online_map' - parisc
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841855.3945.32.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:44:15 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

7/10 - Replace numnodes with node_online_map for parisc

[mcd@arrakis node_online_map]$ diffstat arch-parisc.patch
 init.c |    2 --
 1 files changed, 2 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/parisc/mm/init.c linux-2.6.10-rc3-mm1-nom.parisc/arch/parisc/mm/init.c
--- linux-2.6.10-rc3-mm1/arch/parisc/mm/init.c	2004-12-13 16:23:04.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.parisc/arch/parisc/mm/init.c	2004-12-14 11:57:17.000000000 -0800
@@ -269,8 +269,6 @@ static void __init setup_bootmem(void)
 	}
 	memset(pfnnid_map, 0xff, sizeof(pfnnid_map));
 
-	numnodes = npmem_ranges;
-
 	for (i = 0; i < npmem_ranges; i++)
 		node_set_online(i);
 #endif


