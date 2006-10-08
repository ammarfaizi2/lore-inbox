Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWJHLv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWJHLv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWJHLv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:51:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:52909 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751095AbWJHLv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:51:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=WkuucnfVtlni+zu7foCzU33Qgcab53U6vAsTPYTij9lzEj/C5CpSbaUJnDlyQKBrV9AXhT1MHtqrX1/XvqoHEvDtMC+PGNtHiX7odMs8F1Pg46aTtUxxYregNmUdR8cTN6A/C+fyu5V+JL7KFtbFtIwnP/uheuYqTbWfUu4RG2A=
Date: Sun, 8 Oct 2006 15:51:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] md: use BUILD_BUG_ON
Message-ID: <20061008115140.GB5344@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/md/bitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bitmap.c
+++ b/drivers/md/bitmap.c
@@ -1413,7 +1413,7 @@ int bitmap_create(mddev_t *mddev)
 	int err;
 	sector_t start;
 
-	BUG_ON(sizeof(bitmap_super_t) != 256);
+	BUILD_BUG_ON(sizeof(bitmap_super_t) != 256);
 
 	if (!file && !mddev->bitmap_offset) /* bitmap disabled, nothing to do */
 		return 0;

