Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWDMXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWDMXKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWDMXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:00 -0400
Received: from ns1.suse.de ([195.135.220.2]:59589 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964998AbWDMXJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:42 -0400
Date: Thu, 13 Apr 2006 16:08:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/22] edac_752x needs CONFIG_HOTPLUG
Message-ID: <20060413230835.GN5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="edac_752x-needs-config_hotplug.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Randy Dunlap <rdunlap@xenotime.net>

EDAC_752X uses pci_scan_single_device(), which is only available
if CONFIG_HOTPLUG is enabled, so limit this driver with HOTPLUG.

This patch was already included in Linus' tree.

Adrian Bunk:
Rediffed for 2.6.16.x due to unrelated context changes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/edac/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.5.orig/drivers/edac/Kconfig
+++ linux-2.6.16.5/drivers/edac/Kconfig
@@ -71,7 +71,7 @@ config EDAC_E7XXX
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320)"
-	depends on EDAC_MM_EDAC && PCI
+	depends on EDAC_MM_EDAC && PCI && HOTPLUG
 	help
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.

--
