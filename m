Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWGCMPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWGCMPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWGCMPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:15:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2242 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751144AbWGCMPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:15:35 -0400
Message-ID: <44A90A62.8050202@fr.ibm.com>
Date: Mon, 03 Jul 2006 14:15:30 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/

the statistic infrastructure is required when compiling the ZFCP driver on
zSeries.

thanks,

C.

From: Cedric Le Goater <clg@fr.ibm.com>
Subject: [statistics infrastructure] exploitation zfcp fix

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Martin Peschke <mp3@de.ibm.com>

---
 drivers/scsi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: 2.6.17-mm6/drivers/scsi/Kconfig
===================================================================
--- 2.6.17-mm6.orig/drivers/scsi/Kconfig
+++ 2.6.17-mm6/drivers/scsi/Kconfig
@@ -2200,6 +2200,7 @@ config ZFCP
 	tristate "FCP host bus adapter driver for IBM eServer zSeries"
 	depends on S390 && QDIO && SCSI
 	select SCSI_FC_ATTRS
+	select STATISTICS
 	help
           If you want to access SCSI devices attached to your IBM eServer
           zSeries by means of Fibre Channel interfaces say Y.
