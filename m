Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVKNLyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVKNLyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVKNLyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:54:14 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:62412 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751090AbVKNLyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:54:14 -0500
Date: Mon, 14 Nov 2005 09:54:11 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH] - Fixes sparse warning in nettel driver.
Message-Id: <20051114095411.4a30d25e.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes the following sparse warning:

drivers/mtd/maps/nettel.c:482:27: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/mtd/maps/nettel.c |    2 +-
 include/linux/mtd/map.h   |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/nettel.c b/drivers/mtd/maps/nettel.c
--- a/drivers/mtd/maps/nettel.c
+++ b/drivers/mtd/maps/nettel.c
@@ -479,7 +479,7 @@ void __exit nettel_cleanup(void)
 	}
 	if (nettel_intel_map.virt) {
 		iounmap(nettel_intel_map.virt);
-		nettel_intel_map.virt = 0;
+		nettel_intel_map.virt = NULL;
 	}
 #endif
 }
diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h


-- 
Luiz Fernando N. Capitulino
