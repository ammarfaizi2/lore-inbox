Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267483AbRGXMRf>; Tue, 24 Jul 2001 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267486AbRGXMRP>; Tue, 24 Jul 2001 08:17:15 -0400
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:60573 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S267483AbRGXMRI>; Tue, 24 Jul 2001 08:17:08 -0400
To: Dominik Kubla <kubla@sciobyte.de>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: Arp problem
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
	<20010724140916.F31198@intern.kubla.de>
From: Michael Poole <poole@troilus.org>
Date: 24 Jul 2001 08:17:16 -0400
In-Reply-To: <20010724140916.F31198@intern.kubla.de>
Message-ID: <87k80y8qsz.fsf@cj46222-a.reston1.va.home.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dominik Kubla <kubla@sciobyte.de> writes:

> On Tue, Jul 24, 2001 at 02:10:33AM +0100, Paul Jakma wrote:
> 
> > if i have 2 logical subnets on the wire, linux listening on both, is
> > there any way to get linux to fully route packets between the 2
> > subnets?
> > 
> > at the moment it just issues a icmp_redirect, which isn't good enough
> > for certain hosts (eg win9x at least).
> 
> Solaris 8 ditto.
> 
> IMHO this is definitely a linux bug, since the kernel can not now about
> the true network topology: Cable sharing might just be used for this one
> system doing the routing/filtering/whatever between the two networks,
> while all the other hosts are in seperated switch segments. Not a common
> setup but you will see this often enough: head count is already 2... ;-)

This may be a stupid question, but does
  cat 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
help the problem any (for the proper value of "eth0")?  A college
roommate of mine once had the same problem, and clearing
send_redirects for the interface fixed it for him.

-- Michael Poole
