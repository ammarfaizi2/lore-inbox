Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284985AbRLFFLH>; Thu, 6 Dec 2001 00:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284984AbRLFFK6>; Thu, 6 Dec 2001 00:10:58 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:29924 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S284985AbRLFFKr>;
	Thu, 6 Dec 2001 00:10:47 -0500
Message-ID: <3C0EFDA9.6090500@candelatech.com>
Date: Wed, 05 Dec 2001 22:10:01 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Q A <qarce_mail_lists@yahoo.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org, qarce@yahoo.com
Subject: Re: ARP shows client is given wrong MAC Address for system with 2 NICs
In-Reply-To: <20011206021449.70021.qmail@web20308.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried turning on arp-filtering?  It generally
acts more sane in a 2+ NIC machine.  Try:

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter



Q A wrote:

> 
> Thanks, but I am not moving the IP from one to the
> other.  I am just saying it doesn't matter _(A) does
> not have to be eth0.  Try setting up a system with 2
> NICs and follow my notes.  I have checked another
> system with a normal 2.4.3 kernel.
> 
> Thanks for yours and everyone elses help.
> 
> Q
> 
> 
> --- "Richard B. Johnson" <root@chaos.analogic.com>
> wrote:
> 
>>[SNIPPED...]
>>There is an ARP cache, always has been, always will
>>be. This is so
>>an ARP (Address Resolution Protocol) probe doesn't
>>have to occur for
>>every data transmission. It is presumed that an IP
>>address, including
>>your own, won't jump around from device-to-device.
>>
>>You are moving your IP address to another device
>>(MAC address). What
>>do you expect?
>>
>>You can delete the old entries from your ARP cache,
>>but it has to
>>be done for every system that would be affected or
>>you can just wait
>>for the ARP cache entry to expire.
>>
>>    /sbin/arp -d ipaddress
>>
>>
>>Cheers,
>>Dick Johnson
>>
>>Penguin : Linux version 2.4.1 on an i686 machine
>>(799.53 BogoMips).
>>
>>    I was going to compile a list of innovations
>>that could be
>>    attributed to Microsoft. Once I realized that
>>Ctrl-Alt-Del
>>    was handled in the BIOS, I found that there
>>aren't any.
>>
>>
>>
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Send your FREE holiday greetings online!
> http://greetings.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


