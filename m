Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUJWUSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUJWUSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJWUSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:18:30 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:62336 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261309AbUJWUSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:18:04 -0400
Date: Sat, 23 Oct 2004 22:17:56 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Subject: Why bttv depends on FW_LOADER?
Message-ID: <20041023201756.GA15560@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  what is purpose of this change in 2.6.10-rc1?  I seem to have no
problems after removing dependency on FW_LOADER, and my hardware 
definitely does not need any firmware to work.

  I also do not understand why bttv depends on I2C and selects
I2C_ALGOBIT.  Should not it depend on I2C_ALGOBIT instead, or
select both I2C and I2C_ALGOBIT.  Doing it this way seems rather
strange to me.
				Thanks,
					Petr Vandrovec


diff -Nru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig       2004-10-23 22:09:21 +02:00
+++ b/drivers/media/video/Kconfig       2004-10-23 22:09:21 +02:00
@@ -9,7 +9,7 @@

 config VIDEO_BT848
        tristate "BT848 Video For Linux"
-       depends on VIDEO_DEV && PCI && I2C && SOUND
+       depends on VIDEO_DEV && PCI && I2C && FW_LOADER
        select I2C_ALGOBIT
        ---help---
          Support for BT848 based frame grabber/overlay boards. This includes

