Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWI1Mze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWI1Mze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 08:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbWI1Mze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 08:55:34 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:19922 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1161105AbWI1Mzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 08:55:33 -0400
Date: Thu, 28 Sep 2006 14:55:38 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Victor <andrew@sanpeople.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] at91_serial -> atmel_serial: Platform device name
Message-ID: <20060928145538.463d9060@cad-250-152.norway.atmel.com>
In-Reply-To: <11593762853931-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	<115937628584-git-send-email-hskinnemoen@atmel.com>
	<11593762852168-git-send-email-hskinnemoen@atmel.com>
	<11593762851735-git-send-email-hskinnemoen@atmel.com>
	<11593762853931-git-send-email-hskinnemoen@atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 18:58:01 +0200
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Rename the "at91_usart" platform driver "atmel_usart" and update
> platform devices accordingly.

Hmm...seems like I've been too busy testing things on ARM, because this
one breaks AVR32 ;-)

Updated patch below. No ARM- or at91_serial-related stuff is changed.

Haavard
---
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] at91_serial -> atmel_serial: Platform device name

Rename the "at91_usart" platform driver "atmel_usart" and update
platform devices accordingly.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/mach-at91rm9200/devices.c  |   10 ++++-----
 arch/avr32/mach-at32ap/at32ap7000.c |   40 ++++++++++++++++++-----------------
 drivers/serial/atmel_serial.c       |    2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-at91rm9200/devices.c b/arch/arm/mach-at91rm9200/devices.c
index 467ef6d..78d6a1a 100644
--- a/arch/arm/mach-at91rm9200/devices.c
+++ b/arch/arm/mach-at91rm9200/devices.c
@@ -564,7 +564,7 @@ static struct at91_uart_data dbgu_data =
 };
 
 static struct platform_device at91rm9200_dbgu_device = {
-	.name		= "at91_usart",
+	.name		= "atmel_usart",
 	.id		= 0,
 	.dev		= {
 				.platform_data	= &dbgu_data,
@@ -599,7 +599,7 @@ static struct at91_uart_data uart0_data 
 };
 
 static struct platform_device at91rm9200_uart0_device = {
-	.name		= "at91_usart",
+	.name		= "atmel_usart",
 	.id		= 1,
 	.dev		= {
 				.platform_data	= &uart0_data,
@@ -641,7 +641,7 @@ static struct at91_uart_data uart1_data 
 };
 
 static struct platform_device at91rm9200_uart1_device = {
-	.name		= "at91_usart",
+	.name		= "atmel_usart",
 	.id		= 2,
 	.dev		= {
 				.platform_data	= &uart1_data,
@@ -682,7 +682,7 @@ static struct at91_uart_data uart2_data 
 };
 
 static struct platform_device at91rm9200_uart2_device = {
-	.name		= "at91_usart",
+	.name		= "atmel_usart",
 	.id		= 3,
 	.dev		= {
 				.platform_data	= &uart2_data,
@@ -717,7 +717,7 @@ static struct at91_uart_data uart3_data 
 };
 
 static struct platform_device at91rm9200_uart3_device = {
-	.name		= "at91_usart",
+	.name		= "atmel_usart",
 	.id		= 4,
 	.dev		= {
 				.platform_data	= &uart3_data,
diff --git a/arch/avr32/mach-at32ap/at32ap7000.c b/arch/avr32/mach-at32ap/at32ap7000.c
index 37982b6..842e7be 100644
--- a/arch/avr32/mach-at32ap/at32ap7000.c
+++ b/arch/avr32/mach-at32ap/at32ap7000.c
@@ -523,33 +523,33 @@ void __init at32_add_system_devices(void
  *  USART
  * -------------------------------------------------------------------- */
 
-static struct resource usart0_resource[] = {
+static struct resource atmel_usart0_resource[] = {
 	PBMEM(0xffe00c00),
 	IRQ(7),
 };
-DEFINE_DEV(usart, 0);
-DEV_CLK(usart, usart0, pba, 4);
+DEFINE_DEV(atmel_usart, 0);
+DEV_CLK(usart, atmel_usart0, pba, 4);
 
-static struct resource usart1_resource[] = {
+static struct resource atmel_usart1_resource[] = {
 	PBMEM(0xffe01000),
 	IRQ(7),
 };
-DEFINE_DEV(usart, 1);
-DEV_CLK(usart, usart1, pba, 4);
+DEFINE_DEV(atmel_usart, 1);
+DEV_CLK(usart, atmel_usart1, pba, 4);
 
-static struct resource usart2_resource[] = {
+static struct resource atmel_usart2_resource[] = {
 	PBMEM(0xffe01400),
 	IRQ(8),
 };
-DEFINE_DEV(usart, 2);
-DEV_CLK(usart, usart2, pba, 5);
+DEFINE_DEV(atmel_usart, 2);
+DEV_CLK(usart, atmel_usart2, pba, 5);
 
-static struct resource usart3_resource[] = {
+static struct resource atmel_usart3_resource[] = {
 	PBMEM(0xffe01800),
 	IRQ(9),
 };
-DEFINE_DEV(usart, 3);
-DEV_CLK(usart, usart3, pba, 6);
+DEFINE_DEV(atmel_usart, 3);
+DEV_CLK(usart, atmel_usart3, pba, 6);
 
 static inline void configure_usart0_pins(void)
 {
@@ -581,19 +581,19 @@ static struct platform_device *setup_usa
 
 	switch (id) {
 	case 0:
-		pdev = &usart0_device;
+		pdev = &atmel_usart0_device;
 		configure_usart0_pins();
 		break;
 	case 1:
-		pdev = &usart1_device;
+		pdev = &atmel_usart1_device;
 		configure_usart1_pins();
 		break;
 	case 2:
-		pdev = &usart2_device;
+		pdev = &atmel_usart2_device;
 		configure_usart2_pins();
 		break;
 	case 3:
-		pdev = &usart3_device;
+		pdev = &atmel_usart3_device;
 		configure_usart3_pins();
 		break;
 	default:
@@ -813,10 +813,10 @@ struct clk *at32_clock_list[] = {
 	&pio1_mck,
 	&pio2_mck,
 	&pio3_mck,
-	&usart0_usart,
-	&usart1_usart,
-	&usart2_usart,
-	&usart3_usart,
+	&atmel_usart0_usart,
+	&atmel_usart1_usart,
+	&atmel_usart2_usart,
+	&atmel_usart3_usart,
 	&macb0_hclk,
 	&macb0_pclk,
 	&spi0_mck,
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index e33caa9..b5f9e31 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -947,7 +947,7 @@ static struct platform_driver at91_seria
 	.suspend	= at91_serial_suspend,
 	.resume		= at91_serial_resume,
 	.driver		= {
-		.name	= "at91_usart",
+		.name	= "atmel_usart",
 		.owner	= THIS_MODULE,
 	},
 };
-- 
1.4.1.1

