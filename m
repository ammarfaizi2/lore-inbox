Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751904AbWHNHA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbWHNHA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWHNHA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:00:59 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:16697 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751904AbWHNHA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:00:58 -0400
Date: Mon, 14 Aug 2006 09:00:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: [patch -mm] s390: remove HIGHMEM dependencies
Message-ID: <20060814070054.GB9592@osiris.boeblingen.de.ibm.com>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 doesn't support CONFIG_HIGHMEM. Anything that depends on it would be
dead code.

Cc: Christoph Lameter <clameter@engr.sgi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Probably should be merged with
reduce-max_nr_zones-remove-display-of-counters-for-unconfigured-zones-s390-fix.patch

 arch/s390/appldata/appldata_mem.c |    3 ---
 1 files changed, 3 deletions(-)

Index: linux-2.6.18-rc4-mm1/arch/s390/appldata/appldata_mem.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/arch/s390/appldata/appldata_mem.c	2006-08-14 08:35:16.000000000 +0200
+++ linux-2.6.18-rc4-mm1/arch/s390/appldata/appldata_mem.c	2006-08-14 08:36:18.000000000 +0200
@@ -118,9 +118,6 @@
 	mem_data->pswpin     = ev[PSWPIN];
 	mem_data->pswpout    = ev[PSWPOUT];
 	mem_data->pgalloc    = ev[PGALLOC_NORMAL] + ev[PGALLOC_DMA];
-#ifdef CONFIG_HIGHMEM
-	mem_data->pgalloc    += ev[PGALLOC_HIGH];
-#endif
 	mem_data->pgfault    = ev[PGFAULT];
 	mem_data->pgmajfault = ev[PGMAJFAULT];
 
