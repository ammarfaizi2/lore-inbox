Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbTFLGxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbTFLGwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:52:02 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23030 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264775AbTFLGud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:50:33 -0400
Date: Thu, 12 Jun 2003 12:40:31 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix sign handling bugs in 2.5 -- 5/5; aacraid
Message-ID: <20030612071029.GF1146@llm08.in.ibm.com>
References: <20030612070330.GA1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612070330.GA1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ruN -X dontdiff linux-2.5.70/drivers/scsi/aacraid/aachba.c shb-aacraid-2.5.70/drivers/scsi/aacraid/aachba.c
--- linux-2.5.70/drivers/scsi/aacraid/aachba.c	Tue May 27 06:30:39 2003
+++ shb-aacraid-2.5.70/drivers/scsi/aacraid/aachba.c	Wed Jun 11 16:43:17 2003
@@ -229,7 +229,8 @@
 int aac_get_containers(struct aac_dev *dev)
 {
 	struct fsa_scsi_hba *fsa_dev_ptr;
-	u32 index, status = 0;
+	u32 index; 
+	int status = 0;
 	struct aac_query_mount *dinfo;
 	struct aac_mount *dresp;
 	struct fib * fibptr;
