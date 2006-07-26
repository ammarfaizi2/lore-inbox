Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWGZAh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWGZAh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWGZAh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:37:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53416 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932511AbWGZAh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:37:56 -0400
Message-ID: <44C6B925.8040606@zytor.com>
Date: Tue, 25 Jul 2006 17:36:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain> <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org> <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com> <20060726002043.GA5192@localhost.localdomain>
In-Reply-To: <20060726002043.GA5192@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
>>>>
>>> It there any arch for which the rtc driver doesn't function?
>> Yes, there are plenty of systems which don't have an RTC, or have an RTC 
>> which can't generate interrupts.
>>
> Ok, for those implementations which don't have an RTC that the rtc driver can
> drive, the mmap functionality will not work, but at that point what interface
> are you left with at all for obtaining periodic time?

Depends completely on the hardware.  Some hardware will rely on cycle 
counters, some may rely on I/O devices which may or may not be mappable 
into user space, and some will have to enter the kernel.

These aren't compatible with your programming model.

	-hpa
