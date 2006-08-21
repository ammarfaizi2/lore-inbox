Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWHUStS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWHUStS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWHUStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62396 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWHUSsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:42 -0400
Date: Mon, 21 Aug 2006 11:47:09 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, bunk@stusta.de,
       maks@sternwelten.at
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Olaf Hering <olh@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/20] SERIAL: icom: select FW_LOADER
Message-ID: <20060821184709.GM21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="serial-icom-select-fw_loader.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Olaf Hering <olaf@aepfle.de>

The icom driver uses request_firmware()
and thus needs to select FW_LOADER.

Signed-off-by: maximilian attems <maks@sternwelten.at>
Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/serial/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.9.orig/drivers/serial/Kconfig
+++ linux-2.6.17.9/drivers/serial/Kconfig
@@ -803,6 +803,7 @@ config SERIAL_MPC52xx
 	tristate "Freescale MPC52xx family PSC serial support"
 	depends on PPC_MPC52xx
 	select SERIAL_CORE
+	select FW_LOADER
 	help
 	  This drivers support the MPC52xx PSC serial ports. If you would
 	  like to use them, you must answer Y or M to this option. Not that

--
