Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbRCXAxR>; Fri, 23 Mar 2001 19:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRCXAxI>; Fri, 23 Mar 2001 19:53:08 -0500
Received: from monza.monza.org ([209.102.105.34]:54276 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131393AbRCXAwy>;
	Fri, 23 Mar 2001 19:52:54 -0500
Date: Fri, 23 Mar 2001 16:51:56 -0800
From: Tim Wright <timw@splhi.com>
To: Jacob Luna Lundberg <jacob@velius.chaos2.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: use the kernel to change an irq?
Message-ID: <20010323165156.D2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Jacob Luna Lundberg <jacob@velius.chaos2.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0103222258140.388-100000@velius.chaos2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0103222258140.388-100000@velius.chaos2.org>; from jacob@velius.chaos2.org on Thu, Mar 22, 2001 at 11:10:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

They're sharing an IRQ because they're attached to the same interrupt line
on the motherboard. Nothing you can do in software is ever going to change
this. For most BX chipset motherboards I've seen, the AGP slot shares the
same interrupt as the first (i.e. physically closest) PCI slot. If you change
the IRQ for one, you just changed it for the other. If you don't want it to
share, you can't have anything in the other slot. Sounds like you're out of
luck :-(

Tim

On Thu, Mar 22, 2001 at 11:10:28PM -0800, Jacob Luna Lundberg wrote:
> 
> Oh Great Gurus:
> 
> I have an agp video card that seems quite picky about interrupts, and a
> bios that is insisting on sharing the video card's interrupt with whatever
> is in the first pci slot.  So my question is, is there any way for the
> kernel to more or less say ``screw you'' to the bios and pick the irq for
> the video card itself?  I have a spare irq I'd love for it to use...
> 
> Oh, almost forgot:  Yes, I'd just vacate the pci slot below the video
> card, but sadly all my pci slots are in use.  :(
> 
> Ok, I'll admit the card is an nVidia card and I'm trying to use the (evil)
> binary drivers.  But note I'm *not* asking for help with that directly.
> I'm merely asking if there's a way to avoid sharing the interrupt...
> 
> Thanks Muchly,
> -Jacob
> 

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
