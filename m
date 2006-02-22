Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWBVRPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWBVRPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWBVRPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:15:03 -0500
Received: from dvhart.com ([64.146.134.43]:53157 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751376AbWBVRPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:15:00 -0500
Message-ID: <43FC9C13.7040109@mbligh.org>
Date: Wed, 22 Feb 2006 09:14:59 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Zeuthen <david@fubar.dk>
Cc: Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>	 <20060217231444.GM4422@stusta.de>	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>	 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>	 <20060221225718.GA12480@vrfy.org>	 <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>	 <20060222152743.GA22281@vrfy.org>	 <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com>
In-Reply-To: <1140625103.21517.18.camel@daxter.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Zeuthen wrote:
> On Wed, 2006-02-22 at 07:44 -0800, Linus Torvalds wrote:
> 
>>On Wed, 22 Feb 2006, Kay Sievers wrote:
>>
>>>Well, that's part of the contract by using an experimental version of HAL,
>>>it has nothing to do with the kernel
>>
>>NO NO NO!
>>
>>Dammit, if this is the logic and mode of operation of HAL people, then we 
>>must stop accepting patches to the kernel from HAL people.
>>
>>THIS IS NOT DEBATABLE.
>>
>>If you cannot maintain a stable kernel interface, then you damn well 
>>should not send your patches in for inclusion in the standard kernel. Keep 
>>your own "HAL-unstable" kernel and ask people to test it there.
> 
> 
> Oh, you know, I don't think that's exactly how it works; HAL is pretty
> much at the mercy of what changes goes into the kernel. And, trust me,
> the changes we need to cope with from your so-called stable API are not
> so nice. 
> 
> But I realize these changes are important because it's progress and back
> in 2.6.0 things were horribly broken for at least desktop workloads [1].
> It also makes me release note that newer HAL releases require newer
> kernel and udev releases and that's alright. In fact it's perfectly
> fine. We get users to upgrade to the latest and greatest and we keep
> making good progress. That's open source at it's finest I think.

If it's all that fragile, surely it just means that someone picked the
wrong point at which to try to form the API abstraction?

Frankly, that seems to be the issue behind a lot of these problems -
people decide to shove stuff into userspace for some religions reason, 
without thinking about the API implications at all.

We don't have a sane way to package all the userspace crud together
with the microkernel that people are turning Linux into. Either people
quit pretending that divesting things to userspace is a solution to all
hard problems, or we create a packaging / bundling mechanism for all
this shite. Frankly, I prefer the former, but whichever ... it's
getting insane.

M.
