Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTEOH2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbTEOH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:28:53 -0400
Received: from smtp02.web.de ([217.72.192.151]:60436 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262457AbTEOH2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:28:52 -0400
Message-ID: <3EC344B0.6040308@web.de>
Date: Thu, 15 May 2003 09:41:36 +0200
From: Philipp Sadleder <philipp.sadleder@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030506 Debian/1.3-5.he-1
X-Accept-Language: de-de, en, en-us, pl
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: typo in a Config.in prevents 'make xconfig'
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, a really _small_ patch for an obvious typo still being present in 
2.4.21-rc2 (since -pre7):

--- linux-2.4.21-rc1/drivers/net/Config.in              Thu May 15 
00:58:34 2003
+++ linux-2.4.21-rc2-patched/drivers/net/Config.in      Sun Apr 13 
22:33:14 2003
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 
$CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original 
Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO 
$CONFIG_EEPRO100
       fi

Greetings,

    Philipp


