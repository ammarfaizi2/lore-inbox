Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290577AbSARBuK>; Thu, 17 Jan 2002 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290578AbSARBuB>; Thu, 17 Jan 2002 20:50:01 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29942 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S290577AbSARBty>;
	Thu, 17 Jan 2002 20:49:54 -0500
Date: Thu, 17 Jan 2002 17:31:07 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Marc Lehmann <pcg@schmorp.de>
cc: Andre Hedrick <andre@linuxdiskcert.org>, linux-kernel@vger.kernel.org
Subject: Re: DO NOT USE IT (Re: linux-2.5.3-pre1 and IDE Driver Trouble)
 FATAL
In-Reply-To: <20020118010443.GB5550@schmorp.de>
Message-ID: <Pine.LNX.4.10.10201171730120.2561-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That problem is now fixed in 2.5.3-pre1-2 + arch_compatablity.patch


On Fri, 18 Jan 2002, Marc Lehmann wrote:

> On Wed, Jan 16, 2002 at 01:07:46PM -0800, Andre Hedrick <andre@linuxdiskcert.org> wrote:
> > 
> > If the driver falls out of DMA, DEADBOX!!!!
> > There is a conflict of BIO and ACB and it is very fatal.
> 
> As a matter of fact, this is not much different to 2.4 behaviour. hdparm
> -d1 on a busy disk kills the machine, with interrupts turned off (tested
> on all my machines (all SMP, btw), with linux-2.4.13-ac7, 2.4.17 and
> 2.4.17+ide-patch), on both my promise, piix and via controllers.
> 
> Also, hdparm -w gives me:
> 
> Jan  7 05:40:47 (none) kernel: bug: kernel timer added twice at c01cc2e9. 
> Jan  7 05:40:54 (none) kernel: ide1: reset: success 
> 
> and then both hdc and hdd are dead, which is only for a short time after
> which the machine freezes (software watchdog doesn't help).
> 
> (under 2.2, using hdparmn on the same hardware was safe, at least with
> respect to hdparm -d1).
> 
> -- 
>       -----==-                                             |
>       ----==-- _                                           |
>       ---==---(_)__  __ ____  __       Marc Lehmann      +--
>       --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
>       -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
>     The choice of a GNU generation                       |
>                                                          |
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

