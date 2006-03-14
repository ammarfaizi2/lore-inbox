Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWCNILR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWCNILR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWCNILQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:11:16 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:52107 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751600AbWCNILQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:11:16 -0500
Message-ID: <44167AA3.8000607@drzeus.cx>
Date: Tue, 14 Mar 2006 09:11:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: John Ronciak <john.ronciak@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: Re: e1000 with serdes only shows a fiber port
References: <44157178.90507@drzeus.cx> <56a8daef0603131430x8fd17fbn4aa5b5082e8aad0e@mail.gmail.com>
In-Reply-To: <56a8daef0603131430x8fd17fbn4aa5b5082e8aad0e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Ronciak wrote:
> On 3/13/06, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>   
>> Hi!
>>
>> I'm having problems with the e1000 card in a Dell Poweredge 1855. This
>> model has support for both copper and fiber and has two cards on the PCI
>> bus (might supposed to be one for each type).
>>     
>
> If it's a blade server blade then it's really not fiber or copper
> (i.e. no PHY), it's a serdes connection to the backplane in the blade
> server.  I have never seen one of these not always have link (if the
> blade is plugged into the backplane it must have link).
>
> So what versions of things are you running?  OS? Driver?  Version
> number of the blade?  BIOS (must have the latest)?  Windows doesn't
> use the BIOS but does everything itself regarding HW setup.
>   

I have tried Linux 2.6.11 and 2.6.15. I've also tried the independent
variant of the driver, version 6.3.9 and 7.0.33. We've also tried Dell's
version for RHEL4 (5.7.6.1).

BIOS has been confirmed to be the latest version.

> Did you go back to Dell for support on this?  What did they say?  Are
> you using a version of Linux that Dell supports on this hardware? 
>   

We haven't contacted Dell at this point no. Partly because we run Fedora
Core and not one of the supported dists (this will be a terminal server
so we want a more recent desktop on it).

> There might need to be some special drivers that are needed which Dell
> supplies with their versions for specific HW.  I'm not a blade server
> expert but I've seen things like this before.
>
> One suggestion is to disable auto-negotiation and force the link to 1
> gigabit full duplex to see what that does.
>
>   

We started doing this and discovered that the card started working when
we plugged it into a gigabit port (copper). ethtool still says fiber
though. So the immediate panic has settled. :)

It would still be nice to plug this into a 100 Mbps port since the
gigabit ports are a bit scarce.

Rgds
Pierre

