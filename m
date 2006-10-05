Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWJEUad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWJEUad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWJEUad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:30:33 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:54538 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932069AbWJEUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:30:31 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 regression in 2.6.19-rc1 (was Re: Merge window closed: v2.6.19-rc1)
Date: Thu, 5 Oct 2006 21:30:28 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610051609.12466.s0348365@sms.ed.ac.uk> <45255574.5020203@s5r6.in-berlin.de>
In-Reply-To: <45255574.5020203@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200610052130.28610.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 19:56, Stefan Richter wrote:
> Alistair John Strachan wrote:
> > Booted fine here, but I've got a few strange messages from the firewire
> > subsystem that weren't present in 2.6.18. I think it marginally slows
> > down boot up, but I could just be imagining it.
> >
> > [alistair] 16:04 [~] dmesg | grep 1394
> > ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19] 
> > MMIO=[dffff000-dffff7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> > ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[17] 
> > MMIO=[dfffc000-dfffc7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
> > ohci1394: fw-host0: Running dma failed because Node ID is not valid
> > ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
> > ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
> > ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0091023fd7]
> > ieee1394: Host added: ID:BUS[1-00:1023]  GUID[000129200003d023]
>
> Thanks for the quick report. Could you please test the following, each
> one separately?
>
> A. Configure PCI_MULTITHREAD_PROBE=n

Not set.

> B. Revert patch "Initialize ieee1394 early when built in"
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>itdiff_plain;h=8df4083c5291b3647e0381d3c69ab2196f5dd3b7

Firewire isn't built in. I assume therefore this would have no effect.

> I don't see how any other ohci1394 patch after 2.6.18 could lead up to
> that message. I also don't understand what causes this glitch. At least
> it seems recoverable, according to the "Host added" lines.

I haven't tried to use it, but I agree that the outcome is similar. I 
recompiled with excessive debug output on 2.6.19-rc1, and uploaded the 
configs for 2.6.19-rc1 and 2.6.18, and the corresponding dmesg outputs. As 
you can see, 2.6.18 does not exhibit any problems.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
