Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUIPFRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUIPFRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIPFRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:17:06 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:38005 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267457AbUIPFRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:17:02 -0400
Message-ID: <9e47339104091522176fa8ffbd@mail.gmail.com>
Date: Thu, 16 Sep 2004 01:17:02 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRM regression in Linux 2.6.9-rc1-bk12
In-Reply-To: <20040916025942.GA27261@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040916025942.GA27261@samarkand.rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the problem

===== linux/drm_scatter.h 1.6 vs edited =====
--- 1.6/linux/drm_scatter.h     Sun Sep  5 21:22:06 2004
+++ edited/linux/drm_scatter.h  Thu Sep 16 01:11:13 2004
@@ -73,7 +73,7 @@
  
        DRM_DEBUG( "%s\n", __FUNCTION__ );
  
-       if (drm_core_check_feature(dev, DRIVER_SG))
+       if (!drm_core_check_feature(dev, DRIVER_SG))
                return -EINVAL;
  
        if ( dev->sg )


-- 
Jon Smirl
jonsmirl@gmail.com
