Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbTATTVa>; Mon, 20 Jan 2003 14:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbTATTVa>; Mon, 20 Jan 2003 14:21:30 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:54271 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266728AbTATTV2>;
	Mon, 20 Jan 2003 14:21:28 -0500
Subject: Re: Fwd: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030118135408.GA22669@atrey.karlin.mff.cuni.cz>
References: <200301180325.h0I3PGa07081@eng2.beaverton.ibm.com>
	 <1042860792.32477.36.camel@w-jstultz2.beaverton.ibm.com>
	 <20030118135408.GA22669@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1043090602.32478.54.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Jan 2003 11:23:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-18 at 05:54, Pavel Machek wrote:

> Well, loop_delay() was big (fatal!) problem -- it can actaully wait
> for *less* time than told to. That happens if notebook boots during
> "battery low" and than goes to AC power. Thinkpad 560X is example of
> such behaviour. Slow (but working!) PIT seems to be only option on
> such machine.

I need to look more at the cpu_freq code, but I suspect it could it help
solve or lessen the problem (if we can detect the event on those older
systems). Regardless, you make a good point, so if I get the time I'll
look into a real PIT based delay. 

Thanks for the feeback. 
-john



