Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265359AbUFBIsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUFBIsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUFBIsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:48:33 -0400
Received: from [213.239.201.226] ([213.239.201.226]:9685 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265359AbUFBIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:48:30 -0400
Message-ID: <40BD95EB.40506@shadowconnect.com>
Date: Wed, 02 Jun 2004 10:55:07 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com>
In-Reply-To: <40BD1211.9030302@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
>>>> could someone help me with a ioremap problem. If there are two 
>>>> controllers plugged in, the ioremap request for the first controller 
>>>> is successfull, but the second returns NULL. Here is the output of 
>>>> the driver:
>>>> i2o: Checking for PCI I2O controllers...
>>>> i2o: I2O controller on bus 0 at 72.
>>>> i2o: PCI I2O controller at 0xD0000000 size=134217728
>>>> I2O: MTRR workaround for Intel i960 processor
>>>> i2o/iop0: Installed at IRQ17
>>>> i2o: I2O controller on bus 0 at 96.
>>>> i2o: PCI I2O controller at 0xD8000000 size=134217728
>>>> i2o: Unable to map controller.
>>> probably too large an area to be remapping.  Try remapping only the
>>> memory area needed, and not the entire area.
>> Is there a way, to increase the size, which could be remapped, or is 
>> there a way, to find out what is the maximum size which could be 
>> remapped?
> My preferred approach would be:  consider that the hardware does not 
> need the entire 0x8000000-byte area mapped.  Plain and simple.
> This is a "don't do that" situation, and that renders the other 
> questions moot :)  You should only be mapping what you need to map.

Okay, i'll let try it out with only 64MB.

Thanks again for your help!


Best regards,



Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
