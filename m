Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSFXPcI>; Mon, 24 Jun 2002 11:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFXPcH>; Mon, 24 Jun 2002 11:32:07 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:50442 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S312973AbSFXPcE>;
	Mon, 24 Jun 2002 11:32:04 -0400
Message-ID: <3D173BA7.1040801@si.rr.com>
Date: Mon, 24 Jun 2002 11:32:55 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c
References: <Pine.LNX.4.44.0206240929080.2603-100000@netfinity.realnet.co.sz> <3D1733EB.6090502@si.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane,
     I agree, although eventually I envision the code to look like...

  if(pci_set_dma_mask(pdev, 0xffffffff))
  {
  printk(KERN_WARNING "defxx : No suitable DMA available\n");
  // Add appropriate action, such as
  // goto err_dma_exit;
  // OR
  return -ENOMEM;
  }

  Thats why I have the braces (multiple statements).

  Regards,
  Frank

> Zwane Mwaikambo wrote:
> 
>> On Sun, 23 Jun 2002, Frank Davis wrote:
>>
>>
>>> -
>>> +    if(pci_set_dma_mask(pdev, 0xffffffff))
>>> +    {
>>> +        printk(KERN_WARNING "defxx : No suitable DMA available\n");
>>> +    }
>>
>>
>>
>> Minor nit,
>>     CodingStyle prefers this style;
>>
>>     if (pci_set_dma_mask(pdev, 0xffffffff))
>>         printk(KERN_WARNING "defxx : No suitable DMA available\n");
>>
>> Thanks,
>>     Zwane Mwaikambo
>>
> 
> 


