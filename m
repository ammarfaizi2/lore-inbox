Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbUC3Rbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUC3Rbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:31:40 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:20469 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263430AbUC3Rb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:31:28 -0500
Message-ID: <4069AED1.4020102@nortelnetworks.com>
Date: Tue, 30 Mar 2004 12:30:57 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() version 2.4.24
References: <Pine.LNX.4.53.0403301138260.6967@chaos> <4069A729.3030507@nortelnetworks.com> <Pine.LNX.4.53.0403301204510.7155@chaos>
In-Reply-To: <Pine.LNX.4.53.0403301204510.7155@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> Well in excess of 100% on a single-CPU system.

Very odd.

>  12:02pm  up 1 day, 53 min,  4 users,  load average: 2.54, 1.25, 0.90
> 34 processes: 31 sleeping, 3 running, 0 zombie, 0 stopped
> CPU states: 65.8% user, 134.6% system,  0.0% nice,  0.0% idle
> Mem:  322352K av, 101772K used, 220580K free,      0K shrd,   9836K buff
> Swap: 1044208K av, 1044208K used,      0K free                 20240K cached
> 
>  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
>  7144 root      19   0  5564 5564  1444 R       0 82.5  1.7   2:27 client
>  7143 root      15   0   980  976   428 S       0 59.9  0.3   1:57 server
>  7142 root      18   0  1464 1464  1444 R       0 56.0  0.4   1:39 client
>  7163 root      11   0   568  564   432 R       0  1.9  0.1   0:00 top
> [SNIPPED...sleeping tasks]


The cpu util accounting code in kernel/timer.c hasn't changed in 2.4 
since 2002.  Must be somewhere else.

Anyone else have any ideas?


Chris
