Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKQJtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKQJtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKQJtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:49:40 -0500
Received: from [85.8.13.51] ([85.8.13.51]:5021 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750718AbVKQJtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:49:40 -0500
Message-ID: <437C5237.3080008@drzeus.cx>
Date: Thu, 17 Nov 2005 10:49:43 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.6a1 (X11/20051022)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IOMMU and scatterlist limits
References: <437C40AE.2020309@drzeus.cx> <20051117085432.GY7787@suse.de> <437C4728.9060205@drzeus.cx> <20051117091308.GZ7787@suse.de> <437C4D14.1030101@drzeus.cx> <20051117093848.GA7787@suse.de>
In-Reply-To: <20051117093848.GA7787@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 17 2005, Pierre Ossman wrote:
>   
>> Ok. Being a block device, the segments are usually rather large so the
>> overhead of setting up many DMA transfers shouldn't be that terrible.
>>     
>
> The segments will typically be paged size, so could be worse. It all
> depends on what your command overhead is like whether it hurts
> performance a lot or not.
>
>   

MMC overhead is a lot larger than sending new addr/len tuples to the 
hardware. So I suppose there is performance to be gained by iterating 
over the segments inside the driver.

Thanks for clearing things up. Maybe someone could update 
DMA-mapping.txt with the things you've explained to me here *hint* ;)

Rgds
Pierre

