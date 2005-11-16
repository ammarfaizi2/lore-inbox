Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVKPSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVKPSpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVKPSpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:45:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61455 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030416AbVKPSpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:45:08 -0500
Date: Wed, 16 Nov 2005 19:45:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Oliver Neukum <oliver@neukum.org>,
       jmerkey <jmerkey@utah-nac.org>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116184508.GP5735@stusta.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <200511161630.59588.oliver@neukum.org> <1132155482.2834.42.camel@laptopd505.fenrus.org> <200511161710.05526.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511161710.05526.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 05:10:04PM +0100, Andi Kleen wrote:
> On Wednesday 16 November 2005 16:38, Arjan van de Ven wrote:
> > On Wed, 2005-11-16 at 16:30 +0100, Oliver Neukum wrote:
> > > Am Mittwoch, 16. November 2005 15:42 schrieb jmerkey:
> > > > Map a blank ro page beneath the address range when stack memory is 
> > > > mapped is trap on page faults to the page when folks go off the end of 
> > > > th e stack.
> > > > 
> > > > Easy to find.
> > > 
> > > Provided you can easily trigger it. I don't see how that is a given.
> > 
> > the same is true for a unified 8k stack or for the 4k/4k split though.
> > Ok sure there's a 1.5Kb difference on the one side.. (but a 2Kb gain on
> > the other side)
> 
> I was always in favour of 8K process stacks + irq stacks. Works great on x86-64.

Jörn did some analysis regarding possible call paths > 3k.

Our goal is to achieve a stack usage < 3k with a safety margin of 1k.

The problem is similar no matter whether you have 4k or 8k stacks, but 
with 4k stacks you have the additional benefits of order 0 allocations 
and less memory usage.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

