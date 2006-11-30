Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935057AbWK3KeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935057AbWK3KeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935063AbWK3KeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:34:04 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:43274 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S935057AbWK3KeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:34:03 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH] mv643xx add missing brackets
Date: Thu, 30 Nov 2006 11:33:28 +0100
User-Agent: KMail/1.9.5
Cc: mlachwani@mvista.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200611301035.37786.m.kozlowski@tuxland.pl> <20061130100731.GA6301@xyzzy.farnsworth.org>
In-Reply-To: <20061130100731.GA6301@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301133.32697.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	((1<<21))
> 
> Mariusz, please remove the extra parenthesis instead of adding
> an extra one, like:
> 	#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	(1<<21)
> and resubmit.

Sure. Here it goes. Second try:

	This patch fixes some mv643xx macros.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/linux/mv643xx.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc6-mm2-a/include/linux/mv643xx.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/linux/mv643xx.h	2006-11-30 11:30:14.000000000 +0100
@@ -724,7 +724,7 @@
 #define MV643XX_ETH_RX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2470 + (port<<10))
 #define MV643XX_ETH_TX_FIFO_URGENT_THRESHOLD_REG(port)             (0x2474 + (port<<10))
 #define MV643XX_ETH_RX_MINIMAL_FRAME_SIZE_REG(port)                (0x247c + (port<<10))
-#define MV643XX_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10)
+#define MV643XX_ETH_RX_DISCARDED_FRAMES_COUNTER(port)              (0x2484 + (port<<10))
 #define MV643XX_ETH_PORT_DEBUG_0_REG(port)                         (0x248c + (port<<10))
 #define MV643XX_ETH_PORT_DEBUG_1_REG(port)                         (0x2490 + (port<<10))
 #define MV643XX_ETH_PORT_INTERNAL_ADDR_ERROR_REG(port)             (0x2494 + (port<<10))
@@ -1135,7 +1135,7 @@ struct mv64xxx_i2c_pdata {
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_1	(1<<19)
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_2	(1<<20)
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_3	((1<<20) | (1<<19))
-#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	((1<<21)
+#define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_4	(1<<21)
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_5	((1<<21) | (1<<19))
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_6	((1<<21) | (1<<20))
 #define MV643XX_ETH_DEFAULT_RX_UDP_QUEUE_7	((1<<21) | (1<<20) | (1<<19))


-- 
Regards,

	Mariusz Kozlowski
