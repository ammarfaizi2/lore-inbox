Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWGZAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWGZAEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWGZAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:04:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:35530 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030279AbWGZAEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:04:41 -0400
Message-ID: <44C6B117.80300@zytor.com>
Date: Tue, 25 Jul 2006 17:02:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain>
In-Reply-To: <20060725235644.GA5147@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> On Wed, Jul 26, 2006 at 01:29:25AM +0200, Segher Boessenkool wrote:
>>> Yes, but if its in trade for something thats being used currently  
>>> which hurts
>>> more (case in point being the X server), using this solution is a  
>>> net gain.
>> ...in the short term.
>>
> And for any arch that isn't able to leverage a speedup via a vdso implementation
> of a simmilar functionality in the long term

If they can't, then they can't use your driver either.

>>> I'm not arguing with you that adding a low res gettimeofday  
>>> vsyscall is a better
>>> long term solution, but doing that requires potentially several  
>>> implementations
>>> in the C library accross a range of architectures, some of which  
>>> may not be able
>>> to provide a time solution any better than what the gettimeofday  
>>> syscall
>>> provides today.  The /dev/rtc solution is easy, available right  
>>> now, and applies
>>> to all arches.
>> "All"?
>>
> It there any arch for which the rtc driver doesn't function?

Yes, there are plenty of systems which don't have an RTC, or have an RTC 
which can't generate interrupts.

	-hpa

