Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275292AbTHGMcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275298AbTHGMcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:32:39 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:63618
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S275292AbTHGMcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:32:31 -0400
Date: Thu, 7 Aug 2003 08:31:03 -0400
Subject: Re: 2.6.0-test2: unable to suspend (APM)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
From: Charles Lepple <clepple@ghz.cc>
In-Reply-To: <20030807120056.B17690@flint.arm.linux.org.uk>
Message-Id: <0252E1EB-C8D3-11D7-97B2-003065DC6B50@ghz.cc>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 7, 2003, at 07:00  AM, Russell King wrote:

> On Thu, Aug 07, 2003 at 08:45:53PM +1000, Stephen Rothwell wrote:
>> On Wed, 06 Aug 2003 22:46:59 -0400 Charles Lepple <clepple@ghz.cc> 
>> wrote:
>>>
>>> Also saw your post about the 3c59x cardbus adapter. I can't recall 
>>> ever
>>> being able to suspend the machine with that card inserted (including
>>> under 2.4-- I always had to eject the card before suspend or 
>>> hibernate).
>>
>> The IBM Thinkpad documentation mentions this (or used to) you cannot
>> suspend a Thinkpad (using APM?) while there is a card powered in the
>> PCMCIA/Cardbus slot.  You could try doing "cardctrl eject" before
>> suspending - I find that this works for me (Thinkpad T22).

OK, I didn't realize that powering down the card was a 
Thinkpad-specific requirement.

One thing that had me confused was that some people indicated that it 
should be possible to do the 'cardctl eject' or 'cardctl suspend' from 
within the script invoked by apmd-- however, I guess the Thinkpad BIOS 
doesn't let the APM suspend event propagate that far when there is a 
card powered up.

>> The message "apm: suspend: Unable to enter requested state" is an
>> indication of an error from the BIOS.
>
> Well, it all works fine with 2.4, even with a 3c59x in the slot (except
> for the resume problem.)  Even ejecting the card before suspending with
> 2.6 doesn't fix the problem though.

<aol>Same here</aol> (although I assumed that the problems I was seeing 
when reinserting the card were due to an older hotplug package that was 
misinterpreting the insertion events... I'll have to eliminate that 
possibility.)

Russell, I am curious as to whether any of the early 2.5.x (x <= 31) 
kernels still work for you, or whether suspend on your machine was 
broken in a different version.

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/

