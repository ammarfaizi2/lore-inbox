Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSFXGsD>; Mon, 24 Jun 2002 02:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSFXGsC>; Mon, 24 Jun 2002 02:48:02 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:32786 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317423AbSFXGsA>;
	Mon, 24 Jun 2002 02:48:00 -0400
Message-ID: <3D16C0D2.7030501@si.rr.com>
Date: Mon, 24 Jun 2002 02:48:50 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/scsi/inia100.c
References: <Pine.LNX.4.44.0206232343280.909-100000@localhost.localdomain> <20020624083036.A22534@fafner.intra.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois,
     Yes, I'm aware of the DMA mapping and pci_set_dma_mask() options. 
As I stated, this is just the 1st patch for the DMA code. The 
"interesting" parts will be included in a future patch (possibly by the 
driver developers), as well as appropriate option for pci_set_dma_mask() 
such as returning an error code or jumping to some code to return. This 
goes for all of my recent DMA patches.
Regards,
Frank

Francois Romieu wrote:
> Greetings,
> 
> Frank Davis <fdavis@si.rr.com> :
> 
>>Hello all,
>>  This patch adds the DMA mapping check (1st step for 
>>Documentation/DMA-mapping.txt compliance). Please review.
> 
> 
> - please take a look at Documentation/CodingStyle
> - if pci_set_dma_mask() fails, the driver shouldn't go on as if nothing 
>   happened. See what other drivers do (net/acenic.c for example)
> - the interesting part of DMA mapping conversion is more a matter of
>   memory descriptor handling (and phys_to_virt/friends removal)
> 


