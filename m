Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266479AbRGFVjZ>; Fri, 6 Jul 2001 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbRGFVjQ>; Fri, 6 Jul 2001 17:39:16 -0400
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:52463 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S266479AbRGFVjD>;
	Fri, 6 Jul 2001 17:39:03 -0400
Date: Fri, 6 Jul 2001 17:41:46 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: why this 1ms delay in mdio_read?  (cont'd from "are ioctl calls
 supposed  to take this long?")
In-Reply-To: <3B4602BA.91C5DAD3@nortelnetworks.com>
Message-ID: <Pine.LNX.4.10.10107061736000.29374-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Chris Friesen wrote:

> Subject: why this 1ms delay in mdio_read?  (cont'd from "are ioctl calls
    supposed  to take this long?")
> 
> The beginning of mdio_read() in tulip.c goes like this:
> 
> static int mdio_read(struct device *dev, int phy_id, int location)
...
> 	mdelay(1); /* One ms delay... */

Ackkk!  What driver version?
And who put this bogus delay in the code?

Putting arbitrary delays in drivers is usually a sign that the someone
didn't understand how to fix a bug and is just trying to wait it out.

> The chip I'm using is the DEC 21143, which means that we skip over the two
> conditional blocks, so the first thing that happens when we call this is to
> wait around doing nothing for a millisecond.  Is there some subtle
> reason why we would want to wait around for a millisecond before doing
> anything? 

Nope.  None at all.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

