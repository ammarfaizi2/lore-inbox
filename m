Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVH2PeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVH2PeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVH2PeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:34:25 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:6880 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750972AbVH2PeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:34:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=ZPBr+pAdH2gGdxfnlCO8APMSbqwZckGhm1YPS+n8U/PAjPp4y9MarEnjdfln9BMoR3kJVSob5QlLX7luBdlP8P70vzy6l9gIw+uW3I+vdPjrIPGnP+3/+XVbw8OmcXrvYt3gMXiB5CiQqY0uCzcU9FDqNNRdJSUu7cq3OCVuDls=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove EXPORT_SYMBOL(strtok) from frv_ksyms.c
Date: Mon, 29 Aug 2005 17:35:21 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508291735.21880.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I hessitated a bit before sending this patch to you since it is untested.
This is due to the fact that I don't have the hardware, nor a suitable 
cross compiler to do so. I sent the patch to LKML a few days ago in the 
hope that someone else could test/validate this change for me, but 
unfortunately I got no replies. That left me with the option of just 
forgetting about the patch or send it on to you.
Although the patch has not been tested I have a hard time imagining that 
it could be anything but correct since strtok() was removed from the kernel
back in 2002.



Remove export of strtok().
strtok() has not been available in the kernel since 2002. 

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/frv/kernel/frv_ksyms.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.13-rc6-mm2-orig/arch/frv/kernel/frv_ksyms.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2/arch/frv/kernel/frv_ksyms.c	2005-08-24 18:58:14.000000000 +0200
@@ -71,7 +71,6 @@ EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strtok);
 
 EXPORT_SYMBOL(get_wchan);
 
