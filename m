Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUIPJ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUIPJ3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIPJ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:29:50 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:31396 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S267880AbUIPJ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:29:47 -0400
X-BrightmailFiltered: true
Message-Id: <5.1.0.14.2.20040916192213.04240008@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 16 Sep 2004 19:29:43 +1000
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: The ultimate TOE design
Cc: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
In-Reply-To: <4148B2E5.50106@pobox.com>
References: <20040915141346.5c5e5377.davem@davemloft.net>
 <4148991B.9050200@pobox.com>
 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
 <1095275660.20569.0.camel@localhost.localdomain>
 <4148A90F.80003@pobox.com>
 <20040915140123.14185ede.davem@davemloft.net>
 <20040915210818.GA22649@havoc.gtf.org>
 <20040915141346.5c5e5377.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not that i disagree with the general idea and rationale, but reality is 
what it is today for some reasons:

At 07:23 AM 16/09/2004, Jeff Garzik wrote:
>         Jeff, who would love to have a bunch of Athlons
>         on PCI cards to play with.

. . . this ignore the realities of power restrictions of PCI today . . .
sure, one could create a PCI card that takes a power-connector, but that 
don't scale so well either . . .

At 07:29 AM 16/09/2004, David S. Miller wrote:
>I think a better goal is "offload 90+% of the net stack cost" which
>is effectively what TSO does on the send side.
>
>This is why these discussions are so circular.

TSO works on LAN-like environments (zero latency, minimal drop), it doesn't 
work so well across the internet . . .

i believe that there are better alternatives than TSO, but it involves NICs 
having decent scatter-gather DMA engines and being able to be handled 
multiple transactions (packets/frames) at once.
in theory, NICs like tg2/tg3 should be capable of implementing something 
like this -- if one could get to the ucode on the embedded cores.


at least with PCI Express the general architecture of a PC starts to have a 
hope of keeping up with Moore's law.
the same couldn't be said prior to DDR-SDRAM and higher front-side-bus 
frequencies.


cheers,

lincoln.

