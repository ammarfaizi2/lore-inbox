Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUI3SZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUI3SZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUI3SZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:25:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:46059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269400AbUI3SWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:22:41 -0400
Date: Thu, 30 Sep 2004 11:22:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Andrey S. Klochko" <aklochko@acipower.com>
cc: Franz Pletz <franz_pletz@t-online.de>, Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
In-Reply-To: <415C4BD8.40005@acipower.com>
Message-ID: <Pine.LNX.4.58.0409301121560.2403@ppc970.osdl.org>
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info>
 <415C37D8.20203@t-online.de> <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
 <415C4BD8.40005@acipower.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Sep 2004, Andrey S. Klochko wrote:
>
> > -#define mii_delay(dev)  readl(dev->base_addr + EECtrl)
> > +#define mii_delay(dev)  readl(ioaddr + EECtrl)
>                       ^^^
> Probably this should be
> +#define mii_delay(ioaddr)  readl(ioaddr + EECtrl)

Yes. Good catch, will fix.

		Linus
