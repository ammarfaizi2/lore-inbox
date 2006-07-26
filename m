Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWGZAKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWGZAKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWGZAKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:10:25 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:34317 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030285AbWGZAKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:10:24 -0400
Date: Tue, 25 Jul 2006 20:06:12 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060726000612.GC5147@localhost.localdomain>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <17606.31023.273943.551848@cargo.ozlabs.ibm.com> <5F730DDA-7A1C-4514-873F-9EB37CB7719E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F730DDA-7A1C-4514-873F-9EB37CB7719E@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:27:46AM +0200, Segher Boessenkool wrote:
> >It's not that bad; if userspace is running, the cpu isn't idle, so
> >there isn't the motivation to go tickless on that cpu.  In other
> >words, if every cpu has suspended ticks, then no cpu can be running
> >stuff that needs to look at this page.
> 
> If I read the patch correctly, none of those legacy RTC ticks
> can ever be suspended though?
> 
Of course they can.  See rtc_do_ioctl, specifically the RTC_UIE_OFF and
RTC_PIE_OFF cases.
Neil

> 
> Segher
