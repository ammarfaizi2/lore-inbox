Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUKSM6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUKSM6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUKSM6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:58:53 -0500
Received: from alog0303.analogic.com ([208.224.222.79]:48768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261386AbUKSM6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:58:50 -0500
Date: Fri, 19 Nov 2004 07:55:14 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andi Kleen <ak@suse.de>, David Woodhouse <dwmw2@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
In-Reply-To: <419DE90D.9030509@pobox.com>
Message-ID: <Pine.LNX.4.61.0411190749170.12075@chaos.analogic.com>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de>
 <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de>
 <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de>
 <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de>
 <419DE33E.2000208@pobox.com> <20041119121909.GF21483@wotan.suse.de>
 <419DE90D.9030509@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Jeff Garzik wrote:

> Andi Kleen wrote:
>> On Fri, Nov 19, 2004 at 07:12:46AM -0500, Jeff Garzik wrote:
>> 
>>> Andi Kleen wrote:
>>> 
>>>> I don't know details about the driver, but it's not enabled on x86-64 
>>>> because x86-64 doesn't have ISA set.
>>> 
>>> 
>>> which I disagree with.  CONFIG_ISA should include southbridge devices 
>>> behind a PCI<->ISA bridge.  There is zero value to a more stricter "there 
>>> is a physical ISA bus in this machine" definition.
>> 
>> 
>> There is. It gets rid of many tens of drivers that are not and will never
>> be 64bit clean and have a snowball in hell chances to work on x86-64.
>> 
>> In theory you could invent a new ISA_SLOT or ISA_BROKEN config for them,
>> but since ISA does the job quite well for near everybody except
>> for one or two corner cases I don't see any sense in changing it.
>
> The traditional legacy ISA devices -- floppy, serial, parallel, mouse, 
> keyboard, IDE -- are still around.  Yet now we need to invent a new name to 
> classify ISA devices that have been with us for 20 years?
>
> CONFIG_ISA_BROKEN is more appropriate than pretending devices we've called 
> ISA since the 1980's do not imply/depend on CONFIG_ISA.
>
> 	Jeff
>

Why CONFIG_ISA_BROKEN. That implies (states) that its broken and
it's not. All modern ix86's have such a bus, even though it
doesn't go out to some connectors anymore. Just leave the 20-year-old
local bus, then called ISA, alone. ISA means:

               Industry Standard Architecture

It __is__! Don't muck with it.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
