Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbULPNDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbULPNDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbULPNDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:03:22 -0500
Received: from alog0205.analogic.com ([208.224.220.220]:17024 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262657AbULPM5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:57:01 -0500
Date: Thu, 16 Dec 2004 07:42:16 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
In-Reply-To: <200412152117.20568.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.61.0412160725120.8053@chaos.analogic.com>
References: <20041211142317.GF16322@dualathlon.random>
 <1103133841.3180.1.camel@localhost.localdomain>
 <Pine.LNX.4.61.0412151448580.4365@chaos.analogic.com>
 <200412152117.20568.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Gene Heskett wrote:

> On Wednesday 15 December 2004 14:54, linux-os wrote:
>> On Wed, 15 Dec 2004, Alan Cox wrote:
>>> On Maw, 2004-12-14 at 00:16, Eric St-Laurent wrote:
>>>> Alan,
>>>>
>>>> On a related subject, a few months ago you posted a patch which
>>>> added a nice add_timeout()/timeout_pending() API and converted
>>>> many (if not most) drivers to use it.
>>>>
>>>> If I remember correctly it did not generate much comments and the
>>>> work was not pushed into mainline.
>>>>
>>>> I think it's a nice cleanup, IMHO the
>>>> time_(before|after)(jiffies, ...) construct is horrible.
>>>>
>>>> Any chance to resurrect this work ?
>>>
>>> I plan to ressurect it when I have a little time but with some
>>> small additions from the original work. Several people said "it
>>> should be mS not HZ" and someone at OLS proposed that the API also
>>> includes an accuracy guide so that systems using programmed
>>> wakeups can aggregate timers when accuracy doesn't matter.
>>
>> I sure hope it isn't mS. Transconductance or its reciprocal doesn't
>> work very well for timing unless you supply the capacitor ;^)
>
> Me sticks hand up and waves at teacher.
>
> And what does 'Transconductance' have to do with this?
>

The international notation for transconductance is Siemens, no longer
MHO (Ohm spelled backwards). This happened at the same time that c.p.s. 
was changed to Hz. But, because the Siemens company is one of the
world's largest, the "S" didn't catch on as readily as Hz and others.
Siemens is so common you need to look up MHO in some really complete
dictionary to find its usage as MHO.

> That may be the wrong terminology to apply here.
>
> In vacuum tube (remember those?) specifications, this is the gain of
> the tube, which AIR is stated as the change in plate current for a
> one volt change in grid bias, and is normally stated in micromho's as
> they are high voltage, low current devices, with the highest gain
> tube that I'm aware of being the 7788.   Using the same measurement

The older MHO was usually stated in micro-mho for vacuum
tubes. For instance low mu triodes like 12AT7 had a mu
of 10 (10 micro-mho). The "gainier" cousin, the 12AX7
had a mu of 100 (100 micro-mho).

Some modern FETs have transconductance up to 10
MHO (10 Siemens).

> technique applied to modern relatively highed power field effect
> transistors where the currents can be many amperes, readings best
> stated in mho's are fairly common today. A 'mho' of course, is the
> reciprocal of an ohm.
>
>> FYI, mS means milli-Siemens. Seconds is lower-case --always.
>
> Yup.
>
> -- 
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
> soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> 99.30% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attorneys please note, additions to this message
> by Gene Heskett are:
> Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
