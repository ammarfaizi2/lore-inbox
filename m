Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWHLRA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWHLRA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWHLRA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:00:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:37421 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964892AbWHLRAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:00:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=a+xKoPnVkWykM2cf8W1VHJhBe2iPPRJPdlKc2fplgOnerhiorxbdd+x3NUhUqtKGWAh+fPFXS77o3T07RSkic8mMFc2bZKNmiidhtobEc8sIHgPrOhC9poZEBsquwyRJDCUGfXYCb13JeuNdmDJ8Dj5ADvSmNsKKvRMZyST+DHY=
Message-ID: <44DE0968.4000703@gmail.com>
Date: Sat, 12 Aug 2006 19:01:28 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Thomas Winischhofer <thomas@winischhofer.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 2/10] drivers/video/sis/initextlfb.c Removal of
 old code
References: <44DE05FC.2090001@gmail.com>
In-Reply-To: <44DE05FC.2090001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/video/sis/initextlfb.c linux-work/drivers/video/sis/initextlfb.c
--- linux-work-clean/drivers/video/sis/initextlfb.c	2006-08-12 01:51:17.000000000 +0200
+++ linux-work/drivers/video/sis/initextlfb.c	2006-08-12 18:20:33.000000000 +0200
@@ -34,12 +34,10 @@
 #include <linux/types.h>
 #include <linux/fb.h>

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 int		sisfb_mode_rate_to_dclock(struct SiS_Private *SiS_Pr,
 			unsigned char modeno, unsigned char rateindex);
 int		sisfb_mode_rate_to_ddata(struct SiS_Private *SiS_Pr, unsigned char modeno,
 			unsigned char rateindex, struct fb_var_screeninfo *var);
-#endif
 BOOLEAN		sisfb_gettotalfrommode(struct SiS_Private *SiS_Pr, unsigned char modeno,
 			int *htotal, int *vtotal, unsigned char rateindex);

@@ -49,7 +47,6 @@ extern BOOLEAN	SiS_SearchModeID(struct S
 extern void	SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 			int xres, int yres, struct fb_var_screeninfo *var, BOOLEAN writeres);

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
 int
 sisfb_mode_rate_to_dclock(struct SiS_Private *SiS_Pr, unsigned char modeno,
 			unsigned char rateindex)
@@ -177,7 +174,6 @@ sisfb_mode_rate_to_ddata(struct SiS_Priv

     return 1;
 }
-#endif /* Linux >= 2.5 */

 BOOLEAN
 sisfb_gettotalfrommode(struct SiS_Private *SiS_Pr, unsigned char modeno, int *htotal,


