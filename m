Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUABR3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbUABR3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:29:30 -0500
Received: from mail.contactel.cz ([212.65.193.3]:20121 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S265617AbUABR32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:29:28 -0500
Date: Fri, 2 Jan 2004 18:28:47 +0100
To: zydas@tiscali.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0 making modules problems
Message-ID: <20040102172847.GA3032@penguin.localdomain>
Mail-Followup-To: zydas@tiscali.co.uk, linux-kernel@vger.kernel.org
References: <3FB8EA9C000A0983@mk-cpfrontend-2.mail.uk.tiscali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB8EA9C000A0983@mk-cpfrontend-2.mail.uk.tiscali.com>
User-Agent: Mutt/1.5.4i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 04:38:39PM +0000, zydas@tiscali.co.uk wrote:
>   CC [M]  drivers/net/ne2k-pci.o
> drivers/net/ne2k-pci.c:72:1: warning: "insl" redefined
> In file included from include/asm/dma.h:12,
>                  from include/asm/scatterlist.h:5,
>                  from include/asm/pci.h:9,
>                  from include/linux/pci.h:702,
>                  from drivers/net/ne2k-pci.c:50:
> include/asm/io.h:79:1: warning: this is the location of the previous definition
> drivers/net/ne2k-pci.c:73:1: warning: "outsl" redefined
> include/asm/io.h:80:1: warning: this is the location of the previous definition

diff -urN linux-2.6/drivers/net/ne2k-pci.c linux-2.6-new/drivers/net/ne2k-pci.c
--- linux-2.6/drivers/net/ne2k-pci.c	2003-09-28 10:43:38.000000000 +0200
+++ linux-2.6-new/drivers/net/ne2k-pci.c	2004-01-01 18:33:37.000000000 +0100
@@ -69,8 +69,6 @@
 #if defined(__powerpc__)
 #define inl_le(addr)  le32_to_cpu(inl(addr))
 #define inw_le(addr)  le16_to_cpu(inw(addr))
-#define insl insl_ns
-#define outsl outsl_ns
 #endif
 
 #define PFX DRV_NAME ": "


>   CC [M]  drivers/usb/serial/whiteheat.o
> drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
> drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared (first use in this
> function)
> drivers/usb/serial/whiteheat.c:1209: (Each undeclared identifier is reported
> only once
> drivers/usb/serial/whiteheat.c:1209: for each function it appears in.)

diff -urN linux-2.6/drivers/usb/serial/whiteheat.c linux-2.6-new/drivers/usb/serial/whiteheat.c
--- linux-2.6/drivers/usb/serial/whiteheat.c	2003-09-10 16:09:42.000000000 +0200
+++ linux-2.6-new/drivers/usb/serial/whiteheat.c	2004-01-01 18:29:38.000000000 +0100
@@ -76,6 +76,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
+#include <asm/termbits.h>
 #include <linux/usb.h>
 #include <linux/serial_reg.h>
 #include <linux/serial.h>


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

