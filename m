Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbVKWFOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbVKWFOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVKWFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:14:08 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:16341 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030180AbVKWFOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:14:07 -0500
Date: Wed, 23 Nov 2005 06:13:58 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051123051358.GB7573@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz> <20051122163550.160e4395.akpm@osdl.org> <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4383D1CC.4050407@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
: Can't see anything yet. Sysrq-M would be good. cat /proc/zoneinfo gets you
: most of the way there though.
: 
: A couple of samples would be handy, especially from /proc/vmstat.
: 
: cat /proc/vmstat > vmstat.out ; sleep 10 ; cat /proc/vmstat >> vmstat.out
: 
: The same for /proc/zoneinfo would be a good idea as well.

	I will send it tomorrow - I will try to boot 2.6.15-rc2
to see if the problem is still there.

: Also - when you say "too much cpu time", what does this mean? Does
: performance noticably drop compared with 2.6.13 performing the same cron
: job? Because kswapd is supposed to unburden other processes from page
: reclaim work, so if it is working *properly*, then the more CPU it uses
: the better.

	As you can see from the graphs at
http://www.linux.cz/stats/mrtg-rrd/cpu.html
- the total CPU usage in the new kernel/with more memory is significantly
higher. I have not measured the time of the cron job itself, just the total
system utilization.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
