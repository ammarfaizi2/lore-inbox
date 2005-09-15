Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVIORLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVIORLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVIORLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:11:11 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:969 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030530AbVIORLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:11:09 -0400
Message-ID: <4329A885.3010409@linuxtv.org>
Date: Thu, 15 Sep 2005 20:59:49 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <200509151148.57779@bilbo.math.uni-mannheim.de> <4329877A.4090809@linuxtv.org> <200509151658.01793@bilbo.math.uni-mannheim.de>
In-Reply-To: <200509151658.01793@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:

>Manu Abraham wrote:
>
>  
>
>>So it now looks like this but i have another problem now, after
>>consecutive, load/unload, i get an oops ..
>>    
>>
>
>No idea, sorry.
>
>  
>
>>static int __devinit mantis_pci_probe(struct pci_dev *pdev,
>>               const struct pci_device_id *mantis_pci_table)
>>{
>>   u8 revision, latency;
>>//    u8 data[2];
>>   struct mantis_pci *mantis;
>>
>>   dprintk(verbose, MANTIS_ERROR, 1, "<1:>IRQ=%d", pdev->irq);
>>   if (pci_enable_device(pdev)) {
>>       dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
>>       goto err;
>>   }
>>   dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=%d", pdev->irq);
>>
>>   mantis = (struct mantis_pci *)
>>               kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
>>    
>>
>
>mantis = kmalloc(sizeof(*mantis), GFP_KERNEL);
>
>You don't have to cast a void* to any other pointer and this way you will 
>always get the correct size of memory allocated, even if mantis will become 
>another pointer type.
>
>  
>
Thanks i will keep it in mind, while i get on with the rest. Stuck on 
with the Oops at the moment.
FIrst load unload seems to be okay, second one also, but sometimes it is 
the 3rd load, or sometimes it is the unload ..

Sounds a bit weird also ..


Thanks,
Manu


