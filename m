Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWGYWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWGYWfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWGYWfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:35:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22997 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751533AbWGYWfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:35:47 -0400
Message-ID: <44C69C2E.7000609@zytor.com>
Date: Tue, 25 Jul 2006 15:33:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
In-Reply-To: <20060725222547.GA3973@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
>>
> Yes, but if its in trade for something thats being used currently which hurts
> more (case in point being the X server), using this solution is a net gain.
> 
> I'm not arguing with you that adding a low res gettimeofday vsyscall is a better
> long term solution, but doing that requires potentially several implementations
> in the C library accross a range of architectures, some of which may not be able
> to provide a time solution any better than what the gettimeofday syscall
> provides today.  The /dev/rtc solution is easy, available right now, and applies
> to all arches.  It has zero impact for systems which do not use it, and for
> those applications which make a decision to use it instead of an alternate
> method, the result I expect will be a net gain, until such time as we code up,
> test and roll out a vsyscall solution 
> 

Quick hacks are frowned upon in the Linux universe.  The kernel-user 
space interface is supposed to be stable, and thus a hack like this has 
to be maintained indefinitely.

Putting temporary hacks like this in is not a good idea.

	-hpa
