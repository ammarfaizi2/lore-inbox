Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTBUOQj>; Fri, 21 Feb 2003 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTBUOQj>; Fri, 21 Feb 2003 09:16:39 -0500
Received: from www.netops.co.uk ([195.224.68.226]:37853 "EHLO netops.co.uk")
	by vger.kernel.org with ESMTP id <S267445AbTBUOQh>;
	Fri, 21 Feb 2003 09:16:37 -0500
Date: Fri, 21 Feb 2003 14:26:37 +0000 (GMT)
From: Steve Parker <steve.parker@netops.co.uk>
X-X-Sender: steve@www.netops.co.uk.
To: Duncan Sands <baldrick@wanadoo.fr>
cc: Steve Parker <steve.parker@netops.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Alcatel SpeedTouch USB Modem
In-Reply-To: <200302210953.18215.baldrick@wanadoo.fr>
Message-ID: <Pine.GSO.4.44.0302211419210.26954-100000@www.netops.co.uk.>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for that, Duncan. Lightweight and stable certainly sounds good; I
look forward to the project being ready.

Steve

On Fri, 21 Feb 2003, Duncan Sands wrote:

> On Friday 21 February 2003 03:01, Steve Parker wrote:
> > I see that the Alcatel kernel-level driver for the Alcatel SpeedTouch USB
> > Modem is now included in the 2.5 kernel.
>
> Hi Steve, that is so, and I am maintaining it.
>
> > This seems strange, since there seem to have been (in the past, at least)
> > a lot of (panic) problems reported with it, and the speedtouch.sf.net (and
> > complimentary speedtouchconf.sf.net) are fully capable of running this
> > modem in userspace.
> > Have these problems been resolved? Is the kernel driver as stable as the
> > userspace one? Are there demonstrable perfomance benefits in the kernel
> > driver?
>
> These problems are being resolved.  Most of them have already been resolved.
> The cvs version for 2.4, which you can find at
>
> 	http://www.linux-usb.org/SpeedTouch/
>
> is quite stable.  In theory it can still crash (due to various micro races), but in
> practice it does not.  In any case, these micro races will be fixed soon.  The
> 2.5 version, which is essentially identical to 2.4 cvs, doesn't work very well
> in the current 2.5 kernel.  I don't know why.  I am working on it.
>
> I have nothing against the user space version, which I used for many moons.
> The kernel version is certainly much lighter weight - less CPU, less memory.
> Whether this matters for you depends on your machine/needs.  My machine
> is slow, and I need all the CPU time I can get!
>
> > I've certainly been using my modem for well over a year with the userspace
> > driver (speedtouch.sf.net) with - as at 2.4.18 - an unpatched kernel, and
> > no troubles whatsoever. Is there any need for the Alcatel code in the
> > kernel when the n_hdlc and ppp configs already cater for this modem, once
> > the microcode is loaded?
>
> The main disadvantages of the kernel mode driver were:
> (1) unstable, and very unstable on SMP/preempt boxes
> (2) required running the closed source speedmgmt program
> (3) required compiling your own kernel
>
> The driver is in 2.5, and is heading for inclusion in 2.4, so I expect that in the
> future most distributions will ship with the speedtch module compiled.  Thus
> (3) is going away.
>
> The cvs version of the user space driver contains a patch for modem_run
> which enables it to be used with the kernel driver in place of speedmgmt
> (use the -k flag).  Thus (2) has already gone away.
>
> As I mentioned, (1) is (almost) dealt with.
>
> > What is the status of this driver WRT the Alcatel microcode? Last I heard,
> > the Alcatel microcode was required by both the Alcatel kernel-level and
> > the speedtouch.sf.net drivers.
>
> That is correct, but you no longer need to upload it using speedmgmt.
> There are efforts underway to reverse engineer the microcode, with
> some success.  The goal of writing our own microcode (ARM processor
> by the way) is still far, far away though.
>
> All the best,
>
> Duncan.
>

