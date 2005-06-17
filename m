Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVFQHfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVFQHfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 03:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVFQHfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 03:35:54 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:22533 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261904AbVFQHfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 03:35:47 -0400
Message-ID: <42B27D51.4040407@superbug.demon.co.uk>
Date: Fri, 17 Jun 2005 08:35:45 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
References: <42B1FF2A.2080608@superbug.demon.co.uk> <20050617014820.GA15045@animx.eu.org>
In-Reply-To: <20050617014820.GA15045@animx.eu.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> James Courtier-Dutton wrote:
> 
>>I am trying to write a Linux ALSA driver for the Creative Audigy 2 NX
>>Notebook PCMCIA card.
>>This is a cardbus card, that uses ioports.
>>When it is inserted into the laptop, the entry appears in "lspci -vv "
>>showing ioports used by the card.
>>As soon as my driver uses "outb()" to anything in the address range
>>shown in "lspci -vv" , the PC hangs.
>>
>>I can only conclude from this that ioport resources are not being
>>allocated correctly to the PCMCIA card.
>>
>>Can anybody help me track this down. If someone could tell me which
>>PCMCIA and PCI registers should be set for it to work, I could then find
>>out which pcmcia registers have not been set correctly, and fix the bug.
>>
>>It seems that the PCMCIA specification is not open and free, so I cannot
>>refer to it in order to fix this myself.
> 
> 
> I thought drivers for the cardbus cards were the same as standard PCI cards. 
> I know that as far as networking goes, the same driver runs a cardbus 3com
> 3c575 and the pci 3c905.  Same with netgear's cardbus FA510 and PCI FA310.
> 
> I'm not a kernel developer, but this is what I've understood.
> 

That is also what I thought. But I think that the cardbus 3com 3c575
uses memory for io and not ioports. I think the problem is related to
the use of ioports on an cardbus card.


