Return-Path: <linux-kernel-owner+w=401wt.eu-S932883AbXABLs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbXABLs7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbXABLs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:48:58 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:2313 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932883AbXABLs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:48:58 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: ipic of_node_get cleanup
Date: Tue, 2 Jan 2007 12:50:20 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021250.20259.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	No need for ?: because of_node_get() can handle NULL argument.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>	

 arch/powerpc/sysdev/ipic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/ipic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/ipic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/ipic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/ipic.c	2007-01-02 02:03:23.000000000 +0100
@@ -569,7 +569,7 @@ void __init ipic_init(struct device_node
 		return;
 
 	memset(ipic, 0, sizeof(struct ipic));
-	ipic->of_node = node ? of_node_get(node) : NULL;
+	ipic->of_node = of_node_get(node);
 
 	ipic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 				       NR_IPIC_INTS,


-- 
Regards,

	Mariusz Kozlowski
