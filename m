Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130064AbRB1FjP>; Wed, 28 Feb 2001 00:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130065AbRB1Fiz>; Wed, 28 Feb 2001 00:38:55 -0500
Received: from [216.161.55.93] ([216.161.55.93]:23293 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130064AbRB1Fii>;
	Wed, 28 Feb 2001 00:38:38 -0500
Date: Tue, 27 Feb 2001 21:40:46 -0800
From: Greg KH <greg@wirex.com>
To: jt@hpl.hp.com
Cc: Dag Brattli <dag@brattli.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] patch-2.4.2-irda1 (irda-usb)
Message-ID: <20010227214046.A10265@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, jt@hpl.hp.com,
	Dag Brattli <dag@brattli.net>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010227093329.A10482@wirex.com> <200102272032.UAA74232@tepid.osl.fast.no> <20010227135810.E910@wirex.com> <20010227184109.B6898@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227184109.B6898@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Feb 27, 2001 at 06:41:09PM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 06:41:09PM -0800, Jean Tourrilhes wrote:
> 
> 	First thanks for Dag for bringing me into the conversation. I
> may add my little bit of spice, especially that I was the one pushing
> for having the driver in .../drivers/net/irda.
> 	By the way, Greg, sorry if I hurt your feeling, I don't want
> to put down any of the great work that has been done on the USB stack.

Thanks, but it didn't bother me, or hurt any of my feelings at all.  I
just wanted to point out that all of the other usb drivers (with 2
exceptions) reside in the drivers/usb directory, and I didn't know if
you knew that.

(the exceptions are the input drivers, which are part of the input core,
and the cpia video driver, which has the parallel port and the usb
driver all together in one file.)

> 	My feeling is that devices are mostly defined by their higher
> level interface, because this is what is closer to the user.
> 	If I look at a Pcmcia Ethernet card, I will tend to associate
> more with a PCI Ethernet card rather than a Pcmcia SCSI card. Both
> card have the same high level interface (TCP/IP) even if their low
> level interface is different (Pcmcia, PCI).
> 	People tend to agree with that, and that's why you have
> directories called drivers/net, drivers/scsi and driver/sound, rather
> that drivers/pci, drivers/isa, drivers/mca and drivers/pcmcia.

This argument has been discussed in the past (see the linux-usb-devel
and linux-kernel mailing list archives) but from what I remember, Linus
and others wanted them all to stay in the drivers/usb directory for now.

Personally I don't care either way, but it has been easier to do usb
core changes (such as the hotplug interface changes that I suggested for
your driver) with all of the drivers in one place, not that I can't do a
recursive grep :)

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
