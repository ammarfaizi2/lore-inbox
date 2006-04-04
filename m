Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWDDXrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDDXrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWDDXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:47:11 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:33060 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750936AbWDDXrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:47:10 -0400
Date: Tue, 04 Apr 2006 17:45:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: dma_alloc_coherent
In-reply-to: <5XY8B-82x-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Kartik Babu <kbabu@automatika.com>
Message-id: <44330535.2070803@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5XY8B-82x-1@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kartik Babu wrote:
>  I'm trying to replace consistent_alloc in a driver that was written for 
> the 2.4 kernel with dma_alloc_coherent. My question is that I do not use 
> a struct device * pointer at all. Browsing through the source for the 
> 2.6.12
> on ARM XScale PXA255, I see that this argument may be NULL.
> 
> Still, I'd like to know if passing NULL has any side effects. If so, 
> what are they?
> 
> I do however have a cdev structure taht I use for device registration, 
> but I do not see how that would help.

What kind of a device is it? If it's a PCI device, the struct device can 
be accessed with the dev pointer inside the struct pci_dev.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

