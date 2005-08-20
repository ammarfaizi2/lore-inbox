Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVHTJud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVHTJud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 05:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHTJud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 05:50:33 -0400
Received: from claven.physics.ucsb.edu ([128.111.16.29]:41428 "EHLO
	claven.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S1751078AbVHTJuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 05:50:32 -0400
Date: Sat, 20 Aug 2005 02:50:28 -0700 (PDT)
From: Nathan Becker <nbecker@physics.ucsb.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: lost ticks and Hangcheck
In-Reply-To: <1124498084.2932.3.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.63.0508200239440.11967@claven.physics.ucsb.edu>
References: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu> 
 <20050819094500.GB16279@kurtwerks.com>  <Pine.LNX.4.63.0508191714150.8252@claven.physics.ucsb.edu>
 <1124498084.2932.3.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please make sure this issue is reproducible without any binary only
> drivers.

I uninstalled the NVIDIA drivers and tried again with the nv x.org driver. 
Same problem.  I also tried remaining in text mode (with no NVIDIA drivers 
loaded).  Same problem.  In both cases it occurs when I start seriously 
loading the CPU.

One thing that may be of interest is that the message in dmesg is 
different if I'm in text mode vs. x.org.  If I'm in text mode the message 
is:

Losing some ticks... checking if CPU frequency changed.

If I'm running x.org then I get

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip default_idle+0x20/0x30

OK, I'll open a bug report in bugzilla.  I don't think this is the same as 
bug #3341.  My clock comes up normal 100% of the time on boot up.  Things 
only go awry when I start putting a load on the CPU.

Thanks very much for your help, and please cc. me if you find anything out 
since I'm not a regular subscriber.

Nathan
