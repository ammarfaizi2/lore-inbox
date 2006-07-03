Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWGCVbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWGCVbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWGCVbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:31:47 -0400
Received: from main.gmane.org ([80.91.229.2]:33959 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750857AbWGCVbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:31:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: ext4 features
Date: Mon, 03 Jul 2006 17:34:18 -0400
Message-ID: <44A98D5A.5030508@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
In-Reply-To: <20060703202219.GA9707@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> On Sat, Jul 01, 2006 at 08:17:02PM +0200, Tomasz Torcz wrote:
>> On Sat, Jul 01, 2006 at 07:47:16PM +0200, Thomas Glanzmann wrote:
>>> Hello,
>>>
>>>> Checksums are not very useful for themselves. They are useful when we
>>>> have other copy of data (think raid mirroring) so data can be
>>>> reconstructed from working copy.
>>> it would be possible to identify data corruption.
>>>
>>   Yes, but what good is identification? We could only return I/O error.
>> Ability to fix corruption (like ZFS) is the real killer.
> 
> Isn't that what we have RAID-1/5/6 for?  

I think he is talking about another problem. RAID addresses detectable 
failures at the hardware level. I believe that he wants validation after 
the data is returned (without error) from the device. While in most 
cases if what you wrote and what you read don't match it's memory, 
improving the chances of catching the error is useful, given that 
non-server often lacks ECC on memory, or people buy cheaper non-parity 
memory.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

