Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292629AbSBUD3X>; Wed, 20 Feb 2002 22:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSBUD3F>; Wed, 20 Feb 2002 22:29:05 -0500
Received: from smtp.comcast.net ([24.153.64.2]:62612 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S292629AbSBUD2o>;
	Wed, 20 Feb 2002 22:28:44 -0500
Date: Wed, 20 Feb 2002 21:20:22 -0500
From: Mike Phillips <phillim2@comcast.net>
Subject: Re: [PATCH] New driver 3Com 3C359 Tokenring Velocity XL
In-Reply-To: <3C73CF85.E3DA3943@mandrakesoft.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Reply-to: mikep@linuxtr.net
Message-id: <20020221022022.GA3650@comcast.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.27i
In-Reply-To: <Pine.LNX.4.10.10202181451060.4149-100000@www.linuxtr.net>
 <3C73CF85.E3DA3943@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff: 

> Comments:
> 1) buggy use of PCI DMA API -- you should use memory returned from
> pci_alloc_consistent, do not directly map memory created by
> alloc_trdev() nor depend on the alignment returned by alloc_trdev()
 
The driver doesn't map any of the ->priv structure, the comment in the
code is a left over from when it did. The priv strcture just has
pointers to the memory areas (which are kmalloc'ed and mapped). 
I should probably change the allocations to pci_alloc_consistent 
from their current map_single as well. 

All other comments taken on board, will be included in the next
update.

> Overall... good job, it's a readable, clean driver.
> 
Thanks, these things do get a little easier each time you do one (esp.
once you've figured out which planet the hardware designers and tech
doc writers live on :)
-- 
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net
mailto: mikep@linuxtr.net

