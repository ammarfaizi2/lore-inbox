Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWHUXUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWHUXUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHUXUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:20:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:62114 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751308AbWHUXUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:20:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=O+1lxXVPLC1YehIOdebCydsSmPdyOyfBxh8jmSOuBOzAi9pU3SC7tCYMbQP/PccuIzF2juuV0wjuBuxJb/f9mKiLDWdVS+91UVK8kPS7nQShfbxiOljE4rpDD/Fci7hj9TgmvKarxk40nACL4sUO4vZaCAuAVcSnMckVwQ8zkOs=
Date: Tue, 22 Aug 2006 03:20:41 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [PATCH] ks0127: wire up i2c_add_driver() return value
Message-ID: <20060821232041.GA5220@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/video/ks0127.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/video/ks0127.c
+++ b/drivers/media/video/ks0127.c
@@ -832,8 +832,7 @@ static int ks0127_detach(struct i2c_clie
 static int __devinit ks0127_init_module(void)
 {
 	init_reg_defaults();
-	i2c_add_driver(&i2c_driver_ks0127);
-	return 0;
+	return i2c_add_driver(&i2c_driver_ks0127);
 }
 
 static void __devexit ks0127_cleanup_module(void)

