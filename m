Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbQJaSXq>; Tue, 31 Oct 2000 13:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130332AbQJaSXg>; Tue, 31 Oct 2000 13:23:36 -0500
Received: from 041imtd118.chartermi.net ([24.247.41.118]:29176 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S129041AbQJaSX3>; Tue, 31 Oct 2000 13:23:29 -0500
Date: Tue, 31 Oct 2000 13:23:06 -0500
From: Simon Kirby <sim@stormix.com>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100: card reports no resources [was VM-global...]
Message-ID: <20001031132306.A24147@stormix.com>
In-Reply-To: <20001026193508.A19131@niksula.cs.hut.fi> <20001030142356.A3800@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001030142356.A3800@saw.sw.com.sg>; from saw@saw.sw.com.sg on Mon, Oct 30, 2000 at 02:23:56PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 02:23:56PM +0800, Andrey Savochkin wrote:

> > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > > 
> > > let me guess: intel eepro100 or similar??
> > > Well known problem with that one. dont know if its fully fixed ... With
> > 
> > Happens here too, with 2xPPro200, 2.2.18pre17, Eepro100 and light load.
> > The network stalls for several minutes when it happens.
> > 
> > > 2.4.0-test9-pre3 it doesnt happen on my machine ...
> > 
> > What about a fix for a 2.2.x...?
> 
> The exact reason for this problem is still unknown.

We were seeing this on a firewall a week or so ago -- it was actually
coming from some sort of arp flood/loop on the uplink not being caused by
us, and the speed of the incoming arp packets would cause these messages
to occur.

We tried ifconfig up/down, warm reboot, cold reboot, power cycle, card
swapping, and the messages continued.  We stopped the card with a 3c905
and the messages stopped, but "ifconfig" showed Rx overruns at about the
same frequency as the messages used to occur.  This is probably another
way to trigger this error than what most people are seeing.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
