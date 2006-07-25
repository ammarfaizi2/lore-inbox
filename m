Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWGYU0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWGYU0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWGYU0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:26:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41861 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751544AbWGYU0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:26:44 -0400
Message-ID: <44C67E1A.7050105@zytor.com>
Date: Tue, 25 Jul 2006 13:24:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Neil Horman <nhorman@tuxdriver.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net>	 <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>	 <20060725182833.GE4608@hmsreliant.homelinux.net>	 <44C66C91.8090700@zytor.com>	 <20060725192138.GI4608@hmsreliant.homelinux.net>	 <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org>	 <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
In-Reply-To: <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> 
> So far the requirements are pretty much not high resolution but is
> accurate and increasing. so like 10ms is fine, the current X timer is
> in the 20ms range.
> 
> I think an mmap'ed page with whatever cgt(CLOCK_MONOTONIC) returns
> would be very good, but it might be nice to implement some sort of new
> generic /dev that X can mmap and each arch can do what they want in
> it,
> 
> I'm wondering why x86 doesn't have gettimeofday vDSO (does x86 have
> proper vDSO support at all apart from sysenter?),
> 

The i386 vdso right now has only two entry points, as far as I can tell: 
system call and signal return.

There is no reason it couldn't have more than that.  A low-resolution 
and a high-resolution gettimeofday might be a good idea.

	-hpa

