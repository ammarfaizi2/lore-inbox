Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUBUOhN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUBUOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:36:50 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:32520 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261564AbUBUOgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:36:48 -0500
Date: Sat, 21 Feb 2004 09:36:41 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <20040220190859.67442592.akpm@osdl.org>
Message-ID: <Pine.OSF.4.21.0402210917220.482543-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Feb 2004, Andrew Morton wrote:
> 
> Could you chmod user.log and vmstat.log for us?

Oops.  All set.  :\

> There are a few things you should try - you probably already have:
> 
> - Stop all applications, restart them
> 
> - Unload net driver module, reload and reconfigure it.
> 
> If either of those (or similar operations) are found to bring the latency
> back to normal then that would be a big hint.  ie: we need to find
> something which brings the performance back apart from a complete reboot.

I have managed to get the system back without reboot.  I stopped all
sendmail and mimedefang processes.  After a few minutes, I brought down
the (virtual) interface eth0:2 that served to host the MX IP 
address.  Shortly later, the machine came back.

That was on mist, the heavily loaded mail gateway.  I just added a couple
more graphs in folder 'other' that show a couple of other machines being
monitored by tap.  Ping response times grow over time, no matter what
machine is being monitored (not just linux).  Tap does not have any
virtual interfaces.

> Also, look out for consistent increases in either urer or system CPU time.

OK.  Have to run to the dump and other errands now, though... ;)

Thanks.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

