Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314210AbSDRAg0>; Wed, 17 Apr 2002 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314211AbSDRAgZ>; Wed, 17 Apr 2002 20:36:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40441
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314210AbSDRAgZ>; Wed, 17 Apr 2002 20:36:25 -0400
Date: Wed, 17 Apr 2002 17:38:54 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020418003854.GD574@matchmail.com>
Mail-Followup-To: Lincoln Dale <ltd@cisco.com>,
	Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk> <5.1.0.14.2.20020418082824.03112008@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 08:44:45AM +1000, Lincoln Dale wrote:
> At 02:58 PM 17/04/2002 +0200, Baldur Norddahl wrote:
> >It is clear that the 33 MHz PCI bus maxes out at 75 MB/s. Is there a reason
> >it doesn't reach 132 MB/s?
> 
> welcome to the world of PC hardware, real-world performance and theoretical 
> numbers.
> 
> in theory, a 32/33 PCI bus can get 132mbyte/sec.
> 
> in reality, the more cards you have on a bus, the more arbitration you 
> have, the less overall efficiency.
> 
> in theory, with neither the initiator or target inserting wait-states, and 
> with continual bursting, you can achieve maximum throughput.
> in reality, continual bursting doesn't happen very often and/or many 
> hardware devices are not designed to either perform i/o without some 
> wait-states in some conditions or provide continual bursting.
> 
> in short: you're working on theoretical numbers.  reality is typically far 
> far different!
> 
> 
> something you may want to try:
>   if your motherboard supports it, change the "PCI Burst" settings and see 
> what effect this has.
>   you can probably extract another 20-25% performance by changing the PCI 
> Burst from 32 to 64.

This ie a problem with the VIA chipsets.  Intel chipsets burst 4096
bytes per burst, while the VIA chipsets were sending doing 64 bytes per burst.

AMD (like the origional poster later mentioned) chipsets weren't mentioned
in the comparison article I read, so I don't know if it has the same
trouble.

Mike
