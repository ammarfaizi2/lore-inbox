Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBZNOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBZNOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 08:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVBZNOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 08:14:31 -0500
Received: from hera.cwi.nl ([192.16.191.8]:51645 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261189AbVBZNO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 08:14:29 -0500
Date: Sat, 26 Feb 2005 14:14:23 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove __initdata in scsi_devinfo.c
Message-ID: <20050226131422.GA8820@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scsi_dev_flags is referred to in
module_param_string(dev_flags, scsi_dev_flags, sizeof(scsi_dev_flags), 0);

Andries

diff -uprN -X /linux/dontdiff a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
--- a/drivers/scsi/scsi_devinfo.c	2004-12-29 03:39:47.000000000 +0100
+++ b/drivers/scsi/scsi_devinfo.c	2005-02-26 14:30:15.000000000 +0100
@@ -28,7 +28,7 @@ struct scsi_dev_info_list {
 static const char spaces[] = "                "; /* 16 of them */
 static unsigned scsi_default_dev_flags;
 static LIST_HEAD(scsi_dev_info_list);
-static __initdata char scsi_dev_flags[256];
+static char scsi_dev_flags[256];
 
 /*
  * scsi_static_device_list: deprecated list of devices that require
