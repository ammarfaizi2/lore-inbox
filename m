Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUJCHxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUJCHxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUJCHxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:53:38 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:3748 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267759AbUJCHvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:51:46 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Date: Sun, 3 Oct 2004 09:51:43 +0200
User-Agent: KMail/1.7
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040929214637.44e5882f.akpm@osdl.org> <200410011303.31897.petkov@uni-muenster.de> <200410012042.02628.petkov@uni-muenster.de>
In-Reply-To: <200410012042.02628.petkov@uni-muenster.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410030951.44040.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 20:42, Borislav Petkov wrote:
> On Friday 01 October 2004 13:03, Borislav Petkov wrote:
> > On Friday 01 October 2004 12:34, Borislav Petkov wrote:
> > > On Friday 01 October 2004 11:54, Jens Axboe wrote:
> > > > On Fri, Oct 01 2004, Borislav Petkov wrote:
> > > > > On Friday 01 October 2004 11:18, Jens Axboe wrote:
> > > > > > On Fri, Oct 01 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > On Thursday 30 September 2004 23:46, Borislav Petkov wrote:
> > > > > > > > On Thursday 30 September 2004 18:25, Bartlomiej
> > > > > > > > Zolnierkiewicz
> > >
> > > wrote:
> > > > > > > > > On Thursday 30 September 2004 17:32, Borislav Petkov wrote:
> > > > > > > > > > On Thursday 30 September 2004 14:52, Bartlomiej
> > > > > > > > > > Zolnierkiewicz
> > > > >
> > > > > wrote:
> > > > > > > > > > > On Thursday 30 September 2004 06:46, Andrew Morton 
wrote:
> > > > > > > > > > > > ide broke :(   Maybe Bart's bk tree?
> > > > > > > > > > >
> > > > > > > > > > > no, disk works just fine ;)  If it is my tree I will
> > > > > > > > > > > happilly fix it.
> > > > > > > > > > >
> > > > > > > > > > > Borislav, could you apply only these patches from -mm4
> > > > > > > > > > > and retest?
> > > > > > > > > > >
> > > > > > > > > > > linus.patch
> > > > > > > > > > > bk-ide-dev.patch
> > > > > > > > > > >
> > > > > > > > > > > > Begin forwarded message:
> > > > > > > > > > > >
> > > > > > > > > > > > Date: Wed, 29 Sep 2004 12:43:35 +0200
> > > > > > > > > > > > From: Borislav Petkov <petkov@uni-muenster.de>
> > > > > > > > > > > > To: Andrew Morton <akpm@osdl.org>
> > > > > > > > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > > > > > > > Subject: Re: 2.6.9-rc2-mm4
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > <snip>
> > > > > > > > > > > >
> > > > > > > > > > > > Hello,
> > > > > > > > > > > >  I've already posted about problems with audio
> > > > > > > > > > > > extraction but it went unnoticed. Here's a recount:
> > > > > > > > > > > > When I attempt to read an audio cd into wavs with
> > > > > > > > > > > > cdda2wav, the process starts but after a while the
> > > > > > > > > > > > completion meter freezes and klogd says "hdc: lost
> > > > > > > > > > > > interrupt" and cdda2wav hangs itself. Disabling DMA
> > > > > > > > > > > > doesn't help as well as the boot option
> > > > > > > > > > > > "pci=routeirq" too. Older kernels like 2.6.7 do not
> > > > > > > > > > > > show such behavior and there audio extraction runs
> > > > > > > > > > > > fine. Sysinfo attached.
> > > > > > > > > > > >
> > > > > > > > > > > > Regards,
> > > > > > > > > > > > Boris.
> > > > > > > > > >
> > > > > > > > > > Hi people,
> > > > > > > > > >
> > > > > > > > > >  well, I've applied the above patches but no change -
> > > > > > > > > > same "hdc: lost interrupt" message. 2.6.9-rc3 behaves the
> > > > > > > > > > same, as expected.
> > > > > > > > >
> > > > > > > > > Well, if 2.6.9-rc3 fails then it is not my tree...
> > > > > > > > >
> > > > > > > > > Please find kernel version which introduces this bug.
> > > > > > > >
> > > > > > > > Just compiled 2.6.8.1 and tested audio extraction. The bug is
> > > > > > > > there. After that, reran the test with 2.6.7. Everything went
> > > > > > > > fine. So it must have been between 2.6.7 and 2.6.8.1 when the
> > > > > > > > bug got introduced. Any additional debugging options in the
> > > > > > > > ATA/IDE cd driver i could turn on so that I could get more
> > > > > > > > verbose messages while executing cdda2wav?
> > > > > > >
> > > > > > > I'm not aware of any.  Jens?
> > > > > >
> > > > > > I don't see any changes that could impact this from 2.6.7 to
> > > > > > 2.6.8. We tightened the dma alignment (from 4 to 32 bytes), but
> > > > > > should not cause problems going in that direction. Unless the
> > > > > > other path is buggy, of course.
> > > > > >
> > > > > > Does dma make a difference? Please try 2.6.9-rc3 as well.
> > > > >
> > > > > Sorry guys,
> > > > >
> > > > > still a no go. Tested today 2.6.8.1 and 2.6.9-rc3 both with DMA
> > > > > on/off. same lost interrupt message. How about a hardware problem?
> > > > > Maybe the cd-drive is showing some hidden "features" under certain
> > > > > conditions, although it is highly unlikely since 2.6.7 runs fine.
> > > > > strange...
> > > >
> > > > I can't say, probably you need to look outside of ide changes to
> > > > locate the problem. Have you tried disabling acpi on your box?
> > >
> > > I'm not sure whether adding the boot option acpi=off is enough to
> > > disable ACPI in 2.6, but if this is the case 2.6.9-rc3 is still a no go
> > > with acpi disabled. How about APIC?
> >
> > After booting with "acpi=off noapic", I found something that might bring
> > us further:
> >
> > <snip>
> > PCI: Probing PCI hardware
> > PCI: Probing PCI hardware (bus 00)
> > PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > PCI: Transparent bridge - 0000:00:1e.0 <----
> > PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
> > PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try
> > pci=usepirqmask PCI: Found IRQ 5 for device 0000:00:1f.1
> > PCI: Sharing IRQ 5 with 0000:00:1d.2
> > </snip>
> >
> > Well, 0000:00:1f.0 is the IDE controller so later today I'll try the
> > pci=usepirqmask boot option. Comments?
>
> Still no luck with different boot options. Beginning to test the 2.6.8-rc
> series...

Testing log:

2.6.8-rc1: OK
2.6.8-rc2: OK
2.6.8-rc3: OK
2.6.8-rc4: BUG!

OK, we got the two releases inbetween which the problem got introduced. Gonna 
continue testing with the 4 incremental bk snapshots patch-2.6.8-rc3-bk[1-4] 
now. To be continued...

Boris.
