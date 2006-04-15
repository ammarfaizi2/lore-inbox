Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWDOXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWDOXOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWDOXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:14:41 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:6162 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932514AbWDOXOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:14:40 -0400
Date: Sun, 16 Apr 2006 01:14:32 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix dependencies of W1_SLAVE_DS2433_CRC
Message-ID: <20060415231432.GI47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch fixes dependencies of W1_SLAVE_DS2433_CRC.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/drivers/w1/slaves/Kconfig
===================================================================
--- linux-2.6.17-rc1/drivers/w1/slaves/Kconfig.old      2006-04-15 21:55:44.000000000 +0200
+++ linux-2.6.17-rc1/drivers/w1/slaves/Kconfig  2006-04-15 21:56:37.000000000 +0200
@@ -28,7 +28,7 @@
 
 config W1_SLAVE_DS2433_CRC
 	bool "Protect DS2433 data with a CRC16"
-	depends on W1_DS2433
+	depends on W1_SLAVE_DS2433
 	select CRC16
 	help
 	  Say Y here to protect DS2433 data with a CRC16.

