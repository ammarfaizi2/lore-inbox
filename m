Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUJaOxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUJaOxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUJaOqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:46:19 -0500
Received: from baikonur.stro.at ([213.239.196.228]:12725 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261638AbUJaOp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:45:29 -0500
Date: Sun, 31 Oct 2004 15:45:10 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 5/6] sata_promise remove duplicate msleep() definition
Message-ID: <20041031144510.GF28667@stro.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Margit Schubert-While <margitsw@t-online.de>,
	Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
	mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
	netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at> <41841886.2080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41841886.2080609@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove now duplicate define.
driver already includes delay.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.4.28-rc1-max/drivers/scsi/sata_promise.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/scsi/sata_promise.c~remove-msleep-drivers_scsi_sata_promise drivers/scsi/sata_promise.c
--- linux-2.4.28-rc1/drivers/scsi/sata_promise.c~remove-msleep-drivers_scsi_sata_promise	2004-10-31 13:59:39.000000000 +0100
+++ linux-2.4.28-rc1-max/drivers/scsi/sata_promise.c	2004-10-31 14:00:12.000000000 +0100
@@ -42,8 +42,6 @@
 #define DRV_NAME	"sata_promise"
 #define DRV_VERSION	"1.00"
 
-#define msleep libata_msleep	/* 2.4-specific */
-
 enum {
 	PDC_PKT_SUBMIT		= 0x40, /* Command packet pointer addr */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
_
