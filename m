Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135760AbREFQgE>; Sun, 6 May 2001 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135766AbREFQfy>; Sun, 6 May 2001 12:35:54 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:22368 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S135760AbREFQfr>; Sun, 6 May 2001 12:35:47 -0400
Date: Sun, 6 May 2001 12:35:39 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <20010506103450.A29403@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.10.10105061220420.21182-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > also -- isn't it kind of wrong for arp to respond with addresses from
> > other interfaces?
> 
> Usually it makes sense, because it increases your chances of successfull
> communication. IP addresses are owned by the complete host on Linux, not by 
> different interfaces.

this is one of those things that is still hurting Linux's credibility in the
read world.  people see this kind of obviously broken behavior, and install 
*BSD or Solaris instead.

isn't this clearly a case of the kernel being too smart: making it impossible
for a clueful admin to do what he needs?  multi-nic machines are now quite
common, but this "feature" makes them far less useful, since the stack is 
violating the admin's intention.

> For some weirder setups (most of them just caused by incorrect routing
> tables, but also a few legimitate ones; including incoming load balancing
> via multipath routes) it causes problems, so arpfilter was invented to 
> sync ARP replies with the routing tables as needed.

there's NOTHING weird about a machine having two nics and two IPs,
wanting to behave like two hosts.

is there any positive/beneficial reason for the current behavior?

