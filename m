Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSLEAr7>; Wed, 4 Dec 2002 19:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSLEAr7>; Wed, 4 Dec 2002 19:47:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57348 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267164AbSLEAr6>;
	Wed, 4 Dec 2002 19:47:58 -0500
Message-ID: <3DEEA3E0.2000306@pobox.com>
Date: Wed, 04 Dec 2002 19:54:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <200212041747.gB4HlEF03005@localhost.localdomain> <20021205004744.GB2741@zax.zax>
In-Reply-To: <20021205004744.GB2741@zax.zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Wed, Dec 04, 2002 at 11:47:14AM -0600, James Bottomley wrote:
>>The new DMA API allows a driver to advertise its level of consistent memory 
>>compliance to dma_alloc_consistent.  There are essentially two levels:
>>
>>- I only work with consistent memory, fail if I cannot get it, or
>>- I can work with inconsistent memory, try consistent first but return 
>>inconsistent if it's not available.
> 
> 
> Do you have an example of where the second option is useful?  Off hand
> the only places I can think of where you'd use a consistent_alloc()
> rather than map_single() and friends is in cases where the hardware's
> behaviour means you absolutely positively have to have consistent
> memory.


agreed, good catch.  Returning inconsistent memory when you asked for 
consistent makes not much sense:  the programmer either knows what the 
hardware wants, or the programmer is silly and should not be using 
alloc_consistent anyway.


