Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTFGPpI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTFGPpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:45:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7694 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262166AbTFGPpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:45:04 -0400
Date: Sat, 7 Jun 2003 17:58:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-ID: <20030607155826.GA20118@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
References: <20030607152434.GQ15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607152434.GQ15311@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 05:24:34PM +0200, Adrian Bunk wrote:
> I got the following compile error with !CONFIG_PROC_FS:
>   CC      drivers/net/irda/vlsi_ir.o
> drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)
> The following patch fixes it:
> 

[snip]

I prefer the following patch:
Get rid of one ifdef/endif pair.

	Sam

===== drivers/net/irda/vlsi_ir.c 1.16 vs edited =====
--- 1.16/drivers/net/irda/vlsi_ir.c	Thu Apr 24 14:17:12 2003
+++ edited/drivers/net/irda/vlsi_ir.c	Sat Jun  7 17:55:29 2003
@@ -1993,9 +1993,7 @@
 #endif
 };
 
-#ifdef CONFIG_PROC_FS
 #define PROC_DIR ("driver/" DRIVER_NAME)
-#endif
 
 static int __init vlsi_mod_init(void)
 {
