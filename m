Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266518AbRGLSws>; Thu, 12 Jul 2001 14:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbRGLSw3>; Thu, 12 Jul 2001 14:52:29 -0400
Received: from dweeb.lbl.gov ([128.3.1.28]:30611 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S266507AbRGLSwV>;
	Thu, 12 Jul 2001 14:52:21 -0400
Message-ID: <3B4DF1A8.BDE85995@lbl.gov>
Date: Thu, 12 Jul 2001 11:51:20 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Golds <jgolds@resilience.com>
CC: Laurent Itti <itti@java.usc.edu>, linux-kernel@vger.kernel.org
Subject: Re: receive stats null for bond0 in 2.4.6
In-Reply-To: <Pine.SV4.3.96.1010711163709.5481B-100000@java.usc.edu> <3B4CF00C.5B62DDBA@resilience.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Golds wrote:
> 
> Laurent Itti wrote:
> >
> > Hi all:
> >
> > just installed 2.4.6 and all is well except that all stats in
> > /proc/net/dev are at zero on the receive side for our 3x100Mbps
> > channel-bonded network interface (bond0, using kernel module "bonding").
> > The interface works great (we do receive packets).  Transmit side stats
> > appear ok. All stats also ok on the 3 ethernet boards that are enslaved
> > into the bond.
> >
> > any idea? thanks!
> >
> 
> It's always zero because the bonding driver included with the Linux
> kernel is pretty broken.  The comments say that its stats are collected
> from the slaves, but this is untrue.  See the source code at
> http://sourceforge.net/projects/bonding for how the stats should be
> collected.
> 

No, in 2.2, bonding collected stats by adding up the slave's stats, and
presenting that.

In 2.4, the stats was changed to be exactly what the bonding device has
seen.

Bonding device will never ever see anything to do with recieve packets.

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
