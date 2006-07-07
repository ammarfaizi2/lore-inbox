Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWGGHrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWGGHrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWGGHrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:47:19 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:2980 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750923AbWGGHrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:47:19 -0400
Date: Fri, 7 Jul 2006 09:45:25 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <christoph@lameter.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Gerald Schaefer <geraldsc@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] vmstat: export all_vm_events()
Message-ID: <20060707074525.GA9480@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add missing EXPORT_SYMBOL for all_vm_events(). Git commit
f8891e5e1f93a128c3900f82035e8541357896a7 caused this:

  Building modules, stage 2.
  MODPOST
WARNING: "all_vm_events" [arch/s390/appldata/appldata_mem.ko] undefined!
  CC      arch/s390/appldata/appldata_mem.mod.o

Cc: Christoph Lameter <christoph@lameter.com>
Cc: Gerald Schaefer <geraldsc@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 mm/vmstat.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 73b83d6..4701768 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -81,6 +81,7 @@ void all_vm_events(unsigned long *ret)
 {
 	sum_vm_events(ret, &cpu_online_map);
 }
+EXPORT_SYMBOL(all_vm_events);
 
 #ifdef CONFIG_HOTPLUG
 /*
