Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312903AbSDEPOd>; Fri, 5 Apr 2002 10:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312919AbSDEPOX>; Fri, 5 Apr 2002 10:14:23 -0500
Received: from Expansa.sns.it ([192.167.206.189]:62472 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312903AbSDEPOS>;
	Fri, 5 Apr 2002 10:14:18 -0500
Date: Fri, 5 Apr 2002 17:14:12 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: joeja@mindspring.com, <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <3CAD55F7.55C56F96@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0204051709050.15574-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is really noisy is the scsi boot on some server, when you have 4 or
more disks and some other stuff, like on some of my sparc64.
Sometimes It can happen that a reboot asks some minute just for all scsi
and fibbre stuff. If you have MC^2 and some logical volume around on it,
it can be really noisy, especially if you are in a hurry, as always
when it comes to production servers :(.

On desktop PC kernel boot is hardly a problem, the real
slowdown are the init script, but then every distribution
has its own (slower or faster).

On Fri, 5 Apr 2002, Helge Hafting wrote:

> joeja@mindspring.com wrote:
> >
> > Think pre init scripts....
> >
> > no apache was install on this machine, no iptables scripts, etc.
> >
> > I'm actually talking about the time from where Linux spits out all this crap about probing irq's, ide drive found with dma etc.  That kind of stuff.
>
> Compile your own kernel with drivers only for hardware you
> actually have and use during boot.  Omit all other drivers.  That gets
> rid
> of a lot of probing, and the time from "kernel loaded" to "starting
> init"
> gets quite short.  Also, some drivers lets you specify irq's etc.
> on the kernel command line - that may avoid further probing.
>
> Drivers for things not needed in the kernel boot process (cdrom, floppy,
> ethernet, etc.) can be made modular.  That avoids time-consuming cd
> spinup
> and probing of non-boot devices.
>
> The kernel boot is only a few seconds on my office machine.  The bios
> boot is one long delay, the initscripts another.
>
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

