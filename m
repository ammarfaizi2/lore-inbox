Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935057AbWK1DgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935057AbWK1DgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 22:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935059AbWK1DgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 22:36:21 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:21432 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S935057AbWK1DgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 22:36:20 -0500
Message-ID: <456BAEB0.5030800@vertical.com>
Date: Mon, 27 Nov 2006 22:36:16 -0500
From: Jon Ringle <jringle@vertical.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reserving a fixed physical address page of RAM.
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no> <456B8517.7040502@shaw.ca>
In-Reply-To: <456B8517.7040502@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jon Ringle wrote:
>> Hi,
>>
>> I need to reserve a page of memory at a specific area of RAM that will
>> be used as a "shared memory" with another processor over PCI. How can I
>> ensure that the this area of RAM gets reseved so that the Linux's memory
>> management (kmalloc() and friends) don't use it?
>>
>> Some things that I've considered are iotable_init() and ioremap().
>> However, I've seen these used for memory mapped IO devices which are
>> outside of the RAM memory. Can I use them for reseving RAM too?
>>
>> I appreciate any advice in this regard.
>
> Sounds to me like dma_alloc_coherent is what you want..
>
It looks promising, however, I need to reserve a physical address area 
that is well known (so that the code running on the other processor 
knows where in PCI memory to write to). It appears that 
dma_alloc_coherent returns the address that it allocated. Instead I need 
something where I can tell it what physical address and range I want to use.

Jon
