Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUC1AAC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUC1AAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:00:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261907AbUC0X75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:59:57 -0500
Message-ID: <4066156F.1000805@pobox.com>
Date: Sat, 27 Mar 2004 18:59:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au>
In-Reply-To: <406612AA.1090406@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Jeff Garzik wrote:
> 
>> Nick Piggin wrote:
>>
>>> I think 32MB is too much. You incur latency and lose
>>> scheduling grainularity. I bet returns start diminishing
>>> pretty quickly after 1MB or so.
>>
>>
>>
>> See my reply to Bart.
>>
>> Also, it is not the driver's responsibility to do anything but export 
>> the hardware maximums.
>>
>> It's up to the sysadmin to choose a disk scheduling policy they like, 
>> which implies that a _scheduler_, not each individual driver, should 
>> place policy limitations on max_sectors.
>>
> 
> Yeah I suppose you're right there. In practice it doesn't
> work that way though, does it?

Not my problem  <grin>

People shouldn't be tuning max_sectors at the source code level: that 
just embeds the policy decisions in the source code, and leads to 
constant fiddling with the driver to get things "just right". Over time, 
disks get faster and latency falls naturally.  Thus the definition of 
"just right" must be constantly tuned in the driver source code as time 
passes.

I also wouldn't want to lock out any users who wanted to use SATA at 
full speed ;-)

	Jeff



