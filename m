Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWH3Ww3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWH3Ww3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWH3Ww3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:52:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56501 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751166AbWH3Ww2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:52:28 -0400
Date: Wed, 30 Aug 2006 15:51:07 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH -mm] PM: add /sys/power documentation to Documentation/ABI
Message-ID: <20060830225107.GA14946@kroah.com>
References: <200608302338.06882.rjw@sisk.pl> <20060830144350.3b9bb273.akpm@osdl.org> <20060830150358.55233204.rdunlap@xenotime.net> <20060830153242.c5081692.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830153242.c5081692.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 03:32:42PM -0700, Andrew Morton wrote:
> 
> This ABI/ thing rather snuck under my radar (I saw it go past, but a lot of
> things go past).

It had a lot of review the first time around.  The second and third had
relatively little.

> It'll be good if it works, but it is going to take quite a lot of thought,
> effort and maintainer vigilance to be successful and to avoid becoming
> rotware.

I agree.

> I wonder how hard it would be to write a script which parses a diff, works
> out if it touches ABI things, complain if it doesn't alter
> Documentation/ABI/*?  Not very - it's just a matter of defining a suitable
> regexp.

That would be good to have.

> What _should_ be documented in there, anyway?
> 
> - syscalls, obviously.
> 
> - /proc?  If so, everything, or are there exceptions?
> 
> - /sys?  If so, everything, or are there exceptions?
> 
> - ioctl numbers and payloads?
> 
> - netlink messages?
> 
> - ethtool thingies?  netdev interface names?  /proc/iomem identifiers? 
>   module names?  kernel-thread comm[] contents?  The ABI is pretty fat.
> 
> scary.

Yes, our ABI is scary.  And yes, all of the above is needed to be
documented if we want to have a handle on this thing.

It is probably something that we can throw at the janitors list for the
existing stuff to get some help.

thanks,

greg k-h
