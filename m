Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRCMRYl>; Tue, 13 Mar 2001 12:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbRCMRYb>; Tue, 13 Mar 2001 12:24:31 -0500
Received: from [216.161.55.93] ([216.161.55.93]:27132 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130733AbRCMRYR>;
	Tue, 13 Mar 2001 12:24:17 -0500
Date: Tue, 13 Mar 2001 09:28:37 -0800
From: Greg KH <greg@wirex.com>
To: Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010313092837.A805@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010313002513.A1664@bubba.toscano.org>; from pete.lkml@toscano.org on Tue, Mar 13, 2001 at 12:25:13AM -0500
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 12:25:13AM -0500, Pete Toscano wrote:
> Well, I can't speak for the consequences of noapic (I've wondered as
> much myself), but I know that there's been a problem with SMP 2.4
> kernels (even the 2.4 test kernels) and USB running on VIA chipsets for
> a while now.  I'm told by the linux-usb maintainers that it's a problem
> with the PCI IRQ routing for the VIA chipsets, but I've been unable to
> get anyone who knows about this to do anything (and I've been asking for
> a while).  Alas, since this stuff is beyond me, I just accept the fact
> that it'll probably always be broke.

Pete,

The Tyan Tiger 133 motherboard that you and I have, just will not work
in SMP mode without the noapic command line option.  Randy Dunlap and I
worked on this back and forth for a while by email, and then I drug the
machine to a Linux Advanced Topics meeting that our local LUG puts on,
and he beat on it for a few hours.

It seems that the APIC on this motherboard does not have most of the
pins connected, so that even if we could get the USB interrupt to work
properly (which we couldn't) there would be no benefit to run in APIC
mode.  I was going to run some crude benchmarks on the box with and
without APIC mode just to get an sense if we are missing anything
running in noapic mode, but I haven't gotten around to it yet.

But, Linux does seem to run just fine with USB and SMP in the noapic
mode, which is a lot better than Win2000 can say, as it doesn't even
support the VIA USB chipset on this board at all :)

Hope this helps,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
