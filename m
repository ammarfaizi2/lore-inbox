Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUDSSMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDSSMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 14:12:51 -0400
Received: from b099166.adsl.hansenet.de ([62.109.99.166]:43137 "EHLO
	aj.andaco.de") by vger.kernel.org with ESMTP id S261615AbUDSSMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 14:12:47 -0400
Date: Mon, 19 Apr 2004 20:12:38 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tg3 driver - address error in TSO firmware code
Message-ID: <20040419181238.GA5987@andaco.de>
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de> <4083F5CE.5080008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4083F5CE.5080008@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Andreas Jochens <aj@andaco.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Apr-19 11:52, Jeff Garzik wrote:
> It's still a patch for more political purposes than technical ones.

Of course you are right. However, the main purpose of posting my 
patches was _not_ to get them into the mainline kernel but 
to get feedback regarding the technical possibility of using the driver 
without the firmware. I got some private mails confirming that the 
patched driver works for different controllers without the firmware.


While looking at the tg3.c sources I found the attached problem.

Regards
Andreas Jochens

diff -urN linux-2.6.5.orig/drivers/net/tg3.c linux-2.6.5/drivers/net/tg3.c
--- linux-2.6.5.orig/drivers/net/tg3.c	2004-04-03 21:37:23.000000000 -0600
+++ linux-2.6.5/drivers/net/tg3.c	2004-04-19 12:47:09.254148712 -0500
@@ -3842,7 +3842,7 @@
 #define TG3_TSO_FW_START_ADDR		0x08000000
 #define TG3_TSO_FW_TEXT_ADDR		0x08000000
 #define TG3_TSO_FW_TEXT_LEN		0x1a90
-#define TG3_TSO_FW_RODATA_ADDR		0x08001a900
+#define TG3_TSO_FW_RODATA_ADDR		0x08001a90
 #define TG3_TSO_FW_RODATA_LEN		0x60
 #define TG3_TSO_FW_DATA_ADDR		0x08001b20
 #define TG3_TSO_FW_DATA_LEN		0x20


