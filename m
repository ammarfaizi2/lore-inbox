Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWB0Wls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWB0Wls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWB0WlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:41:21 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45954 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932356AbWB0Wb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:28 -0500
Message-Id: <20060227223356.184981000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, adaplas@pol.net,
       tbm@cyrius.com
Subject: [patch 24/39] [PATCH] gbefb: Set default of FB_GBE_MEM to 4 MB
Content-Disposition: inline; filename=gbefb-set-default-of-fb_gbe_mem-to-4-mb.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Allocating more than 4 MB memory for the GBE (SGI O2) framebuffer completely
breakfs gbefb support at the moment.  According to comments on #mipslinux,
more than 4 MB has never worked correctly in Linux.  Therefore, the default
should be 4 MB.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.4.orig/drivers/video/Kconfig
+++ linux-2.6.15.4/drivers/video/Kconfig
@@ -520,7 +520,7 @@ config FB_GBE
 config FB_GBE_MEM
 	int "Video memory size in MB"
 	depends on FB_GBE
-	default 8
+	default 4
 	help
 	  This is the amount of memory reserved for the framebuffer,
 	  which can be any value between 1MB and 8MB.

--
