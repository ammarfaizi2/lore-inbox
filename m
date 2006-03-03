Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWCCPK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWCCPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCCPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:10:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37897 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751478AbWCCPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:10:28 -0500
Date: Fri, 3 Mar 2006 16:10:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "James C. Georgas" <jgeorgas@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060303151026.GQ9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com> <20060302203245.GD9295@stusta.de> <1141335521.3582.14.camel@Rainsong.home> <20060302214423.GI9295@stusta.de> <1141361097.3582.40.camel@Rainsong.home> <20060303114642.GO9295@stusta.de> <1141397326.3582.57.camel@Rainsong.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141397326.3582.57.camel@Rainsong.home>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 09:48:46AM -0500, James C. Georgas wrote:
> On Fri, 2006-03-03 at 12:46 +0100, Adrian Bunk wrote:
> > On Thu, Mar 02, 2006 at 11:44:57PM -0500, James C. Georgas wrote:
> > > On Thu, 2006-02-03 at 22:44 +0100, Adrian Bunk wrote:
> > > 
> > > > > > 
> > > > > > We do not have to export symbols we don't want to export to modules but 
> > > > > > needed by CONFIG_UNIX.
> > > > > 
> > > > > Sorry, I must just be dense, or something.
> > > > > 
> > > > > Is not the only difference between a modular driver and a built in
> > > > > driver supposed to be the initialization and cleanup functions?
> > > > > 
> > > > > I don't see why you would have to expose any additional symbols, over
> > > > > and above the existing required symbols, to load your module.
> > > > 
> > > > Every kernel symbol a module uses must be explicitely exported with 
> > > > EXPORT_SYMBOL.
> > > 
> > > Yes, I understand that I need to export symbols to define the interface
> > > to my driver. whether its a module or compiled in. This is how other
> > > systems interact with my driver, right?
> > 
> > EXPORT_SYMBOL is only required for modules.
> > 
> > > > CONFIG_UNIX uses symbols that are neither used by any other in-kernel 
> > > > modules nor should be exported.
> > > 
> > > Are you saying that AF_UNIX has to export symbols for its own private
> > > functions in order to call them? I guess I don't understand this. Why
> > > not just call them. They're in scope within the driver code, aren't
> > > they?
> > 
> > No, this is about functions defined in other parts of the kernel.
> > 
> 
> Ok, if I understand you correctly now, there is a function defined in
> another part of the kernel, which is _called_ by AF_UNIX, and it is for
> this function that the other part of the kernel must export a symbol?
> 
> But you only need to do this so that modules can use the function,
> because if, instead, the driver is built in, then the function is
> directly in scope, and can be called explicitly?

Correct.

> James C. Georgas <jgeorgas@rogers.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

