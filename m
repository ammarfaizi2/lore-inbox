Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWA0DIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWA0DIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 22:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWA0DIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 22:08:04 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:774 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1030267AbWA0DID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 22:08:03 -0500
Message-ID: <43D98EC7.9040908@snapgear.com>
Date: Fri, 27 Jan 2006 13:08:55 +1000
From: Greg Ungerer <gerg@snapgear.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch][Trivial] Fix debug statement in inftlcore.c
References: <1138218910.5767.2.camel@alice>
In-Reply-To: <1138218910.5767.2.camel@alice>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Eric Sesterhenn / snakebyte wrote:
> this fixes a copy/paste bug found by cpminer inside the
> inftlcore.c file

Looks good.


Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Greg Ungerer <gerg@snapgear.org>

--- linux-2.6.16-rc1-git4/drivers/mtd/inftlcore.c.orig	2006-01-25 
20:51:14.000000000 +0100
+++ linux-2.6.16-rc1-git4/drivers/mtd/inftlcore.c	2006-01-25 
20:51:25.000000000 +0100
@@ -132,7 +132,7 @@ static void inftl_add_mtd(struct mtd_blk
  		return;
  	}
  #ifdef PSYCHO_DEBUG
-	printk(KERN_INFO "INFTL: Found new nftl%c\n", nftl->mbd.devnum + 'a');
+	printk(KERN_INFO "INFTL: Found new inftl%c\n", inftl->mbd.devnum + 'a');
  #endif
  	return;
  }




-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
