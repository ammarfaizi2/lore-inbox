Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWFTLuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWFTLuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFTLuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:50:20 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:40321 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030224AbWFTLuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:50:18 -0400
Message-Id: <20060620114733.957367000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Russell King <rmk+kernel@arm.linux.org.uk>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/13] SERIAL: PARPORT_SERIAL should depend on SERIAL_8250_PCI
Content-Disposition: inline; filename=serial-parport_serial-should-depend-on-serial_8250_pci.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From:	Russell King <rmk+lkml@arm.linux.org.uk>

Since parport_serial uses symbols from 8250_pci, there should
be a dependency between the configuration symbols for these
two modules.  Problem reported by Andrey Borzenkov

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/parport/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.21.orig/drivers/parport/Kconfig
+++ linux-2.6.16.21/drivers/parport/Kconfig
@@ -48,7 +48,7 @@ config PARPORT_PC
 
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250 && PARPORT_PC && PCI
+	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module

--
