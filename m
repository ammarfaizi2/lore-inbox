Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHIMyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHIMyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWHIMyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:54:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:47246 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWHIMyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:54:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UO4Aqg+BboPYqsgXR732XCG9F3mj6BNauUN0HKJ19DGvPCguQAr8oGSneJnZf8XUYuE/lXYMyhBsR1eV2gOBiy1wUESFFsG3Nlqk6/P48IjAqd9gYvvOTcvqwUPBZdE1LfptsPxypCd4Wa5F5XSwfLDD4q4wYDUUyEmobDal6bs=
Message-ID: <517e86fb0608090554s7ccdbd1esc89dd6112b22e78d@mail.gmail.com>
Date: Wed, 9 Aug 2006 12:54:35 +0000
From: "alessandro salvatori" <sandr8@gmail.com>
Reply-To: sandr8@gmail.com
To: linux-kernel@vger.kernel.org
Subject: trivial hostap_config.h patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel,

I could be wrong, but I believe that given hostap's Kconfig still
prompts the user for HOSTAP_FIRMWARE, this should not be
short-circuited in hostap_config.h [or else the switch should be
removed from the Kconfig, but me and other people working on a virtual
prism device would prefer to keep that as a configuration option].

cheers
-- 
Alessandro Salvatori

--- linux-2.6.18-rc3-old/drivers/net/wireless/hostap/hostap_config.h
 2006-08-09 14:48:01.000000000 +0000
+++ linux-2.6.18-rc3/drivers/net/wireless/hostap/hostap_config.h
 2006-08-09 14:48:18.000000000 +0000
@@ -13,9 +13,6 @@
 /* Maximum number of events handler per one interrupt */
 #define PRISM2_MAX_INTERRUPT_EVENTS 20

-/* Include code for downloading firmware images into volatile RAM. */
-#define PRISM2_DOWNLOAD_SUPPORT
-
 /* Allow kernel configuration to enable download support. */
 #if !defined(PRISM2_DOWNLOAD_SUPPORT) && defined(CONFIG_HOSTAP_FIRMWARE)
 #define PRISM2_DOWNLOAD_SUPPORT
