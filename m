Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWGFOrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWGFOrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGFOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:47:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14897 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030298AbWGFOrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:47:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=ZcRv0HRyWj82+ipef9GIzA9S8hWtlPvjO+dI4U2burKrMlkEiKnxLJIV5tJvx6+uIVMpb1Hq5eKa6l6lRnTIDvsnbrK4ENROtGUtIEKn4tUsx4NqxskTUotFrC3lMzIu2t713oGol4CqWopLjXiWoZCcpXjDHwHHREM8vCENoOM=
Date: Thu, 6 Jul 2006 18:47:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] aoe: cleanup i_rdev usage
Message-ID: <20060706144744.GC7514@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/aoe/aoechr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -162,7 +162,7 @@ aoechr_open(struct inode *inode, struct 
 {
 	int n, i;
 
-	n = MINOR(inode->i_rdev);
+	n = iminor(inode);
 	filp->private_data = (void *) (unsigned long) n;
 
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)

