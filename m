Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTKMXhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 18:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264458AbTKMXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 18:37:18 -0500
Received: from smtp.uol.com.br ([200.221.11.52]:61732 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261276AbTKMXhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 18:37:15 -0500
Date: Thu, 13 Nov 2003 21:36:59 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BUG] Still having problems with an USB Drive
Message-ID: <20031113233659.GA881@ime.usp.br>
References: <20031112204609.GA1009@ime.usp.br> <Pine.LNX.4.44L0.0311131218050.949-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0311131218050.949-100000@ida.rowland.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 13 2003, Alan Stern wrote:
> On Wed, 12 Nov 2003, Rogério Brito wrote:
> > One week ago, I reported problems with my USB Drive (a Leading Driver
> > UD-11), when trying to use it with Linux.
(...)
> 
> The dmesg files you included and posted don't contain much useful 
> information relating to this problem.

First of all, thank you very much for your concern.

Yes, thinking more about the problem, that seems to be the case. David
Brownell already told me that.

I sent him an e-mail telling what I see when I modify my
/etc/hotplug/usb.rc script to contain "modprobe -q uhci-hcd debug=2".

I don't know if that is sufficient, though (I think he has not had the
time to reply to me yet).

> Forget about usb-storage and hotplug scripts.  If you can't even get
> to the point where your device show up in /proc/bus/usb/devices then
> nothing else will work.

Yes, the strange thing is that sometimes, the drive is detected and it
works. Sometimes, it doesn't.  Most of the time, it doesn't.  And when
it doesn't work and I try to turn hotplug off, I get unkillable
processes (khubd is in state D).

Anyway, what should I do? Should I just boot into single user mode
without hotplug enabled and load the modules by hand?

> Judging from your dmesg output, you have an external hub (ALCOR
> Generic USB Hub) into which your device is plugged.  The device
> contains an internal hub (Leading Driver Co., LTD. USB Embedded Hub)
> and the drive is attached through that internal hub.

I don't really know much about my USB setup. I have an Asus A7V
motherboad and according to its manual (which I just checked), it has 2
USB ports and two USB "leads" (in one of those, I plugged a small cable
to a daughterboard, which gives me more USB ports).

Perhaps this small daughterboard is a new hub?

Anyway, it seems that I have problems regardless of which port I connect
my USB drive to. But I can make tests to confirm that if anybody tells
me what to do.

Oh, BTW, Leading Driver is the USB drive (perhaps it's an internal hub
in the drive?). It may be recognized as more than just one USB device,
but I'm not certain of that, since I don't know what I'm talking about.

BTW, the only USB devices that I have are:

1 - this USB drive;
2 - one keyboard + one mouse;
3 - a HP printer.

> But an attempt to communicate with the drive failed.  It could be a
> problem with the external hub, the internal hub, or the drive itself;
> it's not likely to be a problem with the kernel.  The error message

Ok.

> 	hub 2-2.2:1.0: transfer --> -75
> 
> indicates a problem with the internal hub, but there's no way to tell what 
> that problem is.  The other error message

Is there any way to discover what may be the reason of the problem? Any
higher debugging level would help with that?

> 	usb 2-2.2.1: control timeout on ep0in
> 
> indicates a problem communicating with the drive, but that could be caused 
> by the internal hub not working right.

Right.

> You might try plugging your device directly into the PC to see if that
> makes a difference.

Well, I can try plugging the drive directly into the first ports of the
PC (instead of those of the daughterboard). I will report what I see.

> Better yet, try plugging your device into a completely different PC
> running Linux 2.6 and see what happens.

Ok, I will compile a new kernel for an old computer that I have and I
will also report what I see.

For the time being, I put new files at http://www.ime.usp.br/~rbrito/usb
for the situation without any USB devices plugged after a warm boot. I
hope that they're more helpful than the files I posted before.

> Alan Stern


Thank you very much for your help, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
