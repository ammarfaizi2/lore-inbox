Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSAaJO0>; Thu, 31 Jan 2002 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290990AbSAaJOQ>; Thu, 31 Jan 2002 04:14:16 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:5898 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S289037AbSAaJOC>;
	Thu, 31 Jan 2002 04:14:02 -0500
Message-ID: <3C590AD8.2050908@epfl.ch>
Date: Thu, 31 Jan 2002 10:14:00 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Stuffed Crust <pizza@shaftnet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG:  broken I830MP AGP support in 2.4.17 and 2.4.18pre7
In-Reply-To: <fa.g3ut1lv.1q56hbd@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust wrote:


> When trying to load up the agpgart module under 2.4.17, I get:
> 
> 
>>Linux agpgart interface v0.99 (c) Jeff Hartmann
>>agpgart: Maximum main memory to use for agp memory: 262M
>>agpgart: Detected an Intel 830M, but could not find the secondary device.
>>


This is normal. 2.4.17 does not support i830MP.


> Fine, I see that 2.4.18pre supposedly has fixes for the I830MP.  So I
> compile it, slap it in place.. and get:  (with 2.4.17pre7)
> 
> 
>>Linux agpgart interface v0.99 (c) Jeff Hartmann
>>agpgart: Maximum main memory to use for agp memory: 262M
>>agpgart: unsupported bridge
>>agpgart: no supported devices found.
>>
> 
> lspci yields:
> 
>>00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
>>       Flags: bus master, fast devsel, latency 0
>>       Memory at d0000000 (32-bit, prefetchable) [size=256M]
>>       Capabilities: [40] #09 [0105]
>>       Capabilities: [a0] AGP version 2.0
>>
> 

This is much stranger... And even if the 830mp stuff does not work 
(several people have been able to use it), loading the agpgart module 
with the 'try_unsupported=1' option should do the trick (at least in 
2.4.18-pre7)... Can you send the full output of lspci ?

Best regards.

Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

