Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWGKWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWGKWkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWGKWkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:40:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750910AbWGKWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:40:07 -0400
Date: Wed, 12 Jul 2006 00:40:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711224006.GG13938@stusta.de>
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org> <20060711173301.GA27818@infradead.org> <20060711193423.GA9685@mars.ravnborg.org> <20060711194107.GA10733@mars.ravnborg.org> <20060711134106.18f6dd2e.rdunlap@xenotime.net> <20060711213733.GB21448@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060711213733.GB21448@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 11:37:33PM +0200, Jörn Engel wrote:
> On Tue, 11 July 2006 13:41:06 -0700, Randy.Dunlap wrote:
> > On Tue, 11 Jul 2006 21:41:07 +0200 Sam Ravnborg wrote:
> > 
> > > > JÃrn Engel IIRC created a perl scrip that did this a year or two ago.
> > > > Try googling a bit.
> > > http://lkml.org/lkml/2003/10/1/74
> > 
> > That is version 2 of the script.  There are also versions 3 & 4.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=check+headers+for+complete+includes&q=t
> 
> Boy, it took me a while to remember what I did back then.  In
> principle, the script just compiles trivial c files with a single
> #include <linux/foo.h>
> inside.

Sure, but it seems quite useful for this task.

> Not too bad in principle, but there were two problems I couldn't
> solve:
> 1. One of the goals should be to make a compile faster, not slower.
> Adding further includes hardly helps.

For me, this is not a goal.

It might perhaps be a side effect, but I care about correctness, not 
about compile time.

> 2. It is practically impossible to test every possible combination of
> #ifdefs in the various headers pulled in.

It's not perfect, but it finds a subset of the problems.

There also other possible problems like stuff only used in a #define.

The perfect is the enemy of the good.

> Problem 1 would be fairly simple, as the script could be changed
> slightly to prune single #include lines from headers and see if they
> still compile.  But then there is problem 2.
> 
> One possibility to tackly problem 2 would be to create a set of config
> files to use for automatic testing.  Instead of compiling once, a
> header must get compiled with every config in the set.  Hopefully this
> set would not grow too big.
> 
> And in the end, there is just so much you can automate.  Humans have
> to think about the changes before sending patches.

i don't think the header cleanup could be completely automated.

But if automated tools help that's a good thing.

> Jörn

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

