Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271713AbRHQReT>; Fri, 17 Aug 2001 13:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271710AbRHQReJ>; Fri, 17 Aug 2001 13:34:09 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:33543 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S271705AbRHQReB>; Fri, 17 Aug 2001 13:34:01 -0400
Date: Fri, 17 Aug 2001 20:34:14 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Cc: Tim Moore <timothymoore@bigfoot.com>
Subject: Re: 2.2.20pre series and booting problem
Message-ID: <20010817203414.A14553@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Tim Moore <timothymoore@bigfoot.com>
In-Reply-To: <20010815172631.A17156@elektroni.ee.tut.fi> <3B7C58BB.6D67DD7A@bigfoot.com> <20010817081629.A3540@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010817081629.A3540@elektroni.ee.tut.fi>; from kaukasoi@elektroni.ee.tut.fi on Fri, Aug 17, 2001 at 08:16:29AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 08:16:29AM +0300, Petri Kaukasoina wrote:
> On Thu, Aug 16, 2001 at 04:35:23PM -0700, Tim Moore wrote:
> > Petri Kaukasoina wrote:
> > > 
> > > 2.2.20pre3 boots ok but pre5-pre9 do not:
> > > 
> > > Uncompressing Linux...
> > > 
> > > Out of memory
> > > 
> > >   -- System halted
> > > 
> 
> > make bzimage?
> 
> Yes, both zImage and bzImage gave the same error. (I should have mentioned
> that, sorry.)

I was wrong. I must have made a mistake when I tried bzImage because now it
works.

Up to 2.2.20pre3 zImage works ok. After that it doesn't work any longer, but
bzImage does.

For example this is a 2.2.19 zImage

-rw-r--r--    1 root     root       476269 Aug 11 23:32 vmlinuz-2.2.19

which reports its size like this

Memory: 47136k/49152k available (832k kernel code, 412k reserved, 728k data, 44k init)

A 2.2.20pre9 built from the same .config doesn't boot from a zImage (tells
Out of memory) but boots up ok from a bzImage. Its size is the same as above:

Memory: 47136k/49152k available (832k kernel code, 412k reserved, 728k data, 44k init)

When I leave almost everything out of .config, I get this minimal kernel:

-rw-r--r--    1 kaukasoi users      261818 Aug 17 20:01 zImage

which reports this

Memory: 47612k/49152k available (428k kernel code, 412k reserved, 668k data, 32k init)

Even then zImage tells 'Out of memory' but bzImage boots up ok. So it seems
that zImages don't work any longer.
