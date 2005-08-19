Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVHSNMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVHSNMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVHSNMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:12:19 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:39887 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S932646AbVHSNMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:12:18 -0400
Message-ID: <4305DAA7.406@ens-lyon.org>
Date: Fri, 19 Aug 2005 15:12:07 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Got this warning:
drivers/char/drm/drm_agpsupport.c:429:5: warning: "LINUX_VERSION_CODE"
is not defined

This test is for old 2.4 code. The attached patch simply removes it.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice

--- linux-mm/drivers/char/drm/drm_agpsupport.c.old	2005-08-19
15:07:01.000000000 +0200
+++ linux-mm/drivers/char/drm/drm_agpsupport.c	2005-08-19
15:07:14.000000000 +0200
@@ -426,13 +426,8 @@ drm_agp_head_t *drm_agp_init(drm_device_
 		return NULL;
 	}
 	head->memory = NULL;
-#if LINUX_VERSION_CODE <= 0x020408
-	head->cant_use_aperture = 0;
-	head->page_mask = ~(0xfff);
-#else
 	head->cant_use_aperture = head->agp_info.cant_use_aperture;
 	head->page_mask = head->agp_info.page_mask;
-#endif

 	return head;
 }

