Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756693AbWKSO1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693AbWKSO1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756694AbWKSO1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:27:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756693AbWKSO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:27:36 -0500
Date: Sun, 19 Nov 2006 15:27:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061119142735.GI31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com> <20061118000629.GW31879@stusta.de> <1163929632.31358.481.camel@laptopd505.fenrus.org> <20061119140420.GF31879@stusta.de> <1163945584.31358.516.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163945584.31358.516.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 03:13:04PM +0100, Arjan van de Ven wrote:
> On Sun, 2006-11-19 at 15:04 +0100, Adrian Bunk wrote:
> > On Sun, Nov 19, 2006 at 10:47:12AM +0100, Arjan van de Ven wrote:
> > > 
> > > > 
> > > > Oh, and if anything starts complaining "But this adds some warnings to 
> > > > my kernel build!", he should either first fix the 200 kB (sic) of 
> > > > warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> > > 
> > > we can solve this btw; we could have a
> > > 
> > > #define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED
> > >...
> > 
> > The few warnings by __deprecated are not that much of a problem.
> 
> yes they are; the current situation prevents things that are used in
> only a set of old unmaintained legacy drivers (read: ISDN) as being

ISDN at least has reachable maintainers.

There are much worse drivers in the kernel.

> marked __deprecated because they add too many warnings, while the API
> really should be marked deprecated..
> 
> think for example the entire sleep_on() family of API's (which basically
> are impossible to use race-free in 2.6)

At about 100 warnings with an allyesconfig kernel build and less than a 
handful of warnings with a normal .config .

That's not that bad, and it might result in even these legacy drivers 
getting fixed so that the API can be completely removed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

