Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266441AbUGOWmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266441AbUGOWmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266442AbUGOWmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:42:39 -0400
Received: from palrel12.hp.com ([156.153.255.237]:37860 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266441AbUGOWmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:42:36 -0400
Date: Thu, 15 Jul 2004 15:42:35 -0700
To: Martin Diehl <lists@mdiehl.de>
Cc: Andi Kleen <ak@muc.de>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com, irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
Message-ID: <20040715224235.GA5164@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040715215552.GA46635@muc.de> <Pine.LNX.4.44.0407160027410.14037-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407160027410.14037-100000@notebook.home.mdiehl.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 12:32:44AM +0200, Martin Diehl wrote:
> On 15 Jul 2004, Andi Kleen wrote:
> 
> > Remove wrong ISA dependencies for IRDA drivers.
> > 
> > 
> > diff -u linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig
> > --- linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig-o	2004-07-12 06:09:05.000000000 +0200
> > +++ linux-2.6.8rc1-amd64/drivers/net/irda/Kconfig	2004-07-15 18:33:48.000000000 +0200
> > @@ -310,7 +310,7 @@
> >  
> >  config NSC_FIR
> >  	tristate "NSC PC87108/PC87338"
> > -	depends on IRDA && ISA
> > +	depends on IRDA
> 
> 
> Admittedly I haven't tried either, but I'm pretty sure this patch will 
> break building those drivers because they are calling irda_setup_dma - 
> which is CONFIG_ISA. Maybe this can be dropped but I don't see what's 
> wrong with !64BIT instead.

	irda_setup_dma was (supposedly) fixed in 2.6.8-rc1, and no
longer depend on CONFIG_ISA. Those driver are supposed to work on 64
bits.

> Martin

	Jean
