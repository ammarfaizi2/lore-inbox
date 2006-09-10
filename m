Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWIJQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWIJQCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWIJQCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:02:03 -0400
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:34496 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932271AbWIJQCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:02:02 -0400
Message-ID: <450436F1.8070203@gentoo.org>
Date: Sun, 10 Sep 2006 12:01:53 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, sergio@sergiomb.no-ip.org,
       jeff@garzik.org, greg@kroah.com, cw@f00f.org, bjorn.helgaas@hp.com,
       linux-kernel@vger.kernel.org, harmon@ksu.edu, len.brown@intel.com,
       vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net>	 <1157811641.6877.5.camel@localhost.localdomain>	 <4502D35E.8020802@gentoo.org>	 <1157817836.6877.52.camel@localhost.localdomain>	 <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain>
In-Reply-To: <1157848272.6877.108.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, sorry but I'm still having trouble understanding which aspect of 
my patch you are objecting to. I think I probably misinterpreted one of 
your earlier comments.

My patch included this comment:

> There is still a downside to this patch: if the user inserts a VIA
> PCI card into a VIA-based motherboard, in some circumstances the
> quirk will also run on
> the VIA PCI card. This corner case is hard to avoid.

To which you replied:

> NAK
> 
> This is not a "corner case"
> 
> Very large numbers of VIA mainboards ship with some of the VIA devices
> built in and some of them on the PCI bus. In fact they generally start
> shipped on the board as PCI devices and migrate over time.

and later followed up with:

> If they are on the V-Bus then the IRQ number controls routing if they
> are on the PCI bus the IRQ line controls routing as normal.

The scenario you are talking about there (internal devices on PCI bus vs 
V-bus) is different from the one I was talking about (external VIA-based 
PCI cards going into PCI slots on a VIA-based motherboard).

Regardless of that I tried to piece together what I thought you might be 
trying to say, in order to understand the NAK:

> OK, so per your last mail, most VIA devices start on the PCI bus and
> then later are migrated onto the V-bus.
> 
> Devices on the PCI bus need to be quirked (in some circumstances), as
> when they are on the PCI bus they use the IRQ line for routing, and
> the IRQ line is what the quirk actually modifies.
> 
> V-bus devices do not need the quirk because IRQ routing there is
> handled by IRQ number alone.
> 
> Is the above correct?

And then you replied:

> I've no idea. 

Can you clarify?

Thanks.
Daniel
