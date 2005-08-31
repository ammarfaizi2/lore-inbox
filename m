Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVHaTnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVHaTnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVHaTnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:43:45 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:10825 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751002AbVHaTno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:content-disposition:from:to:subject:date:user-agent:cc:mime-version:message-id:content-type:content-transfer-encoding;
        b=gNaH15330Vpf1ikBxbCopVvM1rv/eaXdX0/nriPKqpNXYXjpI+gfchFRRy3yFRJEqus22BCoQv2eKYgVoXwxplk/SMFB1D9TPH+NNZTVh9eqvrL2rtcDmvwizR0uUTrcI49RPzundeQNGyKRs9lnSprJKjOHUIcGoU3dKSURJpg=
Content-Disposition: inline
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Resend: [PATCH] remove EXPORT_SYMBOL(strtok) from frv_ksyms.c
Date: Wed, 31 Aug 2005 21:44:50 +0200
User-Agent: KMail/1.8.2
Cc: David Howells <dhowells@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200508312144.51093.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Got some feedback on this one from David Howells 

> Looks okay to me.
> 
> David

so I'm resending it in the hope that you'll drop it into -mm (or NACK it 
if you don't like it) :-)


----------  Forwarded Message  ----------

Subject: [PATCH] remove EXPORT_SYMBOL(strtok) from frv_ksyms.c
Date: Monday 29 August 2005 17:35
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>

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
 


-------------------------------------------------------
