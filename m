Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030599AbVIPFgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbVIPFgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbVIPFgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 01:36:09 -0400
Received: from smtp05.web.de ([217.72.192.209]:49548 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S1030583AbVIPFgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 01:36:08 -0400
From: Thomas Maguin <T.Maguin@web.de>
Reply-To: T.Maguin@web.de
To: axboe@suse.de, linux-scsi@vger.kernel.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org
Subject: cxscan-user.patch
Date: Fri, 16 Sep 2005 07:36:19 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509160736.22007.T.Maguin@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please add this, which which allows normal users to make a c1-, c2- and 
cu-scan (so called cxscan) with readcd on cxscan-capable cd/dvd-writers. 


--- drivers/block/old-scsi_ioctl.c      2005-09-16 07:06:37.000000000 +0200
+++ drivers/block/scsi_ioctl.c  2005-09-13 12:06:48.000000000 +0200
@@ -167,6 +167,7 @@ static int verify_command(struct file *f
                safe_for_write(WRITE_VERIFY_12),
                safe_for_write(WRITE_16),
                safe_for_write(WRITE_LONG),
+              safe_for_write(WRITE_LONG_2),
                safe_for_write(ERASE),
                safe_for_write(GPCMD_MODE_SELECT_10),
                safe_for_write(MODE_SELECT),


Source of the new readcd.c (will go to the official release of cdrtools):
http://www-user.tu-chemnitz.de/~noe/readcd/readcd.c.tar.gz

Thomas
