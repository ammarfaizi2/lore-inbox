Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTJ3QZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 11:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbTJ3QZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 11:25:24 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:13270 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S262622AbTJ3QZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 11:25:19 -0500
Message-ID: <3FA13B0F.4000602@wanadoo.es>
Date: Thu, 30 Oct 2003 17:23:43 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23-pre9 fix for kbuild - hotplug_acpi
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010008070505070406000605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008070505070406000605
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Fix for a missing "y" in drivers/hotplug/Config.in

-thanks-

--------------010008070505070406000605
Content-Type: text/plain;
 name="kbuild-hotplug-acpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbuild-hotplug-acpi.diff"

--- linux/drivers/hotplug/Config.in	2003-08-27 17:26:39.000000000 +0200
+++ new/drivers/hotplug/Config.in	2003-10-23 20:10:20.000000000 +0200
@@ -11,7 +11,7 @@
 if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
    dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
 fi
-if [ "$CONFIG_ACPI_INTERPRETER" ]; then
+if [ "$CONFIG_ACPI_INTERPRETER" = "y" ]; then
    dep_tristate '  ACPI PCI Hotplug driver' CONFIG_HOTPLUG_PCI_ACPI $CONFIG_HOTPLUG_PCI
 fi
 endmenu



--------------010008070505070406000605--

