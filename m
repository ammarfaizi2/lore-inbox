Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbWI1OpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWI1OpG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWI1OpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:45:06 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:29663
	"EHLO saville.com") by vger.kernel.org with ESMTP id S1161162AbWI1OpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:45:02 -0400
Message-ID: <451BDFF3.4040003@saville.com>
Date: Thu, 28 Sep 2006 07:45:07 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Zero copy between ISR, kernel and User
References: <4519F7A9.4050807@saville.com> <20060927121030.4469ec6e@freekitty>
In-Reply-To: <20060927121030.4469ec6e@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 26 Sep 2006 21:01:45 -0700
> Wink Saville <wink@saville.com> wrote:
>
>   
>> Hello,
>>
>> I would like to allow the transferring of data between ISR's, kernel and 
>> user code, without requiring copying. I envision allocating buffers in 
>> the kernel and then mapping them so that they appear at the same 
>> addresses to all code, and never being swapped out of memory.
>>
>> Is this feasible for all supported Linux architectures and is there 
>> existing code that someone could point me towards?
>>
>> Regards,
>>
>> Wink Saville
>>
>>     
>
> Your better off having application mmap a device, then transfer
> the data to there. Something like AF_PACKET.
>
>   
Is there some reason a kernel module can't mmap first, for instance I 
assume display drivers might do that? One of the reasons I need it to 
done in the kernel first is that data could come from the device or 
other entities before the application is running.

But I will study AF_PACKET handling.

Thanks,

Wink

