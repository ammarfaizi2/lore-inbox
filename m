Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVBHIUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVBHIUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVBHIUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:20:40 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28088 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261480AbVBHIUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:20:31 -0500
Message-ID: <420876DC.3040201@jp.fujitsu.com>
Date: Tue, 08 Feb 2005 17:22:52 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCI Error reporting & recovery
References: <1107835865.7687.78.camel@gaston>
In-Reply-To: <1107835865.7687.78.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ben.

How kind of you to remember.

Benjamin Herrenschmidt wrote:
> I was reading the list archives for the discussion back in September
> about PCI error reporting. Has there been any further progress on this
> since then ?

Now I have a rewrite of the previous "clear/read_pci_errors" patch.
The new one adopts iomap infrastructure, considering generality,
capability and so on. And the part of its implementation for IA64 is
now under test using converted SCSI/NIC drivers.

Soon I'll post the patch to lkml(+IA64ML) with some explanation of the
change and the result of test, and will beg/hear comments.

> I'm looking into adapting something for the need of ppc64 as well
> (which, btw, has 1 slot = 1 bridge on most cases, but not all of them :)
> which uses quite different low level mecanisms. (Basically, we have to
> go through the firmware to get to the errors).
> 
> Also, our bridges are automatically isolating slots that had any error
> on them (including DMA) and we have the ability to recover, by
> triggering a reset on a given segment and that sort of thing, for which
> I would like to provide dirvers with an API to control as well.
> 
> Finally, I was thinking about some richer semantics for the error
> themselves. For example, on DMA error, we can sometimes get good details
> about the faulting address etc... which may be intersting for the driver
> to log, for diagnostic purpose at least.

Interesting.
Actually I don't have enough knowledge about platforms other than IA32/64,
so it will be helpful if you could tell me practical matters about ppc64
etc.

> So I'd like to start from what you did back then and discuss possible
> APIs for the above ideas / changes. What is the status of that stuff ?
> did it evolve since then ?

It goes slowly but steadily...
I'd also like to start the discussion about PCI error reporting again.


Thanks,
H.Seto

