Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbTLVTlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTLVTlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:41:16 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:46248
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263851AbTLVTlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:41:13 -0500
Message-ID: <3FE7034C.5040808@rogers.com>
Date: Mon, 22 Dec 2003 14:44:28 +0000
From: pZa1x <pZa1x@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: [Fwd: Re: APM Suspend Problem]]
References: <3FD4A8EE.40504@rogers.com> <20031208225340.B31959@flint.arm.linux.org.uk> <3FD5A7E7.6040207@rogers.com>
In-Reply-To: <3FD5A7E7.6040207@rogers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.157.208.226] using ID <dw2price@rogers.com> at Mon, 22 Dec 2003 14:38:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded to 2.6.0 release but APM + yenta_socket still won't coexist 
(ie. Thinkpad T20 won't suspend with both)

pZa1x wrote:
> The patch wouldn't apply so I put the line into yenta_socket.c manually. 
> I recompiled kernel + modules but there was no different on reboot.
> 
> Suspend works with pcmcia_core installed but when yenta_socket is added, 
> suspend no longer works.
> 
> Russell King wrote:
> 
>> On Mon, Dec 08, 2003 at 04:38:06PM +0000, pZa1x wrote:
>>
>>> [Recap] Pursuing for the 2.6.0-test11 kernel, the problem where a 
>>> Thinkpad T20 can't suspend when running APM + PCMCIA. [/Recap]
>>>
>>> Please find attached 10 dumps. I've attached a bit more than you 
>>> asked but I hope the (long) filenames are self-explanatory.
>>
>>
>>
>> Ok, that's fine.
>>
>> Could you see if this patch solves your problem please?  (This patch
>> might apply with an offset).
>>
>> --- linux/drivers/pcmcia/yenta_socket.c.old    Sun Sep 28 09:54:57 2003
>> +++ linux/drivers/pcmcia/yenta_socket.c    Tue Oct 21 23:18:47 2003
>> @@ -500,6 +500,7 @@
>>  
>>      /* Disable CSC interrupts */
>>      cb_writel(socket, CB_SOCKET_MASK, 0x0);
>> +    exca_writeb(socket, I365_CSCINT, 0);
>>  
>>      return 0;
>>  }
>>
>>
> 
> 

