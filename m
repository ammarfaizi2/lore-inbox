Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULHVeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULHVeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbULHVeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:34:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:58301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbULHVeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:34:00 -0500
Date: Wed, 8 Dec 2004 13:33:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: FoObArf00@netscape.net
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IGMP packets?
Message-ID: <20041208133359.Z2357@build.pdx.osdl.net>
References: <00640596.1F2101FF.023DF18B@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00640596.1F2101FF.023DF18B@netscape.net>; from FoObArf00@netscape.net on Wed, Dec 08, 2004 at 03:58:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* FoObArf00@netscape.net (FoObArf00@netscape.net) wrote:
> I have 3 machines.  A (eth0) is connected to B (eth1) with a cross over
> cable and B (eth0) and C (eth0) are on a switch.  I want to forward the
> igmp queries and reports that A (eth1) generates when joining/leaving a
> multicast group on B (eth1) from B(eth0) to C (eth0).  I put the code to
> do this on different places such as ip_rcv, ip_route_input, etc and no
> luck.  The weird thing is that it works when I do a tcpdump on B's eth1.

Sounds like B(eth1) is filtering the packets.  Does it also work if you
enable IFF_ALLMULTI on eth1 (instead of IFF_PROMISC)?  Also, what kernel
are you using?  Does a group join on A generate a v1 or v3 report?

thanks,
-chris
