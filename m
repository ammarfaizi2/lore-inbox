Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286435AbRLTWhS>; Thu, 20 Dec 2001 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286432AbRLTWhJ>; Thu, 20 Dec 2001 17:37:09 -0500
Received: from [217.9.226.246] ([217.9.226.246]:13952 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286433AbRLTWhF>; Thu, 20 Dec 2001 17:37:05 -0500
To: george anzinger <george@mvista.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <Pine.LNX.4.40.0112201252450.1622-100000@blue1.dev.mcafeelabs.com>
	<3C22654D.7FC80713@mvista.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <3C22654D.7FC80713@mvista.com>
Date: 21 Dec 2001 00:21:37 +0200
Message-ID: <87y9jxzg5q.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "George" == george anzinger <george@mvista.com> writes:

George> Davide Libenzi wrote:
>> Local RT tasks apply POSIX priority rules inside the local CPU, that means
>> that an RT task running on CPU0 cannot preempt another task ( being it
>> normal or RT ) on CPU1.
[...]
>> Global RT tasks, that live in a separate run queue, have the ability to
>> preempt remote CPU and this can lead.
[...]
>> The local/global RT task selection is done with setscheduler() with a new
>> ( or'ed ) flag SCHED_RTGLOBAL, and this means that the default is RT task
>> local.

George> My understanding of the POSIX standard is the the highest priority
George> task(s) are to get the cpu(s) using the standard calls.  If you want to
George> deviate from this I think the standard allows extensions, but they IMHO
George> should be requested, not the default, so I would turn your flag around
George> to force LOCAL, not GLOBAL.

I'd like to second that, IMHO the RT task scheduling should trade
throughput for latency, and if someone wants priority inversion, let
him explicitly request it.

Regards,
-velco

