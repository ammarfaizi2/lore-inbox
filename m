Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbUKJPTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbUKJPTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUKJPSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:18:41 -0500
Received: from ptr-207-54-98-202.ptr.terago.ca ([207.54.98.202]:32014 "EHLO
	nagios.knad.ca") by vger.kernel.org with ESMTP id S261843AbUKJPPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:15:55 -0500
Message-ID: <4192308C.3060100@kuehne-nagel.com>
Date: Wed, 10 Nov 2004 08:15:24 -0700
From: Robert Toole <robert.toole@kuehne-nagel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IT8212 in 2.6.9-ac6 no raid 0 or raid 1
References: <418FE1B3.8020203@kuehne-nagel.com> <1099956451.14146.4.camel@localhost.localdomain>
In-Reply-To: <1099956451.14146.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> On Llu, 2004-11-08 at 21:14, Robert Toole wrote:
> 
>>Alan, thanks for your work on the ITE8212 controllers.
>>
>>Just tried your ac-6 patch for 2.6.9 on my embedded Raid controller. 
>>with the controller set up in normal (No raid mode) everything is good.
>>
>>When I try raid 0 or 1, I get the INVALID GEOMETRY: 0 PHYSICAL HEADS? 
>>error, and the raid device is not accessible after boot.
> 
> 
> RAID needs -ac7 which I'll post tomorrow. Bartlomiej found a bug in the
> -ac7 draft code when I submitted it for 2.6.10rc merging so it slipped a
> day.
> 
> Alan
> 
> 
I installed -ac7 yesterday, and have been testing for 24 hours now with 
no problems. (It's way better than the scsi hack from ITE) There is just 
one thing, the driver did not enable DMA by default, needless to say 
performance was awful. I turned it on with hdparm and everything appears 
ok. Is this by design due to the experimental nature of the driver?

I am testing by copying about 400 mb of files from one folder to another 
on the raid array, over and over again. Is there a howto or test 
software out there for better method to *really* hammer on the driver?

Thanks,
Robert Toole
