Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVAPF1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVAPF1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVAPF1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:27:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262382AbVAPF1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:27:04 -0500
Date: Sun, 16 Jan 2005 06:26:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: ppc64 xics.c: what is smp_threads_ready exactly used for?
Message-ID: <20050116052655.GN4274@stusta.de>
References: <20050116043356.GM4274@stusta.de> <20050116051904.GP6309@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116051904.GP6309@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 04:19:04PM +1100, Anton Blanchard wrote:
>  
> Hi,

Hi Anton,

> > during a cleanup, I stumbled upon the following:
> > 
> > 
> > arch/ppc64/kernel/smp.c (in 2.6.11-rc1-mm1) says:
> > 
> >         /* XXX fix this, xics currently relies on it - Anton */
> >         smp_threads_ready = 1;
> > 
> > 
> > arch/ppc64/kernel/xics.c is the _only_ place in the whole kernel where 
> > smp_threads_ready is actually used, and this is the _only_ place where 
> > smp_threads_ready ever changes it's value on ppc64.
> 
> It turns out I was about to submit a patch to remove the ppc64 use of
> smp_threads_ready. With that patch it makes sense to kill
> smp_threads_ready completely.

I've got a patch ready to remove smp_threads_ready on all architectures.

The only part I still need ids how to replace it in xics.c, since this 
is the only read access to this variable on all architectures.

Could you send me this part for inclusion into my patch?

> Anton

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

