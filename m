Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129400AbRBSNHA>; Mon, 19 Feb 2001 08:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130182AbRBSNGu>; Mon, 19 Feb 2001 08:06:50 -0500
Received: from slc122.modem.xmission.com ([166.70.9.122]:28937 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129400AbRBSNGo>; Mon, 19 Feb 2001 08:06:44 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: smlong@teleport.com (Scott Long), linux-kernel@vger.kernel.org
Subject: Re: Linux OS boilerplate
In-Reply-To: <E14UfQ8-00027g-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Feb 2001 03:07:33 -0700
In-Reply-To: Alan Cox's message of "Mon, 19 Feb 2001 01:47:15 +0000 (GMT)"
Message-ID: <m1lmr30yvu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > I've been poring over the x86 boot code for a while now and I've been
> > considering writing a FAQ on the boot process (mostly for my own use,
> > but maybe others will be interested). This would include all relevant
> > information on setting up the x86 hardware for a boot (timers, PIC, A20,
> > protected mode, GDT, initial page tables, initial TSS, etc).
> 
> It would certainly be a valuable piece for the kernel Documentation dir.
> Paticularly as people with embedded x86 grow keener and keener to boot 
> biosless to save money and flash.

Actually biosless is nice.  You don't actually need to do things like enable
a20 as there isn't a BIOS to disable it...

As for working code see the linuxBIOS project.  http://www.linuxbios.org
There aren't a lot of chipsets supported yet but progress is being made.
And you do need something like a BIOS to enable memory and cache
before you jump to the linux kernel.

Alan working on all booting x86 biosless, keeps making me chuckle over
your hatred towards BIOSes, it is absolutely amazing what linux
assumes the BIOS will setup correctly.  With linux-2.4 able to do a
complete PCI bus setup it isn't as bad it used to be, but it's still
pretty significant.

You wouldn't happen to know a good place to put drivers for superio
chips, and pci-isa bridges with the superio functions integrated?

I should have a proposal written up (and the code to implement it) in
the next month, on how to change the boot process to be more friendly
to BIOS less situations.   What we do with the ``empty_zero_page'' is
nasty, and it isn't even the empty_zero_page.

And if anyone has any questions on how the boot process works,
I'd be glad to answer specific questions.  As I've traced it fairly
thoroughly. 

Eric
