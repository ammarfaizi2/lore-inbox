Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267467AbUG2XYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267467AbUG2XYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUG2XYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:24:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49885 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267467AbUG2XYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:24:31 -0400
Date: Fri, 30 Jul 2004 01:24:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1: DVB: "errno" undefined
Message-ID: <20040729232427.GK23589@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040729212737.GH23589@fs.tum.de> <200407300044.13738.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407300044.13738.lists@kenneth.aafloy.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:44:13AM +0200, Kenneth Aafløy wrote:
> On Thursday 29 July 2004 23:27, you wrote:
> > I'm getting the following errors when trying to compile 2.6.8-rc2-mm1 as
> > modular as possible (using gcc 2.95):
> [snip]
> > *** Warning: "errno" [drivers/media/dvb/frontends/tda1004x.ko] undefined!
> > *** Warning: "errno" [drivers/media/dvb/frontends/sp887x.ko] undefined!
> > *** Warning: "errno" [drivers/media/dvb/frontends/alps_tdlb7.ko] undefined!
> [snip]
> 
> This is still not fixed because we (linuxtv.org) have not submitted the 
> changes necessary following this thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108344912617115&w=2
> 
> This is about firmware loading in those modules, and we are working on 
> converting those modules to i2c_kernel to take advantage of firmware_class.
> 
> Could the offending modules be marked as broken or something untill 
> linuxtv-dvb can test and submit the dvb frontend updates, which should be 
> sometime soon, but probably not in time for 2.6.8?

The removal of errno from this three drivers is currently only in -mm.

So unless someone forwards them (they were sent by Andi Kleen as gcc 3.5 
build fixes, but he apparently didn't test a modular build) to Linus 
which hopefully won't happen before the affected modules are properly 
fixed, Linus' tree isn't affected.

> Kenneth

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

