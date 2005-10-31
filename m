Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVJaSLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVJaSLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVJaSLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:11:49 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:11786 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932528AbVJaSLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:11:48 -0500
Date: Mon, 31 Oct 2005 19:11:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] i2c: writing-client doc update complement
Message-Id: <20051031191133.24ee03f7.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please apply the following patch to your git tree? Thanks.

* * * * *

My latest update to the writing-clients i2c documentation file was
incomplete, here's the complement.

Large parts of this file are still way out-of-date, but at least now
the memory allocation and freeing instructions are consistent.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---

 Documentation/i2c/writing-clients |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-git.orig/Documentation/i2c/writing-clients	2005-10-31 18:44:21.000000000 +0100
+++ linux-2.6.14-git/Documentation/i2c/writing-clients	2005-10-31 19:07:22.000000000 +0100
@@ -412,7 +412,7 @@
         release_region(address,FOO_EXTENT);
     /* SENSORS ONLY END */
     ERROR1:
-      kfree(new_client);
+      kfree(data);
     ERROR0:
       return err;
   }
@@ -443,7 +443,7 @@
       release_region(client->addr,LM78_EXTENT);
     /* HYBRID SENSORS CHIP ONLY END */
 
-    kfree(data);
+    kfree(i2c_get_clientdata(client));
     return 0;
   }
 


-- 
Jean Delvare
