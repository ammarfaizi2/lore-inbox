Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWBBUgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBBUgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWBBUgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:36:16 -0500
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:55508 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S932220AbWBBUgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:36:15 -0500
Date: Thu, 2 Feb 2006 23:36:14 +0300
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Re: Broken sata (VIA) on Asus A8V (kernel 2.6.14+)
Message-ID: <20060202203614.GA21984@tentacle.sectorb.msk.ru>
References: <20060201162800.GA32196@tentacle.sectorb.msk.ru> <43E13F57.40808@gmail.com> <20060201231911.GA5463@tentacle.sectorb.msk.ru> <43E145B8.6090404@gmail.com> <20060202114429.GA3035@tentacle.sectorb.msk.ru> <43E1F211.8030507@gmail.com> <20060202123910.GA14328@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060202123910.GA14328@tentacle.sectorb.msk.ru>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.15.1-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 03:39:10PM +0300, Vladimir B. Savkin wrote:
> On Thu, Feb 02, 2006 at 08:50:41PM +0900, Tejun Heo wrote:
> > Vladimir B. Savkin wrote:
> > >On Thu, Feb 02, 2006 at 08:35:20AM +0900, Tejun Heo wrote:
> > >
> > >>Your BMDMA controller is reporting raised interrupt (0x4) and your drive 
> > >>is saying that it's ready for the next command, yet interrupt handler of 
> > >>sata_via hasn't run and thus the timeout.  It looks like some kind of 
> > >>IRQ routing problem to me although I have no idea how the problem 
> > >>doesn't affect the boot process.
> > >>
> > >>Can you try to boot with boot parameter pci=noacpi?
> > >
> > >
> > >That did not help.
> > >
> > >And yes, irqbalance is running, as Kenneth suggested.
> > >
> > 
> > Sadly, I'm pretty much ignorant with that part of the kernel.  However, 
> > if it's really because interrupts are lost when sent to one of the 
> > processors, one of the following should keep the system going while the 
> > other cause the problem immediately.
> > 
> > echo 1 > /proc/irq/your_IRQ_number/smp_affinity
> > 
> > or...
> > 
> > echo 2 > /proc/irq/your_IRQ_number/smp_affinity
>  
> It is certainly not that simple.
> Just playing with smp_affinity (with irqbalance stopped) gives no errors.
> 

For the record - without irqbalance the box is stable.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

