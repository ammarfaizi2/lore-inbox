Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWHSLEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWHSLEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 07:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWHSLEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 07:04:08 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:56456 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751710AbWHSLEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 07:04:04 -0400
Date: Sat, 19 Aug 2006 13:00:48 +0200
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 Spurious ACK/NAK on isa0060/serio0, 2.6.18-rc2 is fine
Message-ID: <20060819110048.GB3190@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060817221052.GA3025@aitel.hist.no> <20060817223434.GA3616@aitel.hist.no> <20060818215644.GA1893@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818215644.GA1893@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 02:56:44PM -0700, Greg KH wrote:
> On Fri, Aug 18, 2006 at 12:34:34AM +0200, Helge Hafting wrote:
> > On Fri, Aug 18, 2006 at 12:10:52AM +0200, Helge Hafting wrote:
> > > So I tried 2.6.18-rc4-mm1 on my opteron. (Running 64-bit)
> > > 
> > > The kernel did not boot, but went into an infinite loop of
> > > 
> > > Spurious ACK on isa0060/serio0
> > > over and over.  I have two keyboards, one attached the usual
> > > way and another attached where a mouse usually goes.
> > > This works fine with 2.6.18-rc2, but no longer now.
> > > One keyboard is dead, and on the other, two of the
> > > leds blink on and off.
> > > 
> > > Unplugging a keyboard changes the repeating message to
> > > Spurious NAK ... instead.
> > > 
> > > Unplugging both keyboards stops the nonsense, but then - no keyboard.
> > > 
> > > This kernel also fails to mount root, a fact that is hard to see as
> > > the stupid messages quickly scroll everything else away.
> > > That might be something simple like the changed ATA config
> > > or multithreaded pci probe.
> > > 
> > > There just cannot be any program "trying to access hw directly",
> > > I don't get the root fs so I don't even have init running.
> > >
> > I got rid of the multithreaded PCI probe - and the root fs was
> > recognised again (I have both SATA and SCSI, perhaps they
> > were probed in wrong order)
> 
> Are you using the ata_piix driver by chance for your root partition?  If
> so, the multi-thread stuff will not work unless you use the hack below.
>
No, the root is on via sata. 

> > Curiously enough, the keyboard trouble went away too.  Odd.
> > Now posting from a working 2.6.18-rc4-mm1 (With the jiffies hotfix)
> 
> The keyboard stuff is very odd, your keyboard should not be on the PCI
> bus :(

No, it is almost ordinary.  Almost, for I have another keyboard
still connected to the ps2 mouse port, I used to have a two-user setup.
I don't have any pci cards with keyboards connected.

Helge Hafting
