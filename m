Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVBOGGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVBOGGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 01:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVBOGGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 01:06:10 -0500
Received: from waste.org ([216.27.176.166]:17857 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261636AbVBOGGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 01:06:06 -0500
Date: Mon, 14 Feb 2005 22:06:01 -0800
From: Matt Mackall <mpm@selenic.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
Subject: Re: Radeon FB troubles with recent kernels
Message-ID: <20050215060601.GS15058@waste.org>
References: <20050214203902.GH15058@waste.org> <1108420723.12740.17.camel@gaston> <1108422492.12653.30.camel@gaston> <20050215002025.GQ15058@waste.org> <1108429654.12739.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108429654.12739.60.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 12:07:34PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Nope. No printk outputs from _set_par, _write_mode, or _engine_init.
> > 
> > Just to clarify: the gdm stop is done from tty1 while gdm is running
> > on tty7, so I don't think it's a matter of mode switch logic.
> 
> Ohhh, this is a known bug then. When you kill X while it's not on the
> front VT, it will crap on the engine. This has always been the case, I
> suppose that if you didn't notice it before, it 's because you are
> lucky :)

I think I noticed it in the course of testing recent fbdev and console
code changes..

> > Also, I'm still seeing the LCD blooming + hang on starting radeonfb.
> > It's something like 1 in 10 boots rather than every boot now though.
> 
> Does it actually hangs ? That's weird... looks like a chip crash. Can
> you check if that happens with radeonfb.default_dynclk=-1 on the kernel
> command line ?

Hard to say, it's rather a pain to reproduce. I can add that to my
default boot and if it shows up again, I'll let you know.

-- 
Mathematics is the supreme nostalgia of our time.
