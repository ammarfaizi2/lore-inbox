Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbTGOPWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268684AbTGOPUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:20:23 -0400
Received: from gate.perex.cz ([194.212.165.105]:65028 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S268453AbTGOPTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:19:10 -0400
Date: Tue, 15 Jul 2003 17:33:14 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Meadors <twrchris@hereintown.net>, Amit Shah <shahamit@gmx.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
Subject: Re: [Alsa-devel] Re: 2.6.0-test1: ALSA problem
In-Reply-To: <s5h7k6j3jvk.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.44.0307151732280.26334-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Takashi Iwai wrote:

> At 15 Jul 2003 10:57:55 -0400,
> Chris Meadors wrote:
> > 
> > On Tue, 2003-07-15 at 01:18, Amit Shah wrote:
> > > I don't know what the problem is exactly, since alsa shows it found one 
> > > card... I'm using debian woody with alsa-base installed. Even if alsa shows 
> > > one card detected, it doesn't play. (It doesn't recognize /dev/dsp?)
> > > 
> > > 
> > > Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 
> > > 2003 UTC).
> > > kobject_register failed for Ensoniq AudioPCI (-17)
> > > Call Trace:
> > >  [<c01f6b8a>] kobject_register+0x32/0x48
> > >  [<c0248a1b>] bus_add_driver+0x3f/0xa0
> > >  [<c0248e0a>] driver_register+0x36/0x3c
> > >  [<c01fb236>] pci_register_driver+0x6a/0x90
> > >  [<c04117ba>] alsa_card_ens137x_init+0xe/0x3c
> > >  [<c03f86f5>] do_initcalls+0x39/0x94
> > >  [<c03f876c>] do_basic_setup+0x1c/0x20
> > >  [<c010509b>] init+0x33/0x188
> > >  [<c0105068>] init+0x0/0x188
> > >  [<c0107145>] kernel_thread_helper+0x5/0xc
> > > 
> > > ALSA device list:
> > >   #0: Intel 82801BA-ICH2 at 0xe800, irq 17
> > 
> > I see exactly the same thing with my Sound Blaster 16 PCI.
> 
> 
> hmm, something gets wrong when no irq is generated and the pcm stream
> is forced to be closed.  i'll check this.
> 
> are you using a UP kernel or an SMP kernel?

It might be related that we have not initialized the owner field from the 
pci_dev structure for 2.6 kernels. I will fix that soon.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

