Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTGHMyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTGHMyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:54:00 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:39821 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262073AbTGHMxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:53:54 -0400
Date: Tue, 8 Jul 2003 15:10:48 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: vincent.touquet@pandora.be, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030708131047.GG14044@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030708101950.GB14044@ns.mine.dnsalias.org> <200307080959.54247.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307080959.54247.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:59:54AM -0400, joe briggs wrote:
>Vincent - 
>I wonder if what is really happening is a problem in the in the arbitration 
>between the PCI bus and the local bus that the onboard IDE devices are.  In 
>your case the problem (onboard IDE device data corruption) manifests when you 
>are performing sustained transfers (large files) between the onboard IDE 
>device and a PCI block device (the 3ware RAID).

Yes, that seems very feasible.

>In my case, the same problem 
>manifests when I have sustained data activity from multiple frame grabbers to 
>memory, then from memory to RAID.  When the system drive is used (code load, 
>swap, etc.) it gets corrupted.  My point is, the onboard data device only 
>seems to get corrupted when there is lots of i/o activity with PCI 
>bus-masters that are DMA'ing data to/from memory.  What do you think?

I had the same lockups too when pumping a lot of data over the network
onto the array on a similar mainboard (Tyan S2468). So maybe there is
the added problem that there is funny things going on on the PCI bus.
Maybe the problem only occurs when you stress the bus and the dma is not
the real culprit, it just enables high transfers and hence corruption on
the PCI bus.

I would very much like to nail this one down, as its nasty.

regards,

v
