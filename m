Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTJMQQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJMQQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:16:21 -0400
Received: from imladris.surriel.com ([66.92.77.98]:14272 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261877AbTJMQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:16:12 -0400
Date: Mon, 13 Oct 2003 12:15:59 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Dave Jones <davej@redhat.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] advansys compile fixes
In-Reply-To: <20031013160940.GA10677@redhat.com>
Message-ID: <Pine.LNX.4.55L.0310131211530.27244@imladris.surriel.com>
References: <Pine.LNX.4.55L.0310131151130.27244@imladris.surriel.com>
 <20031013160940.GA10677@redhat.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Dave Jones wrote:

> Might as well lose the #else whilst we are at it.

Good point.  Fixed patch below.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1189  -> 1.1190
#	drivers/scsi/advansys.c	1.9     -> 1.10
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/13	riel@mirkwood.surriel.com	1.1190
# fix some advansys.c compile warnings
# --------------------------------------------
#
diff -Nru a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
--- a/drivers/scsi/advansys.c	Mon Oct 13 12:15:49 2003
+++ b/drivers/scsi/advansys.c	Mon Oct 13 12:15:49 2003
@@ -5551,7 +5551,7 @@
                 }
             } else {
                 ADV_CARR_T      *carrp;
-                int             req_cnt;
+                int             req_cnt=0;
                 adv_req_t       *reqp = NULL;
                 int             sg_cnt = 0;

@@ -9257,8 +9257,6 @@
         PCI_DEVFN(ASC_PCI_ID2DEV(asc_dvc->cfg->pci_slot_info),
             ASC_PCI_ID2FUNC(asc_dvc->cfg->pci_slot_info)),
         offset, byte_data);
-#else /* CONFIG_PCI */
-    return 0;
 #endif /* CONFIG_PCI */
 }

