Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSITRMa>; Fri, 20 Sep 2002 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbSITRMa>; Fri, 20 Sep 2002 13:12:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6163 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263137AbSITRM2>;
	Fri, 20 Sep 2002 13:12:28 -0400
Message-ID: <3D8B580D.9030009@mandrakesoft.com>
Date: Fri, 20 Sep 2002 13:17:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: thunder@lightweight.ods.org, linux-kernel@vger.kernel.org
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
References: <MNEMKBGMDIMHCBHPHLGPMEEDDDAA.dag@brattli.net> <20020920171314.GD8260@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Fri, Sep 13, 2002 at 08:25:50AM +0200, Dag Brattli wrote:
> 
>>-----Original Message-----
>>From: Thunder from the hill [mailto:thunder@lightweight.ods.org]
>>Sent: 12. september 2002 22:17
>>To: Bob_Tracy
>>Cc: dag@brattli.net; linux-kernel@vger.kernel.org
>>Subject: Re: 2.5.34: IR __FUNCTION__ breakage
>>
>>
>>Hi,
>>
>>On Thu, 12 Sep 2002, Bob_Tracy wrote:
>>
>>>define DERROR(dbg, args...) \
>>>	{if(DEBUG_##dbg){\
>>>		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__);\
>>>		printk(KERN_INFO args);}}
>>>
>>>which strikes me as not quite what the author intended, although it
>>>should work.
>>
>>Why not
>>
>>#define DERROR(dbg, fmt, args...) \
>>	do { if (DEBUG_##dbg) \
>>		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION, args); \
>>	} while(0)
>>
>>?
>>
>>			Thunder
> 
> 
> 	Try it, it won't work when there is zero args.


I fixed up a bunch of these __FUNCTION__ breakage, you can grab them 
from 2.5.37 (just released)

Also, specifically relating to varargs macros as described above, you 
can certainly have a varargs macro with zero args, just look at C99 
varargs macros...

	Jeff



