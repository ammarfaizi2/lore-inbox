Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUAMVMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUAMVMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:12:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57093 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265639AbUAMVKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:10:34 -0500
Date: Tue, 13 Jan 2004 21:10:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br, arobinso@nyx.net,
       support@moxa.com.tw, christoph@lameter.com, pgmdsg@ibi.com,
       richard@sleepie.demon.co.uk, R.E.Wolff@BitWizard.nl,
       fritz@isdn4linux.de, reginak@cyclades.com, oli@bv.ro, jeff@uclinux.org,
       macro@ds2.pg.gda.pl
Subject: Re: [3/3] 2.6 broken serial drivers
Message-ID: <20040113211023.H7256@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, acme@conectiva.com.br,
	arobinso@nyx.net, support@moxa.com.tw, christoph@lameter.com,
	pgmdsg@ibi.com, richard@sleepie.demon.co.uk, R.E.Wolff@BitWizard.nl,
	fritz@isdn4linux.de, reginak@cyclades.com, oli@bv.ro,
	jeff@uclinux.org, macro@ds2.pg.gda.pl
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113174219.E7256@flint.arm.linux.org.uk> <20040113122115.50265601.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113122115.50265601.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 13, 2004 at 12:21:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 12:21:15PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > --- 1.14/drivers/net/wan/pc300_tty.c	Thu Sep 11 18:40:53 2003
> > +++ edited/drivers/net/wan/pc300_tty.c	Tue Jan 13 14:42:34 2004
> > @@ -583,6 +583,14 @@
> >  	CPC_TTY_DBG("%s: IOCTL cmd %x\n",cpc_tty->name,cmd);
> >  	
> >  	switch (cmd) { 
> > +#error This is broken.  See comments.
> 
> Grumble.  This breaks allmodconfig.  #warning, please.

Probably far better to make all these drivers depend on BROKEN unless
one of the authors speaks up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
