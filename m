Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUFRCYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUFRCYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFRCYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:24:16 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:57294 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S264955AbUFRCYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:24:14 -0400
Message-ID: <40D25247.3050509@candelatech.com>
Date: Thu, 17 Jun 2004 19:24:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll
References: <Pine.LNX.4.53.0406170954190.702@chaos> <40D21C8E.4040500@candelatech.com> <Pine.LNX.4.53.0406171958570.3414@chaos>
In-Reply-To: <Pine.LNX.4.53.0406171958570.3414@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Thu, 17 Jun 2004, Ben Greear wrote:
> 
> 
>>Richard B. Johnson wrote:
>>
>>>Hello,
>>>Is it okay to use the 'extra' bits in the poll return value for
>>>something? In other words, is the kernel going to allow a user-space
>>>program to define some poll-bits that it waits for, these bits
>>>having been used in the driver?
>>
>>Can't you just do a read and determine from the results of the read
>>what you actually got?  If not, add framing to your message so that
>>you *CAN* determine one message type from another...
>>
>>Ben
>>
> 
> 
> The mailbox read(s) is/are 32-bit int(s). There is no way to identify
> it as being "new" or something that was written two weeks ago.
> That's why we use poll. Poll says 'I got something new for you'.

Then use 3 different file descriptors to poll/read.  That seems more
efficient anyway as it doesn't wake the folks who don't care.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

