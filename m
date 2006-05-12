Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWELITE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWELITE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWELITE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:19:04 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.5.131]:27270 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751081AbWELITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:19:03 -0400
Message-ID: <446444E2.5080300@cfl.rr.com>
Date: Fri, 12 May 2006 04:18:42 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
CC: Steven Rostedt <rostedt@goodmis.org>, Mark Hounschell <markh@compro.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com> <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net> <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com> <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com> <446335EA.3000506@compro.net> <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com> <44633B78.8080907@compro.net> <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com> <446350CF.3010204@compro.net> <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com> <1147419202.3969.51.camel@frecb000686>
In-Reply-To: <1147419202.3969.51.camel@frecb000686>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué wrote:
> On Fri, 2006-05-12 at 02:47 -0400, Steven Rostedt wrote:
>> On Thu, 11 May 2006, Mark Hounschell wrote:
>>
>>> Here is a detailed list of the RT tasks running with prios, cpu masks
>>> etc. There are 3 nics. eth1 is the nic being used by the emulation. eth2
>>> is currently unused.
>>> pid      SCHED        PRIO      CPUM TASK
>>> ---      ----         ----      ---- ----
>> This being a SMP machine, pid 2 and 3 must be the migration threads.
>>
>>> 2        FIFO         99           1 (unknown)
>>> 3        FIFO         99           1 (unknown)
>>> 4        FIFO         1            1 (unknown)
>>> 5        FIFO         1            1 (unknown)
>>> 6        FIFO         1            1 (unknown)
>>> 7        FIFO         1            1 (unknown)
>>> 8        FIFO         1            1 (unknown)
>>> 9        FIFO         1            1 (unknown)
>>> 10       FIFO         1            1 (unknown)
>> Do you know what these processes are (12 and 13)?
> 
>   On my machine, the only other processes runnning at prio 99 are
> the posix_cpu_timer tasks.
> 
>>> 12       FIFO         99           2 (unknown)
>>> 13       FIFO         99           2 (unknown)
>> [...]
>>

Yes you are correct.


    2 ?        S      0:00 [migration/0]
    3 ?        S      0:00 [posix_cpu_timer]
.
.
   14 ?        S      0:00 [migration/1]
   15 ?        S      0:00 [posix_cpu_timer]

Mark
