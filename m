Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSCSSbP>; Tue, 19 Mar 2002 13:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSCSSbH>; Tue, 19 Mar 2002 13:31:07 -0500
Received: from Expansa.sns.it ([192.167.206.189]:34570 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289815AbSCSSas>;
	Tue, 19 Mar 2002 13:30:48 -0500
Date: Tue, 19 Mar 2002 19:30:55 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <3C9770C9.5000201@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203191930220.26263-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This did not work, nor with DMA_66 neighter with DMA_33


On Tue, 19 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> > HI,
> >
> > also with 2.5.7, as with 2.5.6, I have problems at boot.
> > I get the usual oops while initialising IDE.
> >
> > my ide controller is:
> >
> > 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> > [Master])
> >         Subsystem: Intel Corporation 82801AA IDE
> >         Flags: bus master, medium devsel, latency 0
> >         I/O ports at 2460 [size=16]
> >
> > unfortunatelly, I do not have even the time to write down oops message,
> > but eip is c0135068, but then I do not find a similar entry in system.map
> >
> > any hint
>
> This device is behaving quite like the 440MX chipset
> I have myself I can't therefore the oops expect beeing caused
> by a trivial programming error in the actual ide driver.
> I don't see much pointer acces in piix.c code as well.
>
> However you could eventually just try apply the following
> pseudo diff to piix.c and then try again:
>
> -
> { PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },
> +
> { PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66 },
>
> Replaceing PIIX_UDMA_33 with PIIX_UDMA_33 could be worth a try as well.
>
>
>
>

