Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVDNSBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVDNSBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVDNSBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:01:06 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:57140 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261564AbVDNSBB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:01:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IcoAE9OQwY1pd/JXAJEpqVnXkNEiTudfaKrRoji8T53lYPhqWWn2ivzrmu7lkdbl/ZRIDgHDyxdoZwsfwQa3GJAmrejbZnkX9aH/VR5m6BR6X+nPcPiT9WDvoSWrX4TjFTw5sCycIJfvM4aVHgJxkSnzS1nude4fkJ9HKH0B9ho=
Message-ID: <5fc59ff305041411013fd35ed4@mail.gmail.com>
Date: Thu, 14 Apr 2005 11:01:01 -0700
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
Cc: "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <42431734.3030905@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42421FF2.7050501@candelatech.com>
	 <20050324081003.GA23453@xi.wantstofly.org>
	 <42431734.3030905@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben:

Have you checked if the BIOS on the super micro machine is the latest
and greatest. I have had interrupt routing issues very similar to the
one you are describing due to a BIOS Interrupt Routing issue. Moving
to newer BIOS fixed it.

ganesh.

On 3/24/05, Ben Greear <greearb@candelatech.com> wrote:
> Lennert Buytenhek wrote:
> > On Wed, Mar 23, 2005 at 06:03:30PM -0800, Ben Greear wrote:
> >
> >
> >>I have two 4-port e1000 NICs in the system, on a riser card.
> >
> >
> > How is the riser card wired?  F.e. does it have a single edge
> > connector, and provides two PCI slots, or does it have a tiny
> > additional edge connector that routes REQ#/GNT#/INTx from a
> > nearby PCI slot, etc.?
> 
> I was able to reproduce the problem even when the 4-port e1000 NIC
> is plugged directly into the motherboard, so it's not the
> riser...
> 
> I also tried with a 4-port VIA-Rhine NIC (router-board 44).  It also
> fails it's third interface, with the same problem.  So, it is not
> the e1000 NIC nor the e1000 driver that is the problem.
> 
> I do notice that it is the same interrupt (26) that is always assigned
> to the broken port.  I have the lspci and dmesg output for the via-rhine
> boot if anyone wants it...
> 
> Ben
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 
>
