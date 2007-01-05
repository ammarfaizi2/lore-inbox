Return-Path: <linux-kernel-owner+w=401wt.eu-S1750912AbXAEX50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXAEX50 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 18:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXAEX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 18:57:26 -0500
Received: from iabervon.org ([66.92.72.58]:4246 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbXAEX50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 18:57:26 -0500
Date: Fri, 5 Jan 2007 18:57:24 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Roland Dreier <rdreier@cisco.com>
cc: Petr Vandrovec <petr@vandrovec.name>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Unbreak MSI on ATI devices
In-Reply-To: <ada4pr61mie.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0701051847310.20138@iabervon.org>
References: <20061221075540.GA21152@vana.vc.cvut.cz> <ada4pr61mie.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Roland Dreier wrote:

>  > So my question is - what is real reason for disabling INTX when in MSI mode?
>  > According to PCI spec it should not be needed, and it hurts at least chips
>  > listed below:
>  > 
>  > 00:13.0 0c03: 1002:4374 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
>  > 00:13.1 0c03: 1002:4375 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
>  > 00:13.2 0c03: 1002:4373 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller 
> 
> heh... I'm not gloating or anything... but I am glad that some ASIC
> designer was careless enough to prove me right when I said going
> beyond what the PCI spec requires is dangerous.

No more dangerous than expecting exactly following the PCI spec to be 
sufficient; at least some nVidia devices misbehave if you don't disable 
INTx when using MSI, while at least some ATI devices misehave if you do 
disable INTx. The only *safe* thing is to ignore the PCI spec and match 
the behavior of Windows. In this case, that's just don't use MSI yet.

Of course, this should be relatively easy to handle with quirks, 
especially if it's predictable which hardware bug you get from the vendor 
id.

	-Daniel
*This .sig left intentionally blank*
