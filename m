Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFKNqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 09:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTFKNqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 09:46:33 -0400
Received: from oe-mp1pub.managedmail.com ([206.46.164.22]:60313 "EHLO
	oe-mp1.bizmailsrvcs.net") by vger.kernel.org with ESMTP
	id S261323AbTFKNpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 09:45:35 -0400
Message-ID: <11e901c33021$9a8928c0$6301a8c0@DLETHE>
From: "David A. Lethe" <david@santools.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
Subject: Patch to scsi_scan.c to look for LUNs on XYRATEX RAID subsystems
Date: Wed, 11 Jun 2003 08:58:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To all:

This contains a patch that must be made to the scsi_scan.c file which
instructs the O/S to scan
for LUNS on XYRATEX family RAID subsystems.

I created the patch against the 2.4.20 kernel, but all things considered, I
would like to get this single
line of new text added to all 2.4 kernels, and all future kernels.

Note that I only tested against the "RS" string. This is by design, as we
have 12 different productID strings
depending on the RAID engine and enclosure model. Just testing against RS
will work for us as well as save
valuable CPU cycles and kernel space for all.

Any questions, comments, concerns should be addressed to me,
david_lethe@us.xyratex.com
or david@santools.com

Phone number: 972-618-2265

P.S. Acknowledgement that this have been incorporated will be appreciated.



========================================================
--- linux-2.4/drivers/scsi/scsi_scan.c  2003-05-29 05:41:09.000000000 -0500
+++ linux/drivers/scsi/scsi_scan.c      2003-06-11 08:00:50.000000000 -0500
@@ -194,6 +194,7 @@
        {"SGI", "TP9400", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
        {"SGI", "TP9500", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
        {"MYLEX", "DACARMRB", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
+       {"XYRATEX", "RS", "*", BLIST_SPARSELUN | BLIST_LARGELUN},

        /*
         * Must be at end of list...

