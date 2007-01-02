Return-Path: <linux-kernel-owner+w=401wt.eu-S964769AbXABLvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbXABLvZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbXABLvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:51:25 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1833 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932884AbXABLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:51:24 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: mpic of_node_get cleanup
Date: Tue, 2 Jan 2007 12:52:47 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021252.47425.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	No need for ?: because of_node_get() can handle NULL argument.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/mpic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/mpic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/mpic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/mpic.c	2007-01-02 02:02:54.000000000 +0100
@@ -912,7 +912,7 @@ struct mpic * __init mpic_alloc(struct d
 	
 	memset(mpic, 0, sizeof(struct mpic));
 	mpic->name = name;
-	mpic->of_node = node ? of_node_get(node) : NULL;
+	mpic->of_node = of_node_get(node);
 
 	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 256,
 				       &mpic_host_ops,


-- 
Regards,

	Mariusz Kozlowski
