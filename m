Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSKOLwB>; Fri, 15 Nov 2002 06:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKOLwB>; Fri, 15 Nov 2002 06:52:01 -0500
Received: from holomorphy.com ([66.224.33.161]:32718 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266112AbSKOLwA>;
	Fri, 15 Nov 2002 06:52:00 -0500
Date: Fri, 15 Nov 2002 03:55:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: kernel-janitor-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: fix warning in sd.c
Message-ID: <20021115115517.GT22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a warning in sd.c

 sd.c |    1 -
 1 files changed, 1 deletion(-)

diff -urpN cleanup-2.5.47-3/drivers/scsi/sd.c cleanup-2.5.47-4/drivers/scsi/sd.c
--- cleanup-2.5.47-3/drivers/scsi/sd.c	2002-11-10 19:28:28.000000000 -0800
+++ cleanup-2.5.47-4/drivers/scsi/sd.c	2002-11-15 03:03:22.000000000 -0800
@@ -758,7 +758,6 @@ static void
 sd_spinup_disk(struct scsi_disk *sdkp, char *diskname,
 	       struct scsi_request *SRpnt, unsigned char *buffer) {
 	unsigned char cmd[10];
-	struct scsi_device *sdp = sdkp->device;
 	unsigned long spintime_value = 0;
 	int the_result, retries, spintime;
 
