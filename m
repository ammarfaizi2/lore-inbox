Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWFVSbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWFVSbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWFVSbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:7818 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030355AbWFVSbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:04 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Jean-Luc Leger <jean-luc.leger@dspnet.fr.eu.org>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/14] [PATCH] W1: fix dependencies of W1_SLAVE_DS2433_CRC
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:15 -0700
Message-Id: <1151000876534-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1151000872615-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com> <11510008691087-git-send-email-greg@kroah.com> <1151000872615-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Luc Leger <jean-luc.leger@dspnet.fr.eu.org>

From: Jean-Luc Leger <jean-luc.leger@dspnet.fr.eu.org>

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch fixes dependencies of W1_SLAVE_DS2433_CRC.

Signed-off-by: Jean-Luc Leger <jean-luc.leger@dspnet.fr.eu.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/slaves/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index f9d4c91..d18d642 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -28,7 +28,7 @@ config W1_SLAVE_DS2433
 
 config W1_SLAVE_DS2433_CRC
 	bool "Protect DS2433 data with a CRC16"
-	depends on W1_DS2433
+	depends on W1_SLAVE_DS2433
 	select CRC16
 	help
 	  Say Y here to protect DS2433 data with a CRC16.
-- 
1.4.0

