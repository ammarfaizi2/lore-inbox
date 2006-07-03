Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWGCSPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGCSPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWGCSPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:15:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:22639 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932093AbWGCSPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:15:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=a1EYp8xNCZ/ptd3n43/eTtGDURiac4sqxLP3ao9U2jkMryZUc9nezKZYOnN1PK9Y407vpS0NNGtTAd05HMoCxitfL6PTgRfwI0hkgiH8SkOoCc4xlcXTJEitOSYfway0ZoZrdJw5dlBxBzjzW0pR7SRXVf+PkzrqlFlewhrZqvc=
Date: Mon, 3 Jul 2006 22:15:01 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Irwan Djajadi <irwan.djajadi@iname.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pcf8563: remove MOD_INC_USE_COUNT, MOD_DEC_USE_COUNT
Message-ID: <20060703181501.GB7581@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Irwan Djajadi <irwan.djajadi@iname.com>

It already has .owner .

Signed-off-by: Irwan Djajadi <irwan.djajadi@iname.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/cris/arch-v32/drivers/pcf8563.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/cris/arch-v32/drivers/pcf8563.c
+++ b/arch/cris/arch-v32/drivers/pcf8563.c
@@ -324,14 +324,12 @@ #endif /* !CONFIG_ETRAX_RTC_READONLY */
 int
 pcf8563_open(struct inode *inode, struct file *filp)
 {
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 int
 pcf8563_release(struct inode *inode, struct file *filp)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 

