Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272767AbTG1JeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272770AbTG1JeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:34:19 -0400
Received: from server.snowfall.se ([213.136.34.4]:33541 "EHLO mail.snowfall.se")
	by vger.kernel.org with ESMTP id S272767AbTG1JeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:34:15 -0400
Date: Mon, 28 Jul 2003 11:49:27 +0200 (CEST)
From: Stefan Cars <stefan@snowfall.se>
X-X-Sender: stefan@guldivar.globalwire.se
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 SATA high interrupt/system load again...
In-Reply-To: <3F187DB1.1040309@pobox.com>
Message-ID: <20030728114850.F22307@guldivar.globalwire.se>
References: <20030718233631.F31074@guldivar.globalwire.se> <3F187DB1.1040309@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What also is interesting is that when I configure my kernel to use APIC it
hangs during boot just as it found the SATA drives...

/ Stefan

On Fri, 18 Jul 2003, Jeff Garzik wrote:

> Stefan Cars wrote:
> > Hi!
> >
> > I've seen the discussion regarding high interrupt / system load on the
> > ICH5 SATA and I'm asking what todo about it if I can't put my BIOS into
> > "normal" mode. This machine is an Dell Precision 360 and for some stupid
> > reason they have for this model removed the possibility in the BIOS to
> > change this sort of things (you can't change much really). I'm using
> > 2.4.21-ac4. Just to extract a simple tar file brings the system load up
> > and the computer is slow...
> >
> >
> > Here is some info:
> > tjatte:/import# cat /proc/interrupts
> >            CPU0
> >   0:     557725          XT-PIC  timer
> >   1:        102          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   5:          0          XT-PIC  ehci_hcd
> >   9:   16409116          XT-PIC  libata, usb-uhci, eth0
>
>
> Hum... interesting.  I had seen reports of this before, but they were of
> the variety "drivers/ide has high load, libata doesn't".  So it seems
> intrinsic of the hardware, which is a useful data point.
>
> Have you tried messing around with interrupt routing in BIOS setup?
> Since ATA, USB, and eth0 are all on the same interrupt, changing that
> may affect the situation positively.
>
> 	Jeff
>
>
>
