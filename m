Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbUDEV1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUDEVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:24:23 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:3741 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S263346AbUDEVV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:21:58 -0400
Date: Mon, 5 Apr 2004 14:21:29 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Xserve RAID LUNs against 2.4.26-pre6
Message-ID: <20040405212128.GV10983@ca-server1.us.oracle.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Apple's Xserver RAID array needs the sparse lun magic.  Here's
the whitelist entry.

Joel

--- linux-2.4.26-pre6/drivers/scsi/scsi_scan.c.orig	2004-04-01 13:57:24.000000000 -0800
+++ linux-2.4.26-pre6/drivers/scsi/scsi_scan.c	2004-04-01 13:59:33.000000000 -0800
@@ -176,6 +176,7 @@
 	{"HP", "NetRAID-4M", "*", BLIST_FORCELUN},
 	{"ADAPTEC", "AACRAID", "*", BLIST_FORCELUN},
 	{"ADAPTEC", "Adaptec 5400S", "*", BLIST_FORCELUN},
+	{"APPLE", "Xserve", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"COMPAQ", "MSA1000", "*", BLIST_SPARSELUN | BLIST_LARGELUN | BLIST_NOSTARTONADD},
 	{"COMPAQ", "MSA1000 VOLUME", "*", BLIST_SPARSELUN | BLIST_LARGELUN | BLIST_NOSTARTONADD},
 	{"COMPAQ", "HSV110", "*", BLIST_SPARSELUN | BLIST_LARGELUN | BLIST_NOSTARTONADD},
-- 

"Against stupidity the Gods themselves contend in vain."
	- Freidrich von Schiller

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
