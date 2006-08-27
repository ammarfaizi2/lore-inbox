Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWH0CrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWH0CrG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWH0CrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:47:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751125AbWH0CrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:47:04 -0400
Date: Sun, 27 Aug 2006 04:47:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
       i2c@lm-sensors.org
Subject: [-mm patch] struct i2c_algo_pcf_data: remove the mdelay member
Message-ID: <20060827024702.GP4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm2:
>...
> +gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
>...
>  I2C tree updates
>...

This patch also removes the only usage of the mdelay member in 
struct i2c_algo_pcf_data, but doesn't remove the struct member itself.

Is seems this patch was also intended?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm3/include/linux/i2c-algo-pcf.h.old	2006-08-27 04:01:35.000000000 +0200
+++ linux-2.6.18-rc4-mm3/include/linux/i2c-algo-pcf.h	2006-08-27 04:01:40.000000000 +0200
@@ -35,7 +35,6 @@ struct i2c_algo_pcf_data {
 
 	/* local settings */
 	int udelay;
-	int mdelay;
 	int timeout;
 };
 

