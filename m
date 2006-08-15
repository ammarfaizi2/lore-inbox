Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWHOARI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWHOARI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHOARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:17:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63309 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932103AbWHOARG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:17:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=e3yJEBJPN/QixWr0GZB0wS53WRx27BKof5+ltIGEdEklTXSGykgkyV7SRGEEw4mabvm3ZQfq5VOqTZETM2jQCCqJYpFURV5zSemVknzBs05Yb7JVnVfeyjMfZ7gA6wCosI1q0tn5IOgUVq//aq5D7F3GTWDPxrMfM65f7XAdjH8=
Date: Tue, 15 Aug 2006 04:17:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] xircom_cb: wire up errors from pci_register_driver()
Message-ID: <20060815001702.GF5175@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/net/tulip/xircom_cb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/tulip/xircom_cb.c
+++ b/drivers/net/tulip/xircom_cb.c
@@ -1264,8 +1264,7 @@ #endif
 
 static int __init xircom_init(void)
 {
-	pci_register_driver(&xircom_ops);
-	return 0;
+	return pci_register_driver(&xircom_ops);
 }
 
 static void __exit xircom_exit(void)

