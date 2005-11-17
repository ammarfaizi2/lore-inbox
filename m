Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVKQTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVKQTaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVKQTaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:30:18 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:1321 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964796AbVKQTaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:30:16 -0500
Message-ID: <437CDACE.30703@tmr.com>
Date: Thu, 17 Nov 2005 14:32:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it> <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it> <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it> <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it> <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca> <43795C55.9080305@wolfmountaingroup.com>
In-Reply-To: <43795C55.9080305@wolfmountaingroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Robert Hancock wrote:
> 
>> Jeff V. Merkey wrote:
>>
>>> Why does the kernel need to be limited to 4K? for kernel preemption?
>>
>>
>>
>> No, because it makes a whole lot of things simpler and more reliable 
>> if the kernel stack is only one page.
>>
>>>
>>> Someone needs to fix this. It's busted. It makes porting code between 
>>> Windows and Linux and other OS's difficult to support.
>>
>>
>>
>> Ease of porting drivers written for other OSes to Linux is clearly not 
>> a high priority for the kernel community..
> 
> 
> 
> What?  There's more kernel apps than just ndis network drivers that get 
> ported.  ndiswrapper is busted (which is used for a lot of laptops)
> without 4K stacks.  My laptop is a Compaq and there isn't a Linux driver 
> for the wireless.  I also discovered Fedora Core 4 won't install
> on a Compaq Presario with SATA (stacks crashes).
> What are you saying?   People with wireless and laptops who run Linux 
> can't because ndiswrapper is busted without 8K stacks?
> 
> Should be a configurable option 4-16K -- set at RUN TIME on the COMMAND 
> LINE of the BOOT LOADER.   Peopl can set
> profile=? why not kernel default stack size.   That way Fedora, ES, AS, 
> and Suse can run out of the box on laptops like Windows,
> or is M$ going to keep owning the desktop?

Having stack size as a compile time value and having it as a runtime 
value are two totally different problems. I just don't see much benefit 
from making changing the size easy, when it is likely to be a VERY 
infrequent need at all.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
