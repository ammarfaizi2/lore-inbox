Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbTEFWwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEFWwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:52:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:14069 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262025AbTEFWwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624133603@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624132993@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1085, 2003/05/06 15:43:13-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix dependancies for CONFIG_HOTPLUG_PCI_ACPI

Thanks to Adrian Bunk <bunk@fs.tum.de> for pointing this out.


 drivers/hotplug/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Tue May  6 15:55:45 2003
+++ b/drivers/hotplug/Kconfig	Tue May  6 15:55:45 2003
@@ -61,7 +61,7 @@
 
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on ACPI && HOTPLUG_PCI
+	depends on ACPI_BUS && HOTPLUG_PCI
 	help
 	  Say Y here if you have a system that supports PCI Hotplug using
 	  ACPI.

