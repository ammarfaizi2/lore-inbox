Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUBGVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUBGVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 16:36:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16083 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265886AbUBGVgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 16:36:54 -0500
Date: Sat, 7 Feb 2004 22:36:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Robert F Merrill <griever@t2n.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 won't compile (been doing this since 2.6.1-mm2 or so)
Message-ID: <20040207213646.GE7388@fs.tum.de>
References: <402558C0.5010100@t2n.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402558C0.5010100@t2n.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 04:29:36PM -0500, Robert F Merrill wrote:
> When I upgraded to 2.6.1-mm4, I did the usual thing, copied my old 
> .config from 2.6.1-mm1 and did make oldconfig.
> 
> However, when I run make, this happens:
> 
> include/asm/processor.h:68: error: `CONFIG_X86_L1_CACHE_SHIFT' 
> undeclared here (not in a function)
> include/asm/processor.h:68: error: requested alignment is not a constant
> make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> 
> 
> The only way I've found to fix this is to add a manual #define for this 
> symbol to autoconf.h
> 
> The config option IS in i386/defconfig, but for some reason doesn't get 
> put into .config
> 
> if I add it to .config manually, it gets removed when I run make (?!?).
> 
> I don't think this happens if I delete .config and make one from scratch.

It seems when you did "make oldconfig" you said "no" to all cpu options.

You should select the cpu type(s) you want to run your kernel on.

Run "make menuconfig" and select the appropriate cpu types in
  Processor type and features
    Processor support

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

