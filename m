Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161735AbWKHWLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161735AbWKHWLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161742AbWKHWLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:11:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:6502 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161735AbWKHWL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:11:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Uf0rbvIMd3aHg8CKWIrBPr6SENKhtvVRTT6397t0qL0KPJDggCRdM55/EJIqeOR0YzLsxkeJZ3hlSau5g156ESMsW3sbBRhsYFujR7ERHlKmjddS5mXU0L4PuHIXAUzf0KsW9Gx1xCAeuqXzqvoXMfbODCLLSelA+ZH9b65TrSs=
Date: Thu, 9 Nov 2006 01:11:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] amso1100: fix "&& 0xff" typo
Message-ID: <20061108221121.GC4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/infiniband/hw/amso1100/c2_rnic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/amso1100/c2_rnic.c
+++ b/drivers/infiniband/hw/amso1100/c2_rnic.c
@@ -157,8 +157,8 @@ static int c2_rnic_query(struct c2_dev *
 
 	props->fw_ver =
 		((u64)be32_to_cpu(reply->fw_ver_major) << 32) |
-		((be32_to_cpu(reply->fw_ver_minor) && 0xFFFF) << 16) |
-		(be32_to_cpu(reply->fw_ver_patch) && 0xFFFF);
+		((be32_to_cpu(reply->fw_ver_minor) & 0xFFFF) << 16) |
+		(be32_to_cpu(reply->fw_ver_patch) & 0xFFFF);
 	memcpy(&props->sys_image_guid, c2dev->netdev->dev_addr, 6);
 	props->max_mr_size         = 0xFFFFFFFF;
 	props->page_size_cap       = ~(C2_MIN_PAGESIZE-1);

