Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbUDFB2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 21:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUDFB2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 21:28:15 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:4247 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S263586AbUDFB2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 21:28:11 -0400
Date: Mon, 5 Apr 2004 18:28:00 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <linus@osdl.org>
Subject: [PATCH] Xserve RAID LUNs against 2.6.5
Message-ID: <20040406012800.GX10983@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <linus@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Apple's Xserver RAID array needs the sparse lun magic.  Here's
the whitelist entry for 2.6.5.

Joel

--- linux-2.6.5/drivers/scsi/scsi_devinfo.c.orig	2004-04-01 13:56:11.000000000 -0800
+++ linux-2.6.5/drivers/scsi/scsi_devinfo.c	2004-04-01 13:54:34.000000000 -0800
@@ -117,6 +117,7 @@
 	 */
 	{"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
 	{"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
+	{"APPLE", "Xserve", NULL, BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"CANON", "IPUBJD", NULL, BLIST_SPARSELUN},
 	{"CMD", "CRA-7280", NULL, BLIST_SPARSELUN},	/* CMD RAID Controller */
 	{"CNSI", "G7324", NULL, BLIST_SPARSELUN},	/* Chaparral G7324 RAID */
-- 

"Against stupidity the Gods themselves contend in vain."
	- Freidrich von Schiller

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
