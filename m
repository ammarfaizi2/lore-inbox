Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266546AbRGLUYa>; Thu, 12 Jul 2001 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266563AbRGLUYL>; Thu, 12 Jul 2001 16:24:11 -0400
Received: from dweeb.lbl.gov ([128.3.1.28]:4756 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S266546AbRGLUX7>;
	Thu, 12 Jul 2001 16:23:59 -0400
Message-ID: <3B4E06E5.899CAD8E@lbl.gov>
Date: Thu, 12 Jul 2001 13:21:57 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Golds <jgolds@resilience.com>
CC: Laurent Itti <itti@java.usc.edu>, linux-kernel@vger.kernel.org
Subject: Re: receive stats null for bond0 in 2.4.6
In-Reply-To: <Pine.SV4.3.96.1010711163709.5481B-100000@java.usc.edu> <3B4CF00C.5B62DDBA@resilience.com> <3B4DF1A8.BDE85995@lbl.gov> <3B4E02BD.7A9087E2@resilience.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Golds wrote:
> 
> So what's wrong with collecting the slaves' receive stats and reporting
> them as stats for the bonding driver?  At least then you can quickly see
> the total for all devices currently owned by the bonding device.
> 
> Stats are just a tool so that you can see if things are behaving
> properly, you can report back whatever you like.  I prefer to have the
> bonding driver collect the slaves' stats so you can easily see if
> enslaved devices are receiving packets.  If you want to see which device
> is getting more traffic, that's easy to see by looking at the individual
> slave.
> 

the person who ported the driver over to 2.4 from 2.2 made that choice.

It wasn't me.  It was one of the network guys (Dave/Alexy/??).

One problem with collecting all the stats into the bonding driver -
which I have seen, is you can quickly start to overflow counters.  And
they don't roll over.

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
