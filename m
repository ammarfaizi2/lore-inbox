Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267360AbUJWLm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267360AbUJWLm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 07:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUJWLmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 07:42:55 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:58758 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S267360AbUJWLmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 07:42:50 -0400
Date: Sat, 23 Oct 2004 14:41:18 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
In-Reply-To: <Pine.LNX.4.61.0410231424330.3073@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0410231440490.2974@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org>
 <Pine.LNX.4.61.0410231424330.3073@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cc for LKML, (damned NNTP client)

On Sat, 23 Oct 2004, Zwane Mwaikambo wrote:

> On Sat, 23 Oct 2004, Andrew Morton wrote:
> 
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Hi,
> > > 
> > > I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely, after 
> > > some time in X, USB suddenly stops working and sound goes off simultaneously 
> > > (it's quite annoying, as I use a USB mouse ;-)).  It is 100% reproducible and 
> > > it may be related to the sharing of IRQ 5:
> > > 
> > > rafael@albercik:~> cat /proc/interrupts
> > >            CPU0
> > >   0:    3499292          XT-PIC  timer
> > >   1:       7135          XT-PIC  i8042
> > >   2:          0          XT-PIC  cascade
> > >   5:       6945          XT-PIC  NVidia nForce3, ohci_hcd
> > >   8:          0          XT-PIC  rtc
> > >   9:       1416          XT-PIC  acpi, yenta
> > >  10:          2          XT-PIC  ehci_hcd
> > >  11:      37266          XT-PIC  SysKonnect SK-98xx, yenta, ohci1394, ohci_hcd
> > >  12:      13781          XT-PIC  i8042
> > >  14:         16          XT-PIC  ide0
> > >  15:      23601          XT-PIC  ide1
> > > NMI:          0
> > > LOC:    3498657
> > > ERR:          1
> > > MIS:          0
> > > 
> > > (NVidia nForce3 is a sound chip, snd_intel8x0).  After it happens I can't 
> > > reboot the box cleanly (the ohci-hcd driver cannot be reloaded) and it does 
> > > not leave any traces in the log.
> > > 
> > 
> > Beats me.  Does the interrupt count stop increasing?
> 
> Could we also get a dmesg and lspci? Boot with the 'debug' kernel 
> parameter.
