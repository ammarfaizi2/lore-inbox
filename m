Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUGQNSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUGQNSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 09:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUGQNSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 09:18:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61133 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266687AbUGQNSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 09:18:13 -0400
Date: Sat, 17 Jul 2004 15:18:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] e1000_main.c: fix inline compile errors
Message-ID: <20040717131807.GD4759@fs.tum.de>
References: <20040714210121.GN7308@fs.tum.de> <200407152326.40331.vda@port.imtp.ilyichevsk.odessa.ua> <20040715204935.GI25633@fs.tum.de> <200407160010.49701.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407160010.49701.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 12:10:49AM +0300, Denis Vlasenko wrote:
> On Thursday 15 July 2004 23:49, Adrian Bunk wrote:
> > On Thu, Jul 15, 2004 at 11:26:40PM +0300, Denis Vlasenko wrote:
> > > On Thursday 15 July 2004 22:46, Adrian Bunk wrote:
> > > > On Thu, Jul 15, 2004 at 12:13:59PM +0300, Denis Vlasenko wrote:
> > > > >...
> > > > > As you go thru them, consider removing inline keyword for
> > > > > such large functions.
> > > > >...
> > > >
> > > > I did propose this as an alternative approach in the text that
> > > > accopagnied the patch.
> > > >
> > > > My main reason for not directly proposing to remove the inlines was the
> > > > fact that all inline functions were either very small or called only
> > > > once.
> > >
> > > I think that large inlines with one callee is overoptimization
> > > and should not be done.
> >
> > Unless I'm mistaken, it's simply equivalent to putting the code of the
> > function at the place where the only call of the function currently is?
> >
> > Or is there an additional problem I miss?
> 
> Yes. New gcc do that automagically for statics.
> It'll never 'autoinline' function with multiple callers.
>...

But the way e1000_main.c is ordered, gcc can't inline such a function 
(due to -fno-unit-at-a-time, even gcc 3.4 cannot).

> vda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

