Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbUDFU1G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263994AbUDFU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:27:06 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:54697 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S263993AbUDFU0j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:26:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: High CPU temp on Athlon MP w/ recent 2.6 kernels
Date: Tue, 6 Apr 2004 16:26:37 -0400
User-Agent: KMail/1.6
References: <20040406193649.GA13257@sommrey.de>
In-Reply-To: <20040406193649.GA13257@sommrey.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061626.37714.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.9.226] at Tue, 6 Apr 2004 15:26:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 15:36, Joerg Sommrey wrote:
>Hello,
>
>some similar problems have already been reported.  However, this
> looks a bit different. With a large number of recent kernels (2.6.4
> and 2.6.5, mm-series and rc-series) the temperature of my CPUs is
> *much* higher than with 2.6.3-mm4 (and previous).  My board is a
> Tyan Tiger MPX with 2x Athlon 2000+ MP. The temperature is about
> 38-45 Celsius (on low load) with 2.6.3-mm4.  Later kernels show
> 48-55 Celsius.  I'm using amd76x_pm for power-saving (both
> linux-2.6-amd76x_pm-20031109.patch and patch-2.6.4-amd76x_pm).  At
> the moment this is not a big problem as 2.6.3-mm4 works perfect for
> me.  However, there might be future changes that make me wanting a
> newer kernel...
>
>I did some tests with nmi_watchdog and the proprietary Nvidia
> graphics driver and didn't find any impact.  There's no significant
> difference using no nmi_watchdog, nmi_watchdog=1 (only 2.6.3-mm4)
> or
>nmi_watchdog=2.  I also did some tests without an X server running:
>temperatures go down to the lower end but the difference of 10
> Kelvin between 2.6.3-mm4 and 2.6.5 persists. I didn't try any of
> the acpi kernel-parameters.
>
>See attached config for 2.6.5 for details.
>
>Any ideas?

Recently I've had to change the multiplier in gkrellm to reduce it by 
a div/10 to get the correct reading.  I've no idea how to make 
sensors see the new, multiplied by 10 readings correctly, I cannot 
make it run with later 2.6 kernels.

For gkrellm-2.1.28, the .28 version is needed by later kernels anyway, 
use the default, it apparently already corrects for this with its 
1.000 multiplier.  2.1.24, when it worked, had to have a multiplier 
of 0.1000.

But join the 70C club, that AMD athlon keeps itself at a medium simmer 
full time.  Mine has been running 67-72C for 3 years now.  Strangly, 
shutting down setiathome doesn't cool it by more than a couple 
degrees C.  And, its got a $50 all copper Glaciator cooler on it, 
heavy heavy heavy.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
