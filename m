Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWHZP25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWHZP25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHZP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:28:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49670 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932261AbWHZP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:28:57 -0400
Date: Sat, 26 Aug 2006 17:28:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Shem Multinymous <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
Subject: [-mm patch] fix drivers/hwmon/hdaps.c:hdaps_check_ec() function declaration
Message-ID: <20060826152855.GG4765@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm1:
>...
> +hdaps-add-explicit-hardware-configuration-functions-fix.patch
> 
>  Fix hdaps-add-explicit-hardware-configuration-functions.patch
>...

Both sparce and SVN gcc complained about this non-ANSI function 
declaration.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/drivers/hwmon/hdaps.c.old	2006-08-26 17:15:06.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/hwmon/hdaps.c	2006-08-26 17:15:17.000000000 +0200
@@ -305,7 +305,7 @@
  * Follows the clean-room spec for HDAPS; we don't know what it means.
  * Returns zero on success and negative error code on failure.  Can sleep.
  */
-static int hdaps_check_ec()
+static int hdaps_check_ec(void)
 {
 	const struct thinkpad_ec_row args =
 		{ .mask=0x0003, .val={0x17, 0x81} };

