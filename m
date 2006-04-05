Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWDEAEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWDEAEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWDEABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:48 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25794
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750958AbWDEABV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:21 -0400
Date: Tue, 4 Apr 2006 17:00:37 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       maximilian attems <maks@sternwelten.at>, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/26] isicom must select FW_LOADER
Message-ID: <20060405000037.GN27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="isicom-must-select-fw_loader.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: maximilian attems <maks@sternwelten.at>

The isicom driver uses request_firmware()
and thus needs to select FW_LOADER.

This patch was already included in Linus' tree.

Signed-off-by: maximilian attems <maks@sternwelten.at>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.1.orig/drivers/char/Kconfig
+++ linux-2.6.16.1/drivers/char/Kconfig
@@ -187,6 +187,7 @@ config MOXA_SMARTIO
 config ISI
 	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
 	depends on SERIAL_NONSTANDARD
+	select FW_LOADER
 	help
 	  This is a driver for the Multi-Tech cards which provide several
 	  serial ports.  The driver is experimental and can currently only be

--
