Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVCENEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVCENEY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 08:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVCENEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 08:04:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28691 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261251AbVCENER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 08:04:17 -0500
Date: Sat, 5 Mar 2005 14:04:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Vincent Vanackere <vincent.vanackere@gmail.com>, keenanpepper@gmail.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-ID: <20050305130416.GA6373@stusta.de>
References: <20050304202842.GH3327@stusta.de> <Pine.LNX.4.44.0503050004120.20007-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0503050004120.20007-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 12:09:29AM -0500, Kai Germaschewski wrote:
> On Fri, 4 Mar 2005, Adrian Bunk wrote:
> 
> > > [...] So ld looks into the lib .a archive, determines that none of 
> > > the symbols in that object file are needed to resolve a reference and 
> > > drops the entire .o file.
> 
> > Silly question:
> > What's the advantage of lib-y compared to obj-y?
> 
> Basically exactly what I quoted above -- unused object files don't get
> linked into the kernel image and don't take up (wasted) space. On the
> other hand, files in obj-y get linked into the kernel unconditionally.

And this can break as soon as the "unused" object files contains 
EXPORT_SYMBOL's.

Is it really worth it doing it in this non-intuitive way?
I'd prefer an explicite dependency on a variable if you want to 
compile library functions conditionally.

> --Kai

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

