Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbTLaWDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbTLaWDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:03:34 -0500
Received: from mail.contactel.cz ([212.65.193.9]:27532 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S265230AbTLaWDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:03:33 -0500
Date: Wed, 31 Dec 2003 22:57:28 +0100
To: linux-kernel@vger.kernel.org
Cc: acme@conectiva.com.br
Subject: Re: IA32 (2.6.0 - 2003-12-29.22.30) - 5 New warnings (gcc 3.2.2)
Message-ID: <20031231215728.GA745@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, acme@conectiva.com.br
References: <200312301108.hBUB8lxF021053@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312301108.hBUB8lxF021053@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 03:08:47AM -0800, John Cherry wrote:
> drivers/net/wan/cycx_drv.c:430: warning: unsigned int format, long unsigned int arg (arg 3)

diff -urN linux-2.6/drivers/net/wan/cycx_drv.c linux-2.6-new/drivers/net/wan/cycx_drv.c
--- linux-2.6/drivers/net/wan/cycx_drv.c	2003-12-31 21:21:25.000000000 +0100
+++ linux-2.6-new/drivers/net/wan/cycx_drv.c	2003-12-31 21:21:56.000000000 +0100
@@ -425,7 +425,7 @@
 	if (cksum != cfm->checksum) {
 		printk(KERN_ERR "%s:%s: firmware corrupted!\n",
 				modname, __FUNCTION__);
-		printk(KERN_ERR " cdsize = 0x%x (expected 0x%x)\n",
+		printk(KERN_ERR " cdsize = 0x%x (expected 0x%lx)\n",
 				len - (int)sizeof(struct cycx_firmware) - 1,
 				cfm->info.codesize);
 		printk(KERN_ERR " chksum = 0x%x (expected 0x%x)\n",


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

