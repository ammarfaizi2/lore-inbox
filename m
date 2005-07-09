Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263086AbVGIC6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVGIC6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVGIC6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:58:02 -0400
Received: from bay20-f7.bay20.hotmail.com ([64.4.54.96]:19539 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263086AbVGIC6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:58:00 -0400
Message-ID: <BAY20-F7DB5F47EFD2E102B0FFD2C4DA0@phx.gbl>
X-Originating-IP: [65.64.155.98]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <20050709005638.GE21330@wotan.suse.de>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Date: Fri, 08 Jul 2005 22:57:58 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 Jul 2005 02:57:59.0421 (UTC) FILETIME=[03A392D0:01C58432]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you know if there is a way to tell the ehci driver to do the DMA at a 
lower memory address?  i.e. tell the kernel to reserve a block of memory (as 
a boot option) and then tell the ehci driver to use that area of RAM 
instead?

Thanks again for your help,

Jon

>From: Andi Kleen <ak@suse.de>
>To: Jon Schindler <jonschindler@hotmail.com>
>CC: ak@suse.de, linux-kernel@vger.kernel.org
>Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of 
>RAM
>Date: Sat, 9 Jul 2005 02:56:38 +0200
>
>On Fri, Jul 08, 2005 at 08:49:12PM -0400, Jon Schindler wrote:
> > Hi Andi,
> >
> > As you suggested, removing ehci_hcd (using rmmod ehci_hcd) allows the 
>USB
> > storage device to work.  So, to answer your question, yes, the ohci_hcd
> > driver does work with 3GB's of RAM.  Still, knoppix 3.9 IS able to work
> > with both ehci and 3GB's of RAM, so it still sounds like it's a software
> > problem, not an nvidia hardware issue.
>
>Knoppix is 32bit I guess. The 32bit kernel will do a lot of DMA
>only in the first 800-900MB (lowmem)
>
>-Andi
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


