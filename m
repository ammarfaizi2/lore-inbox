Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbRGLA0x>; Wed, 11 Jul 2001 20:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbRGLA0n>; Wed, 11 Jul 2001 20:26:43 -0400
Received: from intranet.resilience.com ([209.245.157.33]:30900 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S267383AbRGLA0a>; Wed, 11 Jul 2001 20:26:30 -0400
Message-ID: <3B4CF00C.5B62DDBA@resilience.com>
Date: Wed, 11 Jul 2001 17:32:12 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Laurent Itti <itti@java.usc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: receive stats null for bond0 in 2.4.6
In-Reply-To: <Pine.SV4.3.96.1010711163709.5481B-100000@java.usc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Itti wrote:
> 
> Hi all:
> 
> just installed 2.4.6 and all is well except that all stats in
> /proc/net/dev are at zero on the receive side for our 3x100Mbps
> channel-bonded network interface (bond0, using kernel module "bonding").
> The interface works great (we do receive packets).  Transmit side stats
> appear ok. All stats also ok on the 3 ethernet boards that are enslaved
> into the bond.
> 
> any idea? thanks!
> 

It's always zero because the bonding driver included with the Linux
kernel is pretty broken.  The comments say that its stats are collected
from the slaves, but this is untrue.  See the source code at
http://sourceforge.net/projects/bonding for how the stats should be
collected.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
