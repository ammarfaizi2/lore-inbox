Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbULOUAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbULOUAD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbULOUAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:00:02 -0500
Received: from alog0285.analogic.com ([208.224.222.61]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262472AbULOT76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:59:58 -0500
Date: Wed, 15 Dec 2004 14:54:09 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
In-Reply-To: <1103133841.3180.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412151448580.4365@chaos.analogic.com>
References: <20041211142317.GF16322@dualathlon.random>  <20041212163547.GB6286@elf.ucw.cz>
  <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> 
 <41BD483B.1000704@suse.de>  <20041213135820.A24748@flint.arm.linux.org.uk>
  <1102949565.2687.2.camel@localhost.localdomain>  <1102983378.9865.11.camel@orbiter>
 <1103133841.3180.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Alan Cox wrote:

> On Maw, 2004-12-14 at 00:16, Eric St-Laurent wrote:
>> Alan,
>>
>> On a related subject, a few months ago you posted a patch which added a
>> nice add_timeout()/timeout_pending() API and converted many (if not
>> most) drivers to use it.
>>
>> If I remember correctly it did not generate much comments and the work
>> was not pushed into mainline.
>>
>> I think it's a nice cleanup, IMHO the time_(before|after)(jiffies, ...)
>> construct is horrible.
>>
>> Any chance to resurrect this work ?
>
> I plan to ressurect it when I have a little time but with some small
> additions from the original work. Several people said "it should be mS
> not HZ" and someone at OLS proposed that the API also includes an
> accuracy guide so that systems using programmed wakeups can aggregate
> timers when accuracy doesn't matter.

I sure hope it isn't mS. Transconductance or its reciprocal doesn't
work very well for timing unless you supply the capacitor ;^)

FYI, mS means milli-Siemens. Seconds is lower-case --always.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
