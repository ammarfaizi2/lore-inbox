Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbSJDQ5V>; Fri, 4 Oct 2002 12:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJDQ5V>; Fri, 4 Oct 2002 12:57:21 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:13839 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262490AbSJDQ5T>;
	Fri, 4 Oct 2002 12:57:19 -0400
Date: Fri, 4 Oct 2002 09:59:55 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004165955.GC6978@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:33:08AM -0700, Linus Torvalds wrote:
> 
> On Thu, 3 Oct 2002, Greg KH wrote:
> > 
> > Here's some changesets that remove the pcibios_find_class(),
> > pci_find_device(), and pcibios_present() functions.  These functions
> > have been marked as obsolete since the 2.2 kernel, so it's about time
> > that we removed them.
> 
> They are still in use by a lot of drivers..

Not all that many drivers:

pcibios_find_class is used in the following files:
 	drivers/net/aironet4500_card.c
	drivers/net/wan/lmc/lmc_main.c

The lmc driver has only had 1 janitor cleanup in all of 2.5, and the
aironet4500_card driver has had only trivial changes too.  But I'll try
to fix them up, if anyone uses them, and I break them, I'm sure I'll
hear about it :)

pcibios_find_device is used in only 11 different drivers.  I'll go clean
up those instances too.

And I thought I caught all of the places that pcibios_present() was used
already, but I'll go verify that again.

> I hate to break even more drivers at this point in 2.5.x, and so quite
> frankly I'd rather just do this in early 2.7.x instead. Unless
> somebody really steps up to the plate and also fixes the drivers
> ("it's a ton of fun, and imagine all the adoration you'll get from
> teenage girls/boys/ninja turtles for doing it")

I'll clean them all up and resubmit these changes to you when finished.

thanks,

greg k-h
(who can't wait for the ninja turtles to finally start adoring him!)
