Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWB1V0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWB1V0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWB1V0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:26:22 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:18556 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932639AbWB1V0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:26:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=An7QcChyXQrZkrvCbN+rb9UFRw9YFiIEhOROPW3WmK5v1mHJ/QAamtqZKNTSWLy0zmCWVHMSjF5z8B6Gw3nEcqVZS/FZMGAzqIMM5IZ4aInCz30JiQyh/zBYRjTOhZW8aepBde5dKa4jT0HXqRFs5XsntA8G+WK+1ht513K0GPE=
Date: Wed, 1 Mar 2006 00:26:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] synclink_gt: make ->init_error signed
Message-ID: <20060228212619.GB7793@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>

Examples of misuse are

3112 info->init_error = -1;

4440 if ((info->init_error = register_test(info)) < 0) {

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/synclink_gt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/synclink_gt.c
+++ b/drivers/char/synclink_gt.c
@@ -306,7 +306,7 @@ struct slgt_info {
 	int tx_active;
 
 	unsigned char signals;    /* serial signal states */
-	unsigned int init_error;  /* initialization error */
+	int init_error;  /* initialization error */
 
 	unsigned char *tx_buf;
 	int tx_count;

