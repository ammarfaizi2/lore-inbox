Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbUKSP6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbUKSP6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUKSP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:58:53 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:7396 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261448AbUKSP5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:57:50 -0500
Message-ID: <419E17FF.1000503@free.fr>
Date: Fri, 19 Nov 2004 16:57:51 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr>
In-Reply-To: <419E16E5.1000601@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Meelis Roos wrote:
> 
>> mc> try to do an "echo auto > /sys/bus/pnp/device_number/resources"
>> mc> mc> It will reenable the device.
>>
>> I tried this on my Toshiba Satellite 1800-314 and the device gets IO
>> resources but is still disabled. echo activate > ... will enable it but
>> the smc-ircc2 driver still finds that the device is disabled (in
>> 2.6.10-rc2+yesterdays BK):
>>
>> nartsiss:~# cat /sys/bus/pnp/devices/00\:0a/options
>> Dependent: 01 - Priority acceptable
>>    port 0x3f8-0x3f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 02 - Priority acceptable
>>    port 0x2e8-0x2e8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 03 - Priority acceptable
>>    port 0x2f8-0x2f8, align 0x0, size 0x8, 16-bit address decoding
>> Dependent: 04 - Priority acceptable
>>    port 0x3e8-0x3e8, align 0x0, size 0x8, 16-bit address decoding
> 
> that's very strange : you must have 2 io entries, 1 dma entry and an irq 
> entry.
> Could you try pnpacpi from mm series ?
no need : it is in rc2.
So do you use pnpacpi ?
If so, could you send your dsdt and try with pnpbios?

Matthieu
