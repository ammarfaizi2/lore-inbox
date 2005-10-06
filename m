Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVJFVe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVJFVe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJFVez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:34:55 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:40916 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbVJFVez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:34:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=RikSWdInSwq5zSTtiFl5Jsb28LlJvA0qK+EMaQdu95ALHLWiQh4WcrVcBImwMdss9vQ2lKAUEnfiyPFxXsm7tSc+bsJo/luLlPKrkxwyNo1+vKEmv/hgC8wCGtIEuBlDIT2apjmkKeKVmzH7kUiP8Si/jencA2F8qlpuWi0hPTY=
Date: Fri, 7 Oct 2005 01:46:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       video4linux-list@redhat.com
Subject: [PATCH] msp3400: check ->kthread correctly
Message-ID: <20051006214621.GC2370@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/video/msp3400.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- ./drivers/media/video/msp3400.c
+++ ./drivers/media/video/msp3400.c
@@ -1558,7 +1558,7 @@ static int msp_detach(struct i2c_client 
 	struct msp3400c *msp  = i2c_get_clientdata(client);
 
 	/* shutdown control thread */
-	if (msp->kthread >= 0) {
+	if (msp->kthread) {
 		msp->restart = 1;
 		kthread_stop(msp->kthread);
 	}

