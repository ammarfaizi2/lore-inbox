Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVCEPy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVCEPy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCEPrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:47:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24069 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261900AbVCEPgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:36:43 -0500
Date: Sat, 5 Mar 2005 16:36:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050305153638.GD6373@stusta.de>
References: <20050305130416.GA6373@stusta.de> <Pine.LNX.4.44.0503051012530.20560-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503051012530.20560-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 10:19:23AM -0500, Kai Germaschewski wrote:
> On Sat, 5 Mar 2005, Adrian Bunk wrote:
> 
> > And this can break as soon as the "unused" object files contains 
> > EXPORT_SYMBOL's.
> > 
> > Is it really worth it doing it in this non-intuitive way?
> 
> I don't think it non-intuitive, it's how libraries work. However, as you 
> say, it is broken for files containing EXPORT_SYMBOL.
> 
> The obvious fix for this case is the one that akpm mentioned way earlier 
> in this thread, move parser.o into $(obj-y).
> 
> It should be rather easy to have the kernel build system warn you when you 
> compile library objects exporting symbols.

This warning sounds like a good plan (but it won't let many objects stay 
inside lib-y).

> --Kai

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

