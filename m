Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUCRNqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUCRNqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:46:25 -0500
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:29902 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S261807AbUCRNqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:46:23 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: SiS APIC, hacker looking for docs/help, was : Re: 2.6.4 under heavy ioload disables sis5513 DMA
Date: Thu, 18 Mar 2004 23:48:26 +1000
User-Agent: KMail/1.5.1
Cc: Lionel.Bouton@inet6.fr
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403182348.26764.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> > Dunno how DMA timeout is related to interrupts or are you suggesting it 
> > is loosing dma-complete interrupts? 
> > 
> > I don't know the details (yet I hope), but I'm quite sure that interrupt 
> > handling in XT-PIC mode leads to problems on several SiS configurations 
> > (when you reorganize PCI cards in a system and the behaviour changes or 
> > when you disable the VGA IRQ and some things start to work, the suspect 
> > becomes obvious). One user reported that putting 2 disks on one channel 
> > instead of one on each (so 1 IRQ used instead of 2) solve instability 
> > issues too... I ruled out IDE driver problems several times by 
> > repeatedly checking the code and the run-time register values against 
> > known-good values. My lack of knowledge on the interrupt handling 
> > details is what prevents me from being 100% sure that the problem lies 
> > here. This is why I'm willing to work on this subject. 
 
I had a report that my patch helped an sis740 board run in apic ioapic mode.
Don't know if it would help your situation. Here is relevant link.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4278.html

There is a problem with apm mode with my patch - small fix here if reqd.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4410.html

Hope it helps.
Ross.

> > Same board runs same and higher loads with 2.4.2[345] flawlessly. Also 
> > 8 hours OK with 2.4.26-pre4 last night + 430 cycles of swsusp2. 
> > 
 
