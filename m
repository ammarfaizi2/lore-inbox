Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269945AbRHJQiI>; Fri, 10 Aug 2001 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269946AbRHJQh6>; Fri, 10 Aug 2001 12:37:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19818 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S269945AbRHJQhs>; Fri, 10 Aug 2001 12:37:48 -0400
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Mike Jadon <mikej@umem.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI NVRAM Memory Card
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
	<m17kwctghx.fsf@frodo.biederman.org>
	<20010810114011.X3126@sventech.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2001 10:31:08 -0600
In-Reply-To: <20010810114011.X3126@sventech.com>
Message-ID: <m1snezswqb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt <johannes@erdfelt.com> writes:

> On Fri, Aug 10, 2001, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Mike Jadon <mikej@umem.com> writes:
> > 
> > > My company has released a PCI NVRAM memory card but we haven't developed a
> Linux
> 
> > > 
> > > driver for it yet.  We want the driver to be open to developers to build
> upon.
> 
> > > Is there a specific path we should follow with this being our goal?  
> > 
> > You might want to check out the development of the mtd subsystem.
> > http://www.linux-mtd.infradead.org/
> > 
> > This is probably what you want to write a driver for for your NVRAM PCI card.
> 
> Not really.
> 
> In their case, it's a bunch of standard SDRAM on a PCI card with a
> battery backup. It's not flash.
> 
> A block device is all that's needed.

O.k. that make sense, NVRAM has so many meanings...  It still might
make sense to support things like JFFS, and friends, though.  So the
reference isn't totally wasted.  

Somehow I missed the reference to a description of what kind of
hardware is being discussed.  I wonder if the card can do DMA.
Without bus mastering it looks tricky to get burts over the PCI bus,
which would intern mean the card would be relatively slow.  And for
things like keeping a journal for your filesystem generally the faster
the better.  Being able to get 128MB/s would be pretty cool.

Eric
