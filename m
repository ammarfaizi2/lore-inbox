Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVKLCe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVKLCe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVKLCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:34:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:40160 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751330AbVKLCe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:34:59 -0500
Subject: RE: IO-APIC problem with 2.6.14-rt9
From: john stultz <johnstul@us.ibm.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, dino@in.ibm.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60064B7DDC@scsmsx403.amr.corp.intel.com>
References: <88056F38E9E48644A0F562A38C64FB60064B7DDC@scsmsx403.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 18:34:49 -0800
Message-Id: <1131762889.2542.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 18:25 -0800, Pallipadi, Venkatesh wrote:
> I think we can keep calibrate_delay() do the calibration using
> READ_CURRENT_TIMER 
> (giving TSC per jiffy) and then convert it to some number of TSCs per
> loop and 
> use it in loop based delay.

That sounds reasonable. However, for now, I'll just keep the old code.
In my patch I pulled the loop based and TSC based delay functions out of
the timer_opts and pick one at boot depending on if the TSC is around or
not.

I'm testing it now and will be sending out a new patchset before I head
home tonight.

thanks
-john


