Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934376AbWKUPFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934376AbWKUPFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934381AbWKUPFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:05:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54443 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S934377AbWKUPFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:05:01 -0500
Date: Tue, 21 Nov 2006 15:04:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Vladimir <vovan888@gmail.com>
cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Siemens sx1: merge framebuffer support
In-Reply-To: <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611211503190.32103@pentafluge.infradead.org>
References: <20061118181607.GA15275@elf.ucw.cz>  <20061120190404.GD4597@atomide.com>
 <ce55079f0611202306l3cd57e48t68fe28e7e076d39a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you post the framebufer driver to the framebuffer list. We like to do 
peer review. Thank you :-)

On Tue, 21 Nov 2006, Vladimir wrote:

> 2006/11/20, Tony Lindgren <tony@atomide.com>:
> > * Pavel Machek <pavel@ucw.cz> [061118 18:16]:
> > > From: Vladimir Ananiev <vovan888@gmail.com>
> > >
> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > > one will be mixer/sound support). Support is simple / pretty minimal,
> > > but seems to work okay (and is somehow important for a cell phone :-).
> > 
> > Pushed to linux-omap. I guess you're planning to send the missing
> > Kconfig + Makefile patch for this?
> > 
> > Also, it would be better to use omap_mcbsp_xmit_word() or
> > omap_mcsbsp_spi_master_xmit_word_poll() instead of OMAP_MCBSP_WRITE as
> > it does not do any checking that it worked. The aic23 and tsc2101
> > audio in linux-omap tree in general has the same problem.
> > 
> > Regards,
> > 
> > Tony
> > 
> 
> Hmm. McBSP3 in SX1 is used in "GPIO mode". The only line used is CLKX,
> so I think OMAP_MCBSP_WRITE would be enough. Am I wrong ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
