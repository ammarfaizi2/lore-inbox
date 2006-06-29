Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWF2VVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWF2VVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbWF2VVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:21:40 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:48604 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932681AbWF2VVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:21:38 -0400
Message-ID: <44A444C4.5000609@f2s.com>
Date: Thu, 29 Jun 2006 22:23:16 +0100
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] show Acorn-specific block devices menu only when
 required
References: <20060629192041.GU19712@stusta.de>
In-Reply-To: <20060629192041.GU19712@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Don't show a menu that can't be entered due to lack of contents on arm
> (the options are only available on arm26).

Looks good to me.

Signed-off-by: Ian Molton <spyro@f2s.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 17 Apr 2006

--- linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig.old	2006-04-17 
16:40:13.000000000 +0200
+++ linux-2.6.17-rc1-mm2-arm/drivers/acorn/block/Kconfig	2006-04-17 
16:40:50.000000000 +0200
@@ -3,7 +3,7 @@
  #

  menu "Acorn-specific block devices"
-	depends on ARCH_ACORN
+	depends on ARCH_ARC || ARCH_A5K

  config BLK_DEV_FD1772
  	tristate "Old Archimedes floppy (1772) support"



