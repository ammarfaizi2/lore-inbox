Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVJASFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJASFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVJASFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:05:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15115 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750740AbVJASFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:05:48 -0400
Date: Sat, 1 Oct 2005 19:05:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Patrick McHardy <kaber@trash.net>
Cc: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
       linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.13-rc2+ - problem with DHCP
Message-ID: <20051001180530.GB11254@flint.arm.linux.org.uk>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <433EBBEC.4050203@gorzow.mm.pl> <433ECE42.2070400@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433ECE42.2070400@trash.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 07:58:26PM +0200, Patrick McHardy wrote:
> Radoslaw Szkodzinski wrote:
> >These kernels just do not get the IP from DHCP.
> >I think the problem is caused by Mercurial tree changeset 8919 (more
> >likely) or 8918.
> >
> >At least the last tested working one is:
> >changeset:   8917:07c96175a75e
> >user:        Patrick McHardy <kaber@trash.net>
> >date:        Tue Sep 13 21:00:14 2005 +0011
> >summary:     [NETFILTER]: Simplify netbios helper
> >
> >Probably the culprit is:
> >changeset:   8919:61b9c3185973
> >user:        Patrick McHardy <kaber@trash.net>
> >date:        Tue Sep 13 21:00:55 2005 +0011
> >summary:     [NETFILTER]: Fix DHCP + MASQUERADE problem
> 
> Are you sure? The patch was supposed to fix problems with DHCP clients
> using regular UDP sockets for sending DHCP requests. Which client are
> you using?

I tried booting 2.6.14-rc2 on my firewall last Wednesday and it failed
to get its IP address via bootp.  I did not see any packets being
transmitted from the machine.

I was going to do some investigation this weekend until I also found
that it would mean that PCMCIA on the box would be busted, which,
unfortunately, means it's useless to run a later kernel.  Hence the
investigation is shelved until I've sorted out PCMCIA userland.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
