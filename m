Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUAMUUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUAMUUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:20:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:16622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265127AbUAMUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:20:12 -0500
Date: Tue, 13 Jan 2004 12:21:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, digiLinux@dgii.com, acme@conectiva.com.br,
       arobinso@nyx.net, support@moxa.com.tw, christoph@lameter.com,
       pgmdsg@ibi.com, richard@sleepie.demon.co.uk, R.E.Wolff@BitWizard.nl,
       fritz@isdn4linux.de, reginak@cyclades.com, oli@bv.ro, jeff@uclinux.org,
       mleslie@lineo.ca, macro@ds2.pg.gda.pl
Subject: Re: [3/3] 2.6 broken serial drivers
Message-Id: <20040113122115.50265601.akpm@osdl.org>
In-Reply-To: <20040113174219.E7256@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
	<20040113113650.A2975@flint.arm.linux.org.uk>
	<20040113114948.B2975@flint.arm.linux.org.uk>
	<20040113171544.B7256@flint.arm.linux.org.uk>
	<20040113174219.E7256@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> --- 1.14/drivers/net/wan/pc300_tty.c	Thu Sep 11 18:40:53 2003
> +++ edited/drivers/net/wan/pc300_tty.c	Tue Jan 13 14:42:34 2004
> @@ -583,6 +583,14 @@
>  	CPC_TTY_DBG("%s: IOCTL cmd %x\n",cpc_tty->name,cmd);
>  	
>  	switch (cmd) { 
> +#error This is broken.  See comments.

Grumble.  This breaks allmodconfig.  #warning, please.


