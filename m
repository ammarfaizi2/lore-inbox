Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUC3FRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUC3FRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:17:53 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:1912 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262814AbUC3FRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:17:52 -0500
Message-ID: <406902F7.8030805@yahoo.com.au>
Date: Tue, 30 Mar 2004 15:17:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel thread scheduling question
References: <4068F3E7.9060005@candelatech.com>
In-Reply-To: <4068F3E7.9060005@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> I have a kernel thread that I would like to have run at least
> every 1-2 miliseconds.
> 
> I think I would be happy if there were a way to have the
> process yield/schedule() at least once per ms with the
> understanding that it would get to wake again 1-2ms later.
> Is there a way to do such a thing without hacking up the
> scheduler code?
> 
> I have tried 2.6.4 with pre-empt, and setting the thread priority
> to -18, but I still see cases where the process is starved for 20+
> milliseconds every 3-5 seconds or so.  Other than this single
> process, there is not a big load on the system.
> 

Use realtime scheduling. sched_setscheduler (2) is a good
place to start.

