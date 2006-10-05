Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWJERoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWJERoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWJERoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:44:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37356 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751745AbWJERoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:44:03 -0400
Message-ID: <4525445C.6060901@garzik.org>
Date: Thu, 05 Oct 2006 13:43:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
References: <200610051910.25418.ak@suse.de> <45253E37.6070305@garzik.org> <200610051931.23884.ak@suse.de>
In-Reply-To: <200610051931.23884.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 05 October 2006 19:17, Jeff Garzik wrote:
> 
>> Does this fix the following issue:
>>
>> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
>> PCI: Not using MMCONFIG.
>>
>> 100% of my x86-64 boxes, AMD or Intel, print this message.  And 100% of 
>> them work just fine with MMCONFIG.
> 
> No. 
> 
> But it isn't really a issue. Basically everything[1] will work fine anyways.
> 
> [1]  Only thing you're missing AFAIK is PCI Extended Error Reporting.

Not really true, I have some cards which have >256 bytes of config space.


>> I think this rule is far too drastic for real life.
> 
> If you have a better proposal please share. I tried a few others, but none
> of them could handle all the buggy Intel 9x5 boards that hang on any
> mmconfig access (so the "try the first few busses" check already hangs)
> 
> Originally I thought
> DMI blacklisting would work, but it's on too many systems for that
> (and Linus rightfully hated it anyways). ACPI checks also didn't work.
> I don't know of any others.

It's a bit disappointing, since I keep getting brand new boxes with 
brand new BIOSen, but keep hitting this rule.

AFAICS it's a buggy check, since it continues to needlessly blacklist 
working boxes.

My proposal is quite simple:  "something that works" -- the current 
solution obviously does not.

	Jeff


