Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWCKKmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCKKmk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWCKKmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 05:42:40 -0500
Received: from [82.153.166.94] ([82.153.166.94]:23746 "EHLO mail.inprovide.com")
	by vger.kernel.org with ESMTP id S1751125AbWCKKmk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 05:42:40 -0500
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org>
	<Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	<yw1xbqwe2c2x.fsf@agrajag.inprovide.com> <4411F87B.2070902@mnsu.edu>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Sat, 11 Mar 2006 10:42:27 +0000
In-Reply-To: <4411F87B.2070902@mnsu.edu> (Jeffrey Hundstad's message of "Fri, 10 Mar 2006 16:06:51 -0600")
Message-ID: <yw1x3bhp2rfw.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> writes:

> Måns Rullgård wrote:
>
>>Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>>
>>>>Subject: can I bring Linux down by running "renice -20
>>>>cpu_intensive_process"?
>>>>
>>> Depends on what the cpu_intensive_process does. If it tries to
>>> allocate lots of memory, maybe. If it's _just_ CPU (as in `perl -e
>>> '1 while 1'`), you get a chance that you can input some commands on
>>> a terminal to kill it.
>>>SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.
>>
>>Sysrq+n changes all realtime tasks to normal priority.
>
> Patient: "Doctor When I poke myself in the eye it hurts."
> Doctor "Don't do that then."

A bug might cause an otherwise well-behaved realtime process to start
spinning in a loop or something.  Having a way to stop it is good,
IMHO.

-- 
Måns Rullgård
mru@inprovide.com
