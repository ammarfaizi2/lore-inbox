Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269949AbRHJQr3>; Fri, 10 Aug 2001 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269950AbRHJQrT>; Fri, 10 Aug 2001 12:47:19 -0400
Received: from quattro.sventech.com ([205.252.248.110]:12046 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S269949AbRHJQrD>; Fri, 10 Aug 2001 12:47:03 -0400
Date: Fri, 10 Aug 2001 12:47:15 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Jadon <mikej@umem.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI NVRAM Memory Card
Message-ID: <20010810124715.F1575@sventech.com>
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5> <m17kwctghx.fsf@frodo.biederman.org> <20010810114011.X3126@sventech.com> <m1snezswqb.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m1snezswqb.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Aug 10, 2001 at 10:31:08AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Johannes Erdfelt <johannes@erdfelt.com> writes:
> 
> > On Fri, Aug 10, 2001, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Mike Jadon <mikej@umem.com> writes:
> > > 
> > > > My company has released a PCI NVRAM memory card but we haven't developed a
> > Linux
> > 
> > > > 
> > > > driver for it yet.  We want the driver to be open to developers to build
> > upon.
> > 
> > > > Is there a specific path we should follow with this being our goal?  
> > > 
> > > You might want to check out the development of the mtd subsystem.
> > > http://www.linux-mtd.infradead.org/
> > > 
> > > This is probably what you want to write a driver for for your NVRAM PCI card.
> > 
> > Not really.
> > 
> > In their case, it's a bunch of standard SDRAM on a PCI card with a
> > battery backup. It's not flash.
> > 
> > A block device is all that's needed.
> 
> O.k. that make sense, NVRAM has so many meanings...  It still might
> make sense to support things like JFFS, and friends, though.  So the
> reference isn't totally wasted.  

As a block device, anything is available to be used :)

> Somehow I missed the reference to a description of what kind of
> hardware is being discussed.  I wonder if the card can do DMA.
> Without bus mastering it looks tricky to get burts over the PCI bus,
> which would intern mean the card would be relatively slow.  And for
> things like keeping a journal for your filesystem generally the faster
> the better.  Being able to get 128MB/s would be pretty cool.

It can do DMA, even scatter gather. It's 64 bit too. It's pretty nice.

JE

