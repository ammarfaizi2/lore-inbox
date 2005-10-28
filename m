Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbVJ1Tae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbVJ1Tae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbVJ1Tae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:30:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:33167 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751669AbVJ1Tad
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:30:33 -0400
Subject: Re: Bug: timer going backward on a dual core
From: john stultz <johnstul@us.ibm.com>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <200510282109.42054.cloud.of.andor@gmail.com>
References: <200510282109.42054.cloud.of.andor@gmail.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 12:30:30 -0700
Message-Id: <1130527831.27168.413.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 15:09 -0400, Claudio Scordino wrote:
> Hi all.
> 
> We have a dual-core AMD64 with the new kernel 2.6.14 and the 
> timer goes backward...
> 
> 
> CONFIGURATION:
> 
> Kernel: 2.6.14
> Distribution: Gentoo Linux 2005.0
> Processor: Athlon 64 x2 4200+ (dual core)
> Motherboard: Abit KN8
> Memory: 1GB PC3200
> 
> 
> PROBLEM:
> 
> gettimeofday goes backward and returns values that are not monotonic,
> giving values that are smaller than values returned before.
> 
> The system has been tested with timer as PIT, PIT/TSC and PM and the
> problem occurs with all the configurations. 
> 
> Here is the config file that we used for the PM configuration.
> 
> Any suggestion ?

Booting w/ idle=poll tends to work around this issue. You might check
with your motherboard vendor for an updated BIOS that supports HPET or
the ACPI PM timer.

thanks
-john

