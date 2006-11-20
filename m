Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966423AbWKTSyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966423AbWKTSyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966429AbWKTSyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:54:35 -0500
Received: from [198.186.3.68] ([198.186.3.68]:40646 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S966423AbWKTSye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:54:34 -0500
Message-ID: <4561F9EA.1020402@serpentine.com>
Date: Mon, 20 Nov 2006 10:54:34 -0800
From: "Bryan O'Sullivan" <bos@serpentine.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: rdreier@cisco.com
Cc: lkml <linux-kernel@vger.kernel.org>, randy.dunlap@oracle.com,
       openib-general@openib.org
Subject: Re: ipath uses skb functions
References: <20061119125106.0ea9541e.randy.dunlap@oracle.com>
In-Reply-To: <20061119125106.0ea9541e.randy.dunlap@oracle.com>
Content-Type: multipart/mixed;
 boundary="------------030402010401050601020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402010401050601020904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy Dunlap wrote:
> but doesn't depends on NET (Networking).

Thanks.  One-liner patch attached.  Roland, please add this to your 
for-2.6.19 or for-2.6.20 queue, as you see fit.

	<b

--------------030402010401050601020904
Content-Type: text/x-patch;
 name="ipath-config-net.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipath-config-net.patch"

IB/ipath - make Kconfig depend on CONFIG_NET

Spotted by Randy Dunlap.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 9769053d8f77 drivers/infiniband/hw/ipath/Kconfig
--- a/drivers/infiniband/hw/ipath/Kconfig	Tue Nov 14 10:07:29 2006 -0800
+++ b/drivers/infiniband/hw/ipath/Kconfig	Mon Nov 20 10:51:25 2006 -0800
@@ -1,6 +1,6 @@ config INFINIBAND_IPATH
 config INFINIBAND_IPATH
 	tristate "QLogic InfiniPath Driver"
-	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND
+	depends on (PCI_MSI || HT_IRQ) && 64BIT && INFINIBAND && NET
 	---help---
 	This is a driver for QLogic InfiniPath host channel adapters,
 	including InfiniBand verbs support.  This driver allows these

--------------030402010401050601020904--
