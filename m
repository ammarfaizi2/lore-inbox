Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUJUMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUJUMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJUMCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:02:08 -0400
Received: from gprs214-246.eurotel.cz ([160.218.214.246]:7553 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S270408AbUJUL7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:59:49 -0400
Date: Thu, 21 Oct 2004 13:59:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041021115935.GA31151@elf.ucw.cz>
References: <416FB29A.11731.1C46848@localhost> <416FEC63.2911.2A62355@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416FEC63.2911.2A62355@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > That works great on x86, but this solution was developed for PowerPC and 
> > > MIPS embedded systems development not x86 desktop systems. For those 
> > > platforms you either need a boot loader that can bring up the system into 
> > > graphics mode (possible with U-Boot) or to init the video right when the 
> > > framebuffer console driver is brought up.
> > 
> > Right there are certainly cases where you need to do stuff very
> > early. Even then you may benefit because you can keep the kernel
> > side init pretty basic and also marked "__init" so it is freed post
> > boot. 
> 
> Right. I haven't yet figured out how to mark the code as __init so it can 
> get tossed out, although if we use the VESA driver after the fact you 
> would want to keep it around in that case. But to just boot the card and 
> use say the Radeon FB driver it would be nice to toss out the code.
> 
> I should probably look into that.

On any machine trying to do suspend-to-RAM, that POST code is likely
to be needed for suspend, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
