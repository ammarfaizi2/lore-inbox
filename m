Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWILBTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWILBTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 21:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWILBTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 21:19:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:49556 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965232AbWILBTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 21:19:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=oYX4Q8xdAWz0k1iFeAUQyJlwlZQZijofzJ4eoZcAUS4NsZrSN8riVe5apmc1LzcaBVbyw+36bKgX7Brr6likDsMM2b0GjXN2r20ndwyhzp3dHJYHJbneE0vQJI7e/JN4O9nphW8MAvjeexcF4gXPVuee6L3eVnPntKmWpJmAOq0=
Date: Tue, 12 Sep 2006 05:19:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] raw: return negative from raw_init()
Message-ID: <20060912011918.GC5192@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/raw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -312,7 +312,7 @@ static int __init raw_init(void)
 
 error:
 	printk(KERN_ERR "error register raw device\n");
-	return 1;
+	return -1;
 }
 
 static void __exit raw_exit(void)

