Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbULVJiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbULVJiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 04:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbULVJiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 04:38:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:37597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261955AbULVJhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 04:37:55 -0500
Date: Wed, 22 Dec 2004 01:37:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, syslogd hangs then processes get stuck in
 schedule_timeout
Message-Id: <20041222013726.72da5ee7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412211606360.28245@potato.cts.ucla.edu>
References: <Pine.LNX.4.61.0412211606360.28245@potato.cts.ucla.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Stromsoe <cbs@cts.ucla.edu> wrote:
>
>  I'm still seeing this problem.  It repeats every week or week and a half, 
>  usually after logs have been rotated and a dvd has been written.  syslogd 
>  stops writing output, then everything that does schedule_timeout() hangs, 
>  the process table fills, and everything grinds to a halt.
> 
>  If the problem is detected early enough, syslogd can be manually killed 
>  and restarted, unwedging everything and returning everything to normal 
>  operation.
> 
>  I'm running 2.6.10-rc3, compiled with smp.  I've been seeing this since at 
>  least 2.6.8.1, both smp and nosmp.  userspace is debian testing.
> 
>  sysrq+t output from three hangs in November with 2.6.9 is at 
>  http://hashbrown.cts.ucla.edu/deadlock/.

Can't see anything untoward there, although one wonders why you have 609
instances of cron running.
