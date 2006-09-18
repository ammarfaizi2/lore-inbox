Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWIRTPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWIRTPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWIRTPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:15:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751694AbWIRTPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:15:34 -0400
Date: Mon, 18 Sep 2006 15:15:45 -0400
From: Konrad Rzeszutek <konradr@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, alexisb@us.ibm.com
Subject: [PATCH] aic94xx: Compile problem on s390
Message-ID: <20060918191545.GA10525@krzeszut.users.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aic94xx driver in my-scsi and aic94xx James Bottomley tree does not
compile on s390. Since the driver is generic, it makes sense to fix.
The patch is quite simple:


diff -uNr linux-2.6.17.noarch.orig/include/scsi/libsas.h linux-2.6.17.noarch/include/scsi/libsas.h
--- linux-2.6.17.noarch.orig/include/scsi/libsas.h	2006-09-11 16:29:48.000000000 -0400
+++ linux-2.6.17.noarch/include/scsi/libsas.h	2006-09-11 16:34:33.000000000 -0400
@@ -32,6 +32,7 @@
 #include <scsi/sas.h>
 #include <linux/list.h>
 #include <asm/semaphore.h>
+#include <asm/scatterlist.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_transport_sas.h>
-- 
Konrad Rzeszutek 1-(978)-392-3903 or 1-(617)-693-1718
IBM on-site partner.
