Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVA3Q7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVA3Q7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVA3Q7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:59:44 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:47876
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261733AbVA3Q5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:57:03 -0500
Date: Sun, 30 Jan 2005 08:57:02 -0800
From: Phil Oester <kernel@linuxace.com>
To: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050130165702.GA14642@linuxace.com>
References: <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk> <20050130132343.A25000@flint.arm.linux.org.uk> <20050130153449.B25000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130153449.B25000@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 03:34:49PM +0000, Russell King wrote:
> I think the case against the IPv4 fragmentation code is mounting.
> However, without knowing what the expected conditions for this code,
> (eg, are skbs on the fraglist supposed to have NULL skb->dst?) I'm
> unable to progress this any further.  However, I think it's quite
> clear that there is something bad going on here.

Interesting...the gateway which exhibits the problem fastest in my
area does have a large number of fragmented UDP packets running through it,
as shown by tcpdump 'ip[6:2] & 0x1fff != 0'.

> Why many more people aren't seeing this I've no idea.

Perhaps you (and I) experience more fragments than the average user???

Nice detective work!

Phil
