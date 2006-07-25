Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWGYS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWGYS2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWGYS2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:28:51 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:15111 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751473AbWGYS2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:28:50 -0400
Date: Tue, 25 Jul 2006 14:28:33 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725182833.GE4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 07:57:30PM +0200, Segher Boessenkool wrote:
> >	At OLS last week, During Dave Jones Userspace Sucks presentation, Jim
> >Geddys and some of the Xorg guys noted that they would be able to  
> >stop using gettimeofday
> >so frequently, if they had some other way to get a millisecond  
> >resolution timer
> >in userspace, one that they could perhaps read from a memory mapped  
> >page.  I was
> >right behind them and though that seemed like a reasonable  
> >request,  so I've
> >taken a stab at it.  This patch allows for a page to be mmaped  
> >from /dev/rtc
> >character interface, the first 4 bytes of which provide a regularly  
> >increasing
> >count, once every rtc interrupt.  The frequency is of course  
> >controlled by the
> >regular ioctls provided by the rtc driver. I've done some basic  
> >testing on it,
> >and it seems to work well.
> 
> Similar functionality is already available via VDSO on
> platforms that support it (currently PowerPC and AMD64?) --
> seems like a better way forward.
> 
In general I agree, but that only works if you operate on a platform that
supports virtual syscalls, and has vdso configured.  I'm not overly familiar
with vdso, but I didn't think vdso could be supported on all platforms/arches.
This seems like it might be a nice addition in those cases.

Neil

> 
> Segher

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
