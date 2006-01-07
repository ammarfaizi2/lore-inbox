Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWAGKxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWAGKxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 05:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWAGKxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 05:53:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16146 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030404AbWAGKxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 05:53:31 -0500
Date: Sat, 7 Jan 2006 11:53:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060107105329.GG3774@stusta.de>
References: <20060106132749.GC12131@stusta.de> <20060107015143.65477920.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107015143.65477920.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:51:43AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
> >  on i386.
> 
> This spews screenfuls of crap at me.  Crap which nobody is going to fix.
> 
> Sorry, nope.

This is the usual chicken and egg problem:

Without a warning noone will fix the code.

And yes, some of the drivers affected seem to be maintained (and 
49 warnings come from OSS drivers with ALSA replacements another patch 
I sent removes from the kernel).

They might not show up in your all*config builds that set SMP=y, but the 
warnings with my patch aren't worse than the one's BROKEN_ON_SMP drivers 
are spitting.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

