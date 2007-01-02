Return-Path: <linux-kernel-owner+w=401wt.eu-S964777AbXABMFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbXABMFz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbXABMFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:05:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1951 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964777AbXABMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:05:54 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: [PATCH] ppc: qe_lib of_node_get cleanup
Date: Tue, 2 Jan 2007 13:07:16 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021307.16467.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	No need for ?: as of_node_get() can handle NULL argument.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/qe_lib/qe_ic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/qe_lib/qe_ic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/qe_lib/qe_ic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/qe_lib/qe_ic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/qe_lib/qe_ic.c	2007-01-02 02:02:29.000000000 +0100
@@ -352,7 +352,7 @@ void __init qe_ic_init(struct device_nod
 		return;
 
 	memset(qe_ic, 0, sizeof(struct qe_ic));
-	qe_ic->of_node = node ? of_node_get(node) : NULL;
+	qe_ic->of_node = of_node_get(node);
 
 	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);


-- 
Regards,

	Mariusz Kozlowski
