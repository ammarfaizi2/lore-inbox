Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752568AbVHGTDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbVHGTDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbVHGTDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 15:03:15 -0400
Received: from dvhart.com ([64.146.134.43]:59520 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1752568AbVHGTDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 15:03:14 -0400
Date: Sun, 07 Aug 2005 12:03:17 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] get rid of warning in aic7770.c:aic7770_config()
Message-ID: <255920000.1123441397@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of unused variable warning:

	drivers/scsi/aic7xxx/aic7770.c: In function `aic7770_config':
	drivers/scsi/aic7xxx/aic7770.c:129: warning: unused variable `l'

Not used anywhere in the function, even under ifdef. Delete.

diff -aurpN -X /home/fletch/.diff.exclude virgin/drivers/scsi/aic7xxx/aic7770.c aic_warning/drivers/scsi/aic7xxx/aic7770.c
--- virgin/drivers/scsi/aic7xxx/aic7770.c	2005-08-07 09:15:41.000000000 -0700
+++ aic_warning/drivers/scsi/aic7xxx/aic7770.c	2005-08-07 11:58:41.000000000 -0700
@@ -126,7 +126,6 @@ aic7770_find_device(uint32_t id)
 int
 aic7770_config(struct ahc_softc *ahc, struct aic7770_identity *entry, u_int io)
 {
-	u_long	l;
 	int	error;
 	int	have_seeprom;
 	u_int	hostconf;

