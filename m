Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTATTqx>; Mon, 20 Jan 2003 14:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTATTp1>; Mon, 20 Jan 2003 14:45:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26376 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266749AbTATTpP>; Mon, 20 Jan 2003 14:45:15 -0500
Date: Mon, 20 Jan 2003 20:54:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
Message-ID: <20030120195418.GA4694@atrey.karlin.mff.cuni.cz>
References: <200301180325.h0I3PGa07081@eng2.beaverton.ibm.com> <1042860792.32477.36.camel@w-jstultz2.beaverton.ibm.com> <20030118135408.GA22669@atrey.karlin.mff.cuni.cz> <1043090602.32478.54.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043090602.32478.54.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, loop_delay() was big (fatal!) problem -- it can actaully wait
> > for *less* time than told to. That happens if notebook boots during
> > "battery low" and than goes to AC power. Thinkpad 560X is example of
> > such behaviour. Slow (but working!) PIT seems to be only option on
> > such machine.
> 
> I need to look more at the cpu_freq code, but I suspect it could it help
> solve or lessen the problem (if we can detect the event on those
> > older
> systems). Regardless, you make a good point, so if I get the time
> > I'll

It is possible to lessen the problem by measuring speed and
recalibrating if it changes, but due to delay between measuring and
recalibrating it is still not 100% reliable.

> look into a real PIT based delay. 
> 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
