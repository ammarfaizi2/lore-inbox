Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbULVKEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbULVKEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 05:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbULVKED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 05:04:03 -0500
Received: from smtp.ucla.edu ([169.232.47.136]:33716 "EHLO smtp.ucla.edu")
	by vger.kernel.org with ESMTP id S261897AbULVKEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 05:04:00 -0500
Date: Wed, 22 Dec 2004 02:03:57 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, syslogd hangs then processes get stuck in schedule_timeout
In-Reply-To: <20041222013726.72da5ee7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412220158020.5064@potato.cts.ucla.edu>
References: <Pine.LNX.4.61.0412211606360.28245@potato.cts.ucla.edu>
 <20041222013726.72da5ee7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Hits: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Andrew Morton wrote:

>>  sysrq+t output from three hangs in November with 2.6.9 is at
>>  http://hashbrown.cts.ucla.edu/deadlock/.
>
> Can't see anything untoward there,

thanks for looking... Chuck Ebbert mentioned some recent libc futex fixes 
offlist that I'll look into.

> although one wonders why you have 609 instances of cron running.

when the syslogd hang happens, cron will fork off a new task and then the 
child hangs.  The same thing happens with ssh into the box (sshd forks and 
the child hangs).  The 609 cron scripts in the particular sysrq+t are the 
result of normal system activity over a period of time, all hanging after 
the fork.


-Chris
