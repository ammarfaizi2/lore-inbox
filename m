Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVJKOze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVJKOze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVJKOze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:55:34 -0400
Received: from pm2.irt.drexel.edu ([144.118.29.82]:426 "EHLO
	smtp.mail.drexel.edu") by vger.kernel.org with ESMTP
	id S932107AbVJKOzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:55:33 -0400
Message-ID: <434BD260.8090908@drexel.edu>
Date: Tue, 11 Oct 2005 10:55:28 -0400
From: "Justin R. Smith" <jsmith@drexel.edu>
Organization: Drexel University
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050826)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Clock stopping (was Instability in kernel version 2.6.12.5)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to you all for your suggestions!

Unfortunately, none of the them seem to have worked: the clock still 
stops after a period of time (usually under some cpu stress). I searched 
the FreeBSD mailing lists for a similar problem (althugh I never had the 
clock-stopping problem under FreeBSD) and found the following:

>/ >My Dell Latatude 610 is having its clock rate go from 1000 Mhz to 733
/>/ >Mhz under -CURRENT that was cvsupped and installed yesterday.  I'm
/>/ >honestly not sure how long this has been happening, since I only got the
/>/ >clock speed monitor (the one that runs under gkrellm) hooked up a couple
/>/ >weeks ago.  I hooked it up because the machine seemed slow.  It had been
/>/ >happening for a couple weeks at least.
/>/ >
/>/ >The rate seems to change after using the CPU hard for a while - a big
/>/ >compile, like make buildworld seems to do it, though even a few minutes
/>/ >of compilation seems sufficient.
/>/ >
/>/ >When the CPU speed changes I get a message in the logs saying 
/>/ >
/>/ >cpu0: Performance states changed
/>/ >
/>/ >The state never seems to change back to a high performance one.  I've
/>/ >configured the BIOS not to do power management with the AC connected,
/>/ >and this happens with the AC connected.
/>/ 
/>/ This transition is being done by the BIOS for passive cooling.  We can't 
/>/ control it until the cpufreq driver is committed.  When the system gets 
/>/ hot, the BIOS steps the processor down to 733 mhz but the timecounters have 
/>/ no way of knowing it happened.
/

My CPU is a 2.8 Gig Prescott, but the computer (an IBM Thinkstation) is 
VERY quiet (as though no fans are running).

Is it possible something like this is trashing the Linux clock 
completely (rather than just slowing it down)? Maybe it goes out of sync 
in some sense?

I will try rebuilding the kernel with cpufreq enabled.
