Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVKNLXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVKNLXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKNLXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:23:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751082AbVKNLXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:23:01 -0500
Date: Mon, 14 Nov 2005 12:24:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051114112402.GT3699@suse.de>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131967167.2821.14.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14 2005, Arjan van de Ven wrote:
> On Mon, 2005-11-14 at 12:11 +0100, Jens Axboe wrote:
> > On Mon, Nov 14 2005, Arjan van de Ven wrote:
> > > On Mon, 2005-11-14 at 11:20 +0100, Pierre Ossman wrote:
> > > > Adrian Bunk wrote:
> > > > > It seems most problems with 4k stacks are already resolved.
> > > > > 
> > > > > I'd like to see this patch to always use 4k stacks in -mm now for 
> > > > > finding any remaining problems before submitting this patch for 2.6.16.
> > > > > 
> > > > > 
> > > > 
> > > > Has the block layer been remade to a serial approach? 
> > > 
> > > yes.
> > 
> > Not in mainline it hasn't.
> 
> well the patch was for -mm ;)

ok :)

> > 
> > Are there any recent benchmarks of 4kb vs 8kb stacks?
> 
> not sure; I do know that it very much helps java (many more threads
> possible) and the VM (far less order 1 allocs). In addition the 4Kb
> allocation can be satisfied with the per cpu list of free 4Kb pages,
> while obviously an order 1 cannot and has to go global.

I realize it has nice advantages in theory, just wondering if anyone has
done a performance analysis of 4kb vs 8kb stacks lately (or at all?).

> >  Is anyone shipping 4kb stack kernels?
> 
> Both Fedora and RHEL are shipping this for all 2.6 based versions (eg
> FC2 and all later, RHEL4)

Cool, that's the kind of testing coverage I was hoping for.

-- 
Jens Axboe

