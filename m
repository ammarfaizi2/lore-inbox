Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287595AbSAURpo>; Mon, 21 Jan 2002 12:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287598AbSAURpe>; Mon, 21 Jan 2002 12:45:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26633 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287595AbSAURp0>;
	Mon, 21 Jan 2002 12:45:26 -0500
Date: Mon, 21 Jan 2002 18:44:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121184433.C1018@suse.de>
In-Reply-To: <20020121121456.A24656@suse.cz> <Pine.LNX.4.10.10201210324150.14375-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201210324150.14375-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> > I always thought it is like this (and this is what I still believe after
> > having read the sprcification):
> > 
> > ---
> > SET_MUTIPLE 16 sectors
> > ---
> > READ_MULTIPLE 24 sectors
> > IRQ
> > PIO transfer 16 sectors
> > IRQ
> > PIO transfer 8 sectors
> > ---
> > 
> > Where am I wrong?
> > 
> > By the way, the device *isn't* required to support any lower multiple
> > count than the maximum one it advertizes. Ugly.
> 
> No but the HOST is to obey the requirements of the device.
> The spec is written from the drive side not the host side.
> 
> "All Ye Hosts, SHALL address me in such a manner as described, or be
> aborted or I SHALL remain in an undertermined state."
> 
> Note only recently have the HOSTS been about to setup guidelines for what
> is sane and not stupid for the device to do or behave.
> 
> Again, the HOST(Linux) is not following the device side rules so expect
> difficulty when we depart.  The Brain Damage is how to talk to the
> hardware, and it is clear we are not doing it right because we are bending
> the rules stuff it into and API that not acceptable.  However we are
> stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
> buffer pages are contigious and the 4k page dance is a NOOP.  Until that
> time we will be fussing about.

Andre,

Do you know how to say "I was wrong"? You are walking off-track again.
It's clearly the way that Vojtech and I describe, otherwise current code
would just not work. And 2.4, 2.2, 2.0 neither.

-- 
Jens Axboe

