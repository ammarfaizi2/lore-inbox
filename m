Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966675AbWK2KEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966675AbWK2KEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966653AbWK2KE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:04:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3081 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758817AbWK2KES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:04:18 -0500
Date: Wed, 29 Nov 2006 11:04:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/scsi_error.c should #include "scsi_transport_api.h"
Message-ID: <20061129100422.GL11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
its global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/drivers/scsi/scsi_error.c.old	2006-11-29 09:58:41.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/scsi/scsi_error.c	2006-11-29 09:58:58.000000000 +0100
@@ -36,6 +36,7 @@
 
 #include "scsi_priv.h"
 #include "scsi_logging.h"
+#include "scsi_transport_api.h"
 
 #define SENSE_TIMEOUT		(10*HZ)
 #define START_UNIT_TIMEOUT	(30*HZ)

