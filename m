Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbUDGSj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUDGSj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:39:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33773 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263863AbUDGSj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:39:56 -0400
Subject: Re: odd clock thing...
From: john stultz <johnstul@us.ibm.com>
To: Mariusz =?iso-8859-2?Q?Koz=B3owski?= <sp3fxc@linuxfocus.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200404062004.22292.sp3fxc@linuxfocus.org>
References: <200404062004.22292.sp3fxc@linuxfocus.org>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1081363155.5408.455.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 11:39:16 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 11:04, Mariusz Koz³owski wrote:
> 	I have linux running my laptop Sony VAIO PCG-FR285M. A few weeks ago I 
> compiled in to kernel CPU frequency scalling. I configured a few rules for 
> cpufreqd and since then I see strange behaviour of the clock in this machine. 
> First it was running slower than normal watch... i thought it has something 
> to do with the hardware. But later on I observed that when the machine is off 
> its clock runs perfectly fine. Now when the time zone has changed (I live in 
> Poland) the clock started to run faster than normal watch. Now when I power 
> off the machine time runs fine... I mean it was off for about a week and 
> surprise... the time was still late but the same amount of time when I 
> powered the machine off. So i guess it is not hardware related. What might be 
> causing this? Anyway I am not shure if it is a coincidence that this happened 
> when I compiled in CPU frequency scalling stuff and it is kernel related or 
> whether it is caused by some buggy user level software because I emerge 
> system && emerge world once or twice a week. I might add that when the clock 
> runs odd the machine is not powered from battery. It runs AC power supply so 
> the CPU uses its full frequency (2.4GHz). (I didn't test what is going on 
> with battery).
> 
> BTW. The clock was getting late approx. 1h a day.


Very odd. I looked at the dmesg you sent me and it looks like you're
using the ACPI PM timesource. There is an open bug (link below) against
it and I'm not sure if we're dealing with odd hardware or some other
side effect is causing the issue. 

If you disable cpufreq does it go away? You might want to try disabling
the ACPI PM timer code (under the Power Management->ACPI menu) and see
if that resolves it. 

For more details, check this bug:
http://bugme.osdl.org/show_bug.cgi?id=2375

thanks
-john


