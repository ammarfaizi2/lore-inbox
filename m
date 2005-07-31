Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVGaWuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVGaWuY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVGaWuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:50:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8323 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262029AbVGaWsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:48:35 -0400
Date: Mon, 1 Aug 2005 00:47:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731224752.GC27580@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ED4CCF.6020803@andrew.cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Then the second test was probably flawed, possibly because we have
> >some more work to do. No display is irrelevant, HZ=100 will still save
> >0.5W with running display. Spinning disk also does not produce CPU
> >load (and we *will* want to have disk spinned down). No daemons... if
> >some daemon wakes every msec, we want to fix the daemon. 
> 
> I was talking about percentage saved; That 5.2% easily drops below 2% 
> once other things start sucking up power.  I was thinking that way since 
> the percentage saved is what determines the overall battery life 
> increase.  You're right in that the absolute power draw difference 
> should stay the same, and that seems to be the case is Marc's tests 
> (ignoring the brokenness of artsd).

You are right at that, but .5W is still about as much as hard disk
spinning. And newer CPUs are likely to benefit more from HZ=100.

> >Kernel defaults are irelevant; distros change them anyway. [But we
> >probably want to enable ACPI and cpufreq by default, because that
> >matches what 99% of users will use.]
> 
> True, but I think a lot of distros treat the values as recommendations. 
>  I guess we'll find out what they do with this option soon enough.

I'm pretty sure at least one distro will go with HZ<300 real soon now
;-).

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
