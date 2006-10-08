Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWJHVby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWJHVby (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWJHVby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:31:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751458AbWJHVbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:31:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mocAIsv7QQ6GP+CUqL22tEZQuZHaU50TbXmP5s10o1MA7ivsRKS05uB9eOqIIF47uzA73KNDCae0xyZgFWh2Xb4FS+Lk1qqEioisLP75n2cehC+w1GgGpCsxOY+VletemLbwYGgiBXR6G6JEfuCWPW+cgUx+5tfkqT4XNfkSNwc=
Date: Mon, 9 Oct 2006 01:31:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960: memmove for overlapping areas
Message-ID: <20061008213137.GA5347@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/block/DAC960.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -4379,8 +4379,8 @@ static inline void DAC960_P_To_PD_Transl
 static inline void DAC960_P_To_PD_TranslateDeviceState(void *DeviceState)
 {
   memcpy(DeviceState + 2, DeviceState + 3, 1);
-  memcpy(DeviceState + 4, DeviceState + 5, 2);
-  memcpy(DeviceState + 6, DeviceState + 8, 4);
+  memmove(DeviceState + 4, DeviceState + 5, 2);
+  memmove(DeviceState + 6, DeviceState + 8, 4);
 }
 
 static inline

