Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWBDURN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWBDURN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWBDURN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:17:13 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:38126 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932558AbWBDURN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:17:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J3BUcgjo5WsJ/H32FwfU1E6nR/t/qmpi8FZibnbr/lDZAdvLE6FrZ/+bC5iCXt7fNid++//Yqcpn80PJj4EXwEugKEvW93Vd29n+8tf37t+moY8ewuVrwLejZJafRwsNo1mTLhso4R/X+czPCIbtXDQDX6ruQWGaNw93M2DZxWw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux List <linux-kernel@vger.kernel.org>
Subject: [PATCH][OSS][Maestro3] vfree() checks for NULL, no need to do it explicitly
Date: Sat, 4 Feb 2006 21:17:20 +0100
User-Agent: KMail/1.9
Cc: Zach Brown <zab@zabbo.net>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042117.20585.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() checks for NULL, no need to do it explicitly.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com
---

 sound/oss/maestro3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc2-git1-orig/sound/oss/maestro3.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/sound/oss/maestro3.c	2006-02-04 21:14:32.000000000 +0100
@@ -2580,10 +2580,10 @@ static int alloc_dsp_suspendmem(struct m
 
     return 0;
 }
+
 static void free_dsp_suspendmem(struct m3_card *card)
 {
-   if(card->suspend_mem)
-       vfree(card->suspend_mem);
+    vfree(card->suspend_mem);
 }
 
 #else


