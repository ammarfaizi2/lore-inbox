Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVGIAxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVGIAxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVGIAvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:51:38 -0400
Received: from bay20-f7.bay20.hotmail.com ([64.4.54.96]:2153 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263059AbVGIAtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:49:35 -0400
Message-ID: <BAY20-F7EE6B3C3A0E5C80A183D7C4DA0@phx.gbl>
X-Originating-IP: [65.64.155.98]
X-Originating-Email: [jonschindler@hotmail.com]
In-Reply-To: <p734qb5p04e.fsf@verdi.suse.de>
From: "Jon Schindler" <jonschindler@hotmail.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of RAM
Date: Fri, 08 Jul 2005 20:49:12 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 Jul 2005 00:49:13.0596 (UTC) FILETIME=[06B03BC0:01C58420]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

As you suggested, removing ehci_hcd (using rmmod ehci_hcd) allows the USB 
storage device to work.  So, to answer your question, yes, the ohci_hcd 
driver does work with 3GB's of RAM.  Still, knoppix 3.9 IS able to work with 
both ehci and 3GB's of RAM, so it still sounds like it's a software problem, 
not an nvidia hardware issue.

Jon

>From: Andi Kleen <ak@suse.de>
>To: "Jon Schindler" <jonschindler@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: USB storage does not work with 3GB of RAM, but does with 2G of 
>RAM
>Date: 08 Jul 2005 21:29:37 +0200
>
>"Jon Schindler" <jonschindler@hotmail.com> writes:
> >
> > This mainly seems to be an issue with USB mass storage devices like
> > USB memory sticks and USB hard drives (I've tried both, and neither is
> > assigned a scsi device properly).  I am still able to use my USB mouse
> > when I have 3GB installed.  I'm not sure if that makes it a USB 1.1
> > issue or a USB storage issue, but hopefully someone will have some
> > insight after looking at the logs.  Thanks in advance for any help.
>
>It sounds like the Nvidia EHCI controller has trouble DMAing to high
>addresses. Would be a bad bug if true.
>
>Does it work when you disable EHCI and only enable OHCI? (this will
>limit you to USB 1.1)
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


