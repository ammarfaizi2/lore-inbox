Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVLMTxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVLMTxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLMTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:53:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17682 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932601AbVLMTxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:53:21 -0500
Date: Tue, 13 Dec 2005 19:53:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051213195314.GB24094@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20051211185212.GQ23349@stusta.de> <20051211192109.GA22537@flint.arm.linux.org.uk> <20051211193118.GR23349@stusta.de> <20051211194437.GB22537@flint.arm.linux.org.uk> <20051213001028.GS23349@stusta.de> <439ECDCC.80707@hogyros.de> <20051213140001.GG23349@stusta.de> <20051213173112.GA24094@flint.arm.linux.org.uk> <Pine.LNX.4.62.0512131837380.17990@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512131837380.17990@pademelon.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 06:38:36PM +0100, Geert Uytterhoeven wrote:
> On Tue, 13 Dec 2005, Russell King wrote:
> > If, in order to have a working platform configuration, they deem that
>                          ^^^^^^^
> > CONFIG_BROKEN must be enabled, then that's the way it is.
>          ^^^^^^
> Still funny...
> 
> So either one of them is lying...

They might be broken in other situations.  However, if you look at
the latest build at:

 http://armlinux.simtec.co.uk/kautobuild/

you'll notice that all, even the ones with CONFIG_BROKEN build
successfully.  Without any bug reports to the contary, we must
assume that the configuration files supplied by the folk who
developed the support for the platform are correct and working.

Therefore, CONFIG_BROKEN may have been added to configuration
options which don't work for some particular small corner cases.

This brings on to another subject.  If we mark something broken
we should say _why_ we're doing so, especially if it is non-obvious.
That seems to be the case here - if these drivers are broken, it's
non-obvious why they're broken.

So, all in all, CONFIG_BROKEN is a broken idea in itself!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
