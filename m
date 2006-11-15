Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030787AbWKOSOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbWKOSOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030800AbWKOSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:14:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29470 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030787AbWKOSOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:14:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=R+wplkcQgBJ1CxlwTqtfPlpxKnlYQuf4K749upZhb8fOexf3iSXtfqDUkBtiFDlHSjjoOJhrYo0JdVRCjsOl5djnkyfyshJhnMDJM1565GV9EPh+uwNZc40VwNm3TuU29u4ubODFdi/6P7XezNmUwwtAT5/ZOt1oYvopAIsq850=
Date: Wed, 15 Nov 2006 19:14:15 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Ben Collins <bcollins@debian.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] sbp2: make 1bit bitfield unsigned
Message-ID: <20061115181415.GA26751@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A signed single-bit bitfield doesn't make much sense. Make it unsigned.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

---

 drivers/ieee1394/sbp2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ieee1394/sbp2.h b/drivers/ieee1394/sbp2.h
index abbe48e..cf416c5 100644
--- a/drivers/ieee1394/sbp2.h
+++ b/drivers/ieee1394/sbp2.h
@@ -322,7 +322,7 @@ struct scsi_id_instance_data {
 	/*
 	 * Waitqueue flag for logins, reconnects, logouts, query logins
 	 */
-	int access_complete:1;
+	unsigned int access_complete:1;
 
 	/*
 	 * Pool of command orbs, so we can have more than overlapped command per id


Luca
-- 
Quando un uomo porta dei fiori a sua moglie senza motivo, 
un motivo c'e`.
