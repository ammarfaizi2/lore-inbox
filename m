Return-Path: <linux-kernel-owner+w=401wt.eu-S1751089AbXACT3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbXACT3h (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXACT3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:29:37 -0500
Received: from smtpauth03.prod.mesa1.secureserver.net ([64.202.165.183]:50710
	"HELO smtpauth03.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751089AbXACT3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:29:36 -0500
Message-ID: <459C041E.90409@seclark.us>
Date: Wed, 03 Jan 2007 14:29:34 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] quiet MMCONFIG related printks
References: <200701012101.38427.jbarnes@virtuousgeek.org>	 <1167832386.3095.20.camel@laptopd505.fenrus.org>	 <200701030849.33205.jbarnes@virtuousgeek.org> <1167843673.3127.162.camel@laptopd505.fenrus.org>
In-Reply-To: <1167843673.3127.162.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2007-01-03 at 08:49 -0800, Jesse Barnes wrote:
>  
>
>>On Wednesday, January 3, 2007 5:53 am, Arjan van de Ven wrote:
>>    
>>
>>>On Mon, 2007-01-01 at 21:01 -0800, Jesse Barnes wrote:
>>>      
>>>
>>>>Using MMCONFIG for PCI config space access is simply an
>>>>optimization, not a requirement.  Therefore, when it can't be used,
>>>>there's no need for KERN_ERR level message.  This patch makes the
>>>>message a KERN_INFO instead to reduce some of the noise in a kernel
>>>>boot with the 'quiet' option. (Note that this has no effect on a
>>>>normal boot, which is ridiculously verbose these days.)
>>>>        
>>>>
>>>this is wrong, please leave this loud complaint in...
>>>      
>>>
>>So the issues as I understand them:
>>  o some BIOSes are broken and don't properly map MCFG space (though
>>    according to Petr V. reserving MCFG space in e820 is optional, so
>>    the test may be slightly wrong as-is)
>>    
>>
>
>it's optional but it's the best test we have for "is the bios total
>crap" ;(
>
>  
>
>>  o MCFG space is required for (many) PCIe devices (any regular PCI
>>    devices?)
>>    
>>
>
>it's not required for *many* (it can't be, windows XP doesn't use MCFG),
>but it's required for some of the advanced PCI-E features
>
>  
>
>>  o often, there's nothing the user can do to address the points above
>>    
>>
>
>other than complain to the vendor.
>
>  
>
>>So where does that leave us?  I've got what I consider to be a stupid 
>>error message in my log.
>>    
>>
>
>contact your bios vendor.
>
>  
>
>>  My system behavior isn't affected in any way 
>>(at least that I can tell), yet I get a loud complaint at boot time.
>>
>>I guess I just have to live with it?
>>    
>>
>
>We really really should complain about bios issues. If only to make sure
>vendors who do pay attention to linux have a chance of finding and
>fixing them (and via the firmware kit, several big vendors pay attention
>early on nowadays)
>
>  
>
Hi Arjan,

Do you have a list of E-Mail addresses for the people we should be 
complaining to. I have an
Asus VBI laptop that spews all kinds of error messages when I boot the 
firmware test kit cd, but
I have no idea who to complain to about this, ASUS? Intel? Heck Intel 
puts out the test kit, if they
are going to say it is VBI why don't the make the vendors do the bios 
correctly?

Regards,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



