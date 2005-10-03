Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbVJCTVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVJCTVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVJCTVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:21:23 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:53510 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932642AbVJCTVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:21:22 -0400
Message-ID: <434184CA.7000106@tmr.com>
Date: Mon, 03 Oct 2005 15:21:46 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <433FAD57.7090106@yahoo.com.au> <433FBE59.8000806@superbug.co.uk>
In-Reply-To: <433FBE59.8000806@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Nick Piggin wrote:
> 
>> Ahmad Reza Cheraghi wrote:
>>
>>> Can somebody tell me why the Kernel-Development dont
>>> wanne have XML is being used in the Kernel??
>>>
>>
>> Because nobody has come up with a good reason why it
>> should be. Same as anything that isn't in the kernel.
>>
>> Nick
>>
> I have a requirement to pass information from the kernel to user space. 
> The information is passed fairly rarely, but over time extra parameters 
> are added. At the moment we just use a struct, but that means that the 
> kernel and the userspace app have to both keep in step. If something 
> like XML was used, we could implement new parameters in the kernel, and 
> the user space could just ignore them, until the user space is upgraded.
> XML would initially seem a good idea for this, but are there any methods 
> currently used in the kernel that could handle these parameter changes 
> over time.
> 
> For example, should the sysfs be used for this?
> 
> Any comments?

For decades people have been solving this with key:value, ignoring 
unknown keys. And using nice text format eliminates any endian and word 
size issues.

XML sounds like overkill for problems of this type.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
