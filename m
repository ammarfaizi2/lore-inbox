Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWGYR5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWGYR5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWGYR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:57:35 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:13272 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751349AbWGYR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:57:34 -0400
In-Reply-To: <20060725174100.GA4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Tue, 25 Jul 2006 19:57:30 +0200
To: Neil Horman <nhorman@tuxdriver.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	At OLS last week, During Dave Jones Userspace Sucks presentation, Jim
> Geddys and some of the Xorg guys noted that they would be able to  
> stop using gettimeofday
> so frequently, if they had some other way to get a millisecond  
> resolution timer
> in userspace, one that they could perhaps read from a memory mapped  
> page.  I was
> right behind them and though that seemed like a reasonable  
> request,  so I've
> taken a stab at it.  This patch allows for a page to be mmaped  
> from /dev/rtc
> character interface, the first 4 bytes of which provide a regularly  
> increasing
> count, once every rtc interrupt.  The frequency is of course  
> controlled by the
> regular ioctls provided by the rtc driver. I've done some basic  
> testing on it,
> and it seems to work well.

Similar functionality is already available via VDSO on
platforms that support it (currently PowerPC and AMD64?) --
seems like a better way forward.


Segher

