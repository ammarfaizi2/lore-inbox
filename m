Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTHaOqv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTHaOqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:46:51 -0400
Received: from [66.155.158.133] ([66.155.158.133]:3712 "EHLO
	ns.waumbecmill.com") by vger.kernel.org with ESMTP id S261353AbTHaOqr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:46:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Hans-Peter Jansen <hpj@urpla.net>, Nick Urbanik <nicku@vtc.edu.hk>
Subject: Re: Single P4, many IDE PCI cards == trouble??
Date: Sun, 31 Aug 2003 11:46:03 -0400
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F4EA30C.CEA49F2F@vtc.edu.hk> <3F4F5C9A.5BAA1542@vtc.edu.hk> <200308311443.55543.hpj@urpla.net>
In-Reply-To: <200308311443.55543.hpj@urpla.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308311146.03877.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am successful in using the Tyan 2460/2466 motherboard with a 3ware 8-channel 
IDE controller and 8 WD1200 drivers, and a single WD800 IDE system drive, and 
4 bt878 frame grabbers.  

However, on a Gigabyte GA7VXP via 400 with Athlon 2400 MP with onboard Promise 
20276 controller with 2 WD1200's and a WD800 for the system drive and 4 
framegrabbers, I get IDE DMA timeouts which are a symptom for future file 
system corruption. I am using the /dev/ataraid device, and have not tried 
this configuration using Promise's driver which creates a /dev/sda1 SCSI 
device out of it. I have tried 3ware's 7000 controller with the 
kernel-included (GPL) /dev/sda driver, and it results in lower probability of 
file system corruption.

On Sunday 31 August 2003 08:43 am, Hans-Peter Jansen wrote:
> Hi Nick,
>
> On Friday 29 August 2003 16:00, Nick Urbanik wrote:
> > Performance is a relatively minor issue compared with stability and
> > low cost.
> >
> > Is there _anyone_ who is using a number of ATA133 IDE disks (>=6),
> > each on its own IDE channel, on a number of PCI IDE cards, and
> > doing so successfully and reliably?  I begin to suspect not!  If
> > so, please tell us what motherboard, IDE cards you are using.  I
> > used to imagine that a terabyte of RAID storage on one P4 machine
> > with ordinary cheap IDE cards with software RAID would be feasible.
> >  I believe it is not (although I cannot afford to play musical
> > motherboards).
>
> It is. I'm running several pretty stable systems with IDE SW RAID 5
> on top of Promise TX2/100 (~30 Eur) controllers. There was a long
> standing limit of two cards from this type, which seems to be removed
> lately (as Alan stated). At least, the test system hasn't fallen on
> it's face, when adding a third controller, and attached devices acted
> as expected without freezing, throwing DMA errors, and the like.
>
> Of course, the usual "don't buy the latest and greatest hardware,
> if the manufacturer isn't fully commited to linux support" applies.
> Promise isn't!
>
> Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
