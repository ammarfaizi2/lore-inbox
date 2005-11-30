Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbVK3QWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVK3QWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVK3QWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:22:10 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:7012 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751436AbVK3QWJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:22:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UEacQvJJimYf0icHnr8+RIRAynF8h3zNscFTTNRp+SVDbn2d6CHBQ6WwF7lVusS/u1ewIY2hDmZouSA26ZJMSNDXzcTYTyaQZgs1fNftKi1XiFql62xIpyJn/XQOVKcQYz64e/NFHD9hNa46iRHvcKuGhrJvMmSowamu9F8Ujc8=
Message-ID: <cda58cb80511300821y72f3354av@mail.gmail.com>
Date: Wed, 30 Nov 2005 17:21:35 +0100
From: Franck <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [NET] Remove ARM dependency for dm9000 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What about this patch which removes ARM dependency for dm9000 ethernet
controller driver ?

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f15f909..4af63dd 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -856,7 +856,7 @@ config SMC9194

 config DM9000
 	tristate "DM9000 support"
-	depends on ARM && NET_ETHERNET
+	depends on NET_ETHERNET
 	select CRC32
 	select MII
 	---help---

My platform based on MIPS cpu used it...

Thanks
--
               Franck
