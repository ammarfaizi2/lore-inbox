Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVDDWYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDDWYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVDDWYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:24:34 -0400
Received: from [202.136.32.45] ([202.136.32.45]:9186 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261444AbVDDWY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:24:27 -0400
From: Grant Coady <grant_nospam@dodo.com.au>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] PCI 1/2 update pci.ids
Date: Tue, 05 Apr 2005 08:24:12 +1000
Organization: scattered.homelinux.net
Message-ID: <sjf3519jhu5olvpui8phdchiilo7sb6ema@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Found the size of pci.ids strings (MAX_NAME_SIZE) needed increasing 
to accommodate latest pci.ids snapshot, compile failed at 140, 
succeeded at 150, so I went 160. 

This patch is required for the update to latest pci.ids snapshot 
patch 2/2.

Signed-off-by: Grant Coady <gcoady@gmail.com>


--- linux-2.4.30/drivers/pci/gen-devlist.c	2002-08-03 10:39:44.000000000 +1000
+++ linux-2.4.30c/drivers/pci/gen-devlist.c	2005-04-05 07:59:20.000000000 +1000
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <string.h>
 
-#define MAX_NAME_SIZE 79
+#define MAX_NAME_SIZE 160
 
 static void
 pq(FILE *f, const char *c)
