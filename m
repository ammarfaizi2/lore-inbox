Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVJYRhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVJYRhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJYRhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 13:37:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54993 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932233AbVJYRhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 13:37:39 -0400
Message-ID: <435E6D55.7090903@pobox.com>
Date: Tue, 25 Oct 2005 13:37:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Deven Balani <devenbalani@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: reference code for non-PCI libata complaint SATA for ARM	boards.
References: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com> <1130254633.25191.33.camel@localhost.localdomain>
In-Reply-To: <1130254633.25191.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-10-25 at 17:41 +0530, Deven Balani wrote:
> 
>>Hi All!
>>
>>I am currently writing a low-level driver for non-PCI SATA controller
>>in ARM platform.which uses libata-core.c for linux-2.4.25. Can any one
>>tell me any reference code available under linux.
> 
> 
> At the moment its a bit hard to do a non PCI driver because the core
> code assumes that there is a device structure (or pci_dev structure) for
> everything. Fixing that is a two line change for 2.6 (probably similar
> for 2.4) but Jeff Garzik rejected it.

In 2.6.x, libata needs no fixes to support non-PCI devices.

An out-of-tree driver for a non-PCI embedded board exists, and works 
100%.  Use of struct device and dma_xxx() means it is bus-agnostic. 
That's how the whole system was designed to work -- and work, it does.

None of this is true in 2.4.x, of course...

	Jeff


