Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTJQBhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 21:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJQBhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 21:37:02 -0400
Received: from [203.97.82.178] ([203.97.82.178]:17893 "EHLO treshna.com")
	by vger.kernel.org with ESMTP id S263276AbTJQBg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 21:36:58 -0400
Message-ID: <3F8F47B4.3000307@treshna.com>
Date: Fri, 17 Oct 2003 14:36:52 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en-nz
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Preemptible kernel makes mpg123 skip a lot under 2.6.0-testing7
 and very high load average under low usage.
References: <200310152344.29920.kernel@kolivas.org>
In-Reply-To: <200310152344.29920.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>Hi.
>
>I quote from your output:
>
>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>22953 andru     15   0 10100 5316 9464 S  3.7  0.6   2:02.39 mpg123
> 1067 root       5 -10  595m  58m 539m S  3.3  6.6 391:41.29 XFree86
> 1176 andru     15   0 47488  26m  13m S  1.0  3.0  11:52.32 gnome-terminal
>25063 root      17   0  2004 1096 1792 R  0.7  0.1   0:00.03 top
>
>The kernel is now tuned to give much more priority to reniced tasks and it is 
>not recommended to run your X server nice -10. This is the cause of your 
>problem as X is starving your audio application. Some distributions do this 
>by default to get around the limitations of the old cpu scheduler not being 
>able to make X smooth enough at nice 0. This hack/workaround is no longer 
>recommended for 2.6 kernels. You will find nice performance of X at nice 0 
>now and audio will not skip when the nice value of X is the same as your 
>audio application.
>
>Con
>  
>

Your right about the X server. I've reniced it and changed its init 
scripts to run it at a priority of 0
and it runs smoothly now without problems.


