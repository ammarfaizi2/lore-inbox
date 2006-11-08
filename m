Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWKHWQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWKHWQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWKHWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:16:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:43578 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932075AbWKHWQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:16:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Wns2DdgOZcYPxT4LXrE75o8VeRlH+aQ9zPA/PHcpzjbneFsDVzL6eOoroTm6T1y7gJiZIfVOZca0YUdPQWuNPwfX1aK5cvj405ANjHQJlhc9SutUmaKM6Q5ZRe1IJFY5g4NWGApbmZqCQONJnbDr2morPdL4kRPP1dQVn+FONSM=
Date: Thu, 9 Nov 2006 01:16:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Achim Leubner <achim_leubner@adaptec.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] gdth: fix "&& 0xff" typos
Message-ID: <20061108221601.GD4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/gdth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3531,7 +3531,7 @@ #endif
                 IStatus &= ~0x80;
 #ifdef INT_COAL
                 if (coalesced)
-                    ha->status = pcs->ext_status && 0xffff;
+                    ha->status = pcs->ext_status & 0xffff;
                 else 
 #endif
                     ha->status = gdth_readw(&dp6m_ptr->i960r.status);
@@ -3543,7 +3543,7 @@ #ifdef INT_COAL
             if (coalesced) {    
                 ha->info = pcs->info0;
                 ha->info2 = pcs->info1;
-                ha->service = (pcs->ext_status >> 16) && 0xffff;
+                ha->service = (pcs->ext_status >> 16) & 0xffff;
             } else
 #endif
             {

