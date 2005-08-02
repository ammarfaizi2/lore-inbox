Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVHBGqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVHBGqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 02:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVHBGqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 02:46:02 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9958 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261396AbVHBGp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 02:45:58 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 1 Aug 2005 23:45:36 -0700
From: Tony Lindgren <tony@atomide.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050802064535.GC15903@atomide.com>
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE4B4A.80602@andrew.cmu.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Bruce <bruce@andrew.cmu.edu> [050801 09:28]:
> 
> Finally, as a conspiracy theorist, I wonder if Linus is just playing us 
> to get more people working on the tick skipping and highres timer 
> patches.  Someone with the ability to herd cats obviously has to be 
> sneaky.  As an impressive demonstration of my free will I'm going to go 
> test dyntick on my VIA Epia board...

Yeah, I've been running dyntick on my VIA Epia home server for a while now:

# uname -r
2.6.12-rc4

# uptime
 23:39:46 up 76 days,  9:10,  5 users,  load average: 0.00, 0.01, 0.00

# pmstats 5
Current: 0mA Voltage: 0.00mV Power: 0.00W 0mAh Time: 00:00h Ticks: 0HZ
Current: 0mA Voltage: 0.00mV Power: 0.00W 0mAh Time: 00:00h Ticks: 33HZ
Current: 0mA Voltage: 0.00mV Power: 0.00W 0mAh Time: 00:00h Ticks: 32HZ
Current: 0mA Voltage: 0.00mV Power: 0.00W 0mAh Time: 00:00h Ticks: 34HZ
Current: 0mA Voltage: 0.00mV Power: 0.00W 0mAh Time: 00:00h Ticks: 35HZ

My server is mostly idle, and the average HZ is around 35HZ.

This is still with the max HZ set to 1000. With dyntick, the max HZ
should be set to something that provides best performance under heavy
load on the system. Or least latency or whatever.

But AFAIK, it does not make any sense to limit the max HZ because of
power savings. That's just a bad compromise.

Regards,

Tony
