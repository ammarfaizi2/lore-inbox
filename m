Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271023AbRHQUBu>; Fri, 17 Aug 2001 16:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271016AbRHQUBk>; Fri, 17 Aug 2001 16:01:40 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:58358 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271023AbRHQUB0>; Fri, 17 Aug 2001 16:01:26 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 14:00:49 -0600
To: Nicholas Knight <tegeran@home.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010817140049.G17372@turbolinux.com>
Mail-Followup-To: Nicholas Knight <tegeran@home.com>,
	Adrian Cox <adrian@humboldt.co.uk>, root@chaos.analogic.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010817130849.2216A-100000@chaos.analogic.com> <3B7D5603.8080805@humboldt.co.uk> <01081711510800.00814@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081711510800.00814@c779218-a>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  11:51 -0700, Nicholas Knight wrote:
> Now that we've established that SDRAM doesn't neccisarily get erased from 
> rebooting, does anyone know how long it takes for SDRAM to clear after 
> losing power? It seems to me that the fact that the RAM isn't neccisarily 
> wiped by the BIOS at boot is less important than wether or not shutting 
> down the system and having it shut down for 10 minutes causes the RAM to 
> be cleared so that any intruder/thief would be unable to get the 
> information neccisary to decrypt the swap...

Hmm, it was my understanding that all PC BIOSes DO zero out memory,
although this is not necessarily a requirement of the hardware.  The
reason I say this is because one of the features of the Linux BIOS
project is to allow crashdump analysis after a reboot, by pulling
the dump from the RAM after a reboot.  You apparently are not able
to do this with normal PC BIOSes because they clear the RAM after
a reset.

That said, I'm not sure what the requirements of different kinds of
RAM chips are for initialization, so there may not be a REQUIREMENT
to clear the memory, but rather it is part of the nebulous "PC spec".

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

