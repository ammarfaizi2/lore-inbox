Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUGJMJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUGJMJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUGJMJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:09:59 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:10116 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266224AbUGJMJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:09:41 -0400
Message-ID: <40EFDC80.4090807@yahoo.com.au>
Date: Sat, 10 Jul 2004 22:09:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
CC: arjanv@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
References: <20040709182638.GA11310@elte.hu>	 <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu>	 <20040710085044.GA14262@elte.hu>	 <2a4f155d040710035512f21d34@mail.gmail.com> <1089458801.2704.3.camel@laptop.fenrus.com> <2a4f155d040710050166e98a7f@mail.gmail.com>
In-Reply-To: <2a4f155d040710050166e98a7f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:
> cartman@southpark:~$ dmesg | grep sched
> Using anticipatory io scheduler
> 
> Problem is I rarely do this copy operations like once a week or 2
> weeks. Guess there is no scheduler that fits both desktop usage +
> these kinds of operations?
> 

For our benefit, could you try to recreate the situation with
the cfq scheduler, and see if it still skips? If not, also do
a run with the anticpatory scheduler again to see if your
recreation was enough to cause a skip there...

That would at least point to the culprit (disk or cpu starvation)

Thanks
Nick
