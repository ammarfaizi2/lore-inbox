Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCSCCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCSCCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:02:13 -0500
Received: from smtp.terra.es ([213.4.129.129]:17246 "EHLO tsmtp15.mail.isp")
	by vger.kernel.org with ESMTP id S261326AbUCSCCK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:02:10 -0500
Date: Fri, 19 Mar 2004 02:51:50 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Bill Davidsen <davidsen@tmr.com>
Cc: riel@redhat.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-Id: <20040319025150.7a45f8a9.diegocg@teleline.es>
In-Reply-To: <405A4015.40108@tmr.com>
References: <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com>
	<20040318211532.293bb63c.diegocg@teleline.es>
	<405A4015.40108@tmr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 18 Mar 2004 19:34:29 -0500 Bill Davidsen <davidsen@tmr.com> escribió:

> Have a bit of caution there, cdrecord sets itself realtime priority, 
> locks pages in memory, and ensures that the process is likely to work 
> even under load. I don't think addressing just a part of the problem 
> will result in reliability under load. You would have to look at 
> capabilities to allow these things to be done, under load they may not 
> keep up depending on what's going on. Good to get a start, don't assume 
> all the issues are addressed.


Yes, the following message is:
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.

But since 2.6 uses DMA for recording the CPU usage is really low...I guess
people will still use suid for that :)
