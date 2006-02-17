Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBQNWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBQNWs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWBQNWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:22:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42501 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751403AbWBQNWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:22:47 -0500
Date: Fri, 17 Feb 2006 14:22:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jes@sgi.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] show "SN Devices" menu only if CONFIG_SGI_SN
Message-ID: <20060217132245.GG4422@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures like i386, the "Multimedia Capabilities Port drivers"
menu is visible, but it can't be visited since it contains nothing
usable for CONFIG_SGI_SN=n.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc3-mm1-full/drivers/sn/Kconfig.old	2006-02-17 14:07:11.000000000 +0100
+++ linux-2.6.16-rc3-mm1-full/drivers/sn/Kconfig	2006-02-17 14:07:37.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 menu "SN Devices"
+	depends on SGI_SN
 
 config SGI_IOC4
 	tristate "SGI IOC4 Base IO support"

