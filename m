Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVKOSzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVKOSzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbVKOSzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:55:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48655 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965001AbVKOSzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:55:45 -0500
Date: Tue, 15 Nov 2005 19:55:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051115185543.GI5735@stusta.de>
References: <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com> <43795575.9010904@wolfmountaingroup.com> <20051115050658.GA13660@redhat.com> <43797E05.5090107@wolfmountaingroup.com> <17273.34218.334118.264701@cse.unsw.edu.au> <4379846E.2070006@wolfmountaingroup.com> <20051115141851.18c2c276.grundig@teleline.es> <1132061045.2822.20.camel@laptopd505.fenrus.org> <dld3cs$1sh$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dld3cs$1sh$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 11:46:30AM -0500, Giridhar Pemmasani wrote:
> Arjan van de Ven wrote:
> 
> > the same as 2.4 effectively. 2.6 also has (and I wish it becomes "had"
> > soon) an option to get 6Kb effective stack space instead. This is an
> > increase of 2Kb compared to 2.4.
> 
> It has been asked couple of times before in this context and no one cared to
> answer:
> 
> Using 4k stacks may have advantages, but what compelling reasons are there
> to drop the choice of 4k/8k stacks? You can make 4k stacks default, but why
> throw away the option of 8k stacks, especially since the impact of this
> option on the kernel implementation is very little?


One important point is to get remaining problems reported:

All the known issues in e.g. xfs, dm or reiser4 should have been 
addressed.

But how many issues have never been reported because people noticed that 
disabling CONFIG_4KSTACKS fixed the problem for them and therefore 
didn't report it?

I experienced something similar with my patch to schedule OSS drivers 
with ALSA replacements for removal - when someone reported he needed an 
OSS driver for $reason I asked him for bug numbers in the ALSA bug 
tracking system - and the highest number were 4 new bugs against one 
ALSA driver.

Unconditionally enabling 4k stacks is the only way to achieve this.


And the fact that it might force people to help with the development or 
at least use open source drivers for their hardware instead of 
binary-only Windows drivers isn't exactly a disadvantage for the 
development of Linux.


> Giri

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

