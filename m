Return-Path: <linux-kernel-owner+w=401wt.eu-S1423113AbWLUVZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423113AbWLUVZI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423114AbWLUVZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:25:08 -0500
Received: from rollcage.inittab.de ([62.146.34.202]:33010 "EHLO
	rollcage.inittab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423113AbWLUVZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:25:07 -0500
X-Greylist: delayed 1631 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 16:25:07 EST
Date: Thu, 21 Dec 2006 21:57:50 +0100
From: Norbert Tretkowski <norbert@tretkowski.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Enable Elektor ISA card on SMP
Message-ID: <20061221205750.GC2945@kyllikki.home.inittab.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Elektor ISA card works fine on SMP, the patch below removes the
BROKEN_ON_SMP dependency.

                Norbert


--- a/drivers/i2c/busses/Kconfig        2006-12-21 21:31:27.000000000 +0100
+++ b/drivers/i2c/busses/Kconfig        2006-12-21 21:32:27.000000000 +0100
@@ -86,7 +86,7 @@
 
 config I2C_ELEKTOR
        tristate "Elektor ISA card"
-       depends on I2C && ISA && BROKEN_ON_SMP
+       depends on I2C && ISA
        select I2C_ALGOPCF
        help
          This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
