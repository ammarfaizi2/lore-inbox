Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSAPWlx>; Wed, 16 Jan 2002 17:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290010AbSAPWln>; Wed, 16 Jan 2002 17:41:43 -0500
Received: from baghira.han.de ([212.63.63.2]:6148 "EHLO baghira.han.de")
	by vger.kernel.org with ESMTP id <S290009AbSAPWlb>;
	Wed, 16 Jan 2002 17:41:31 -0500
To: linux-kernel@vger.kernel.org
Path: jum
From: jum@anubis.han.de (Jens-Uwe Mager)
Newsgroups: hannet.ml.linux.rutgers.linux-kernel
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
Date: 16 Jan 2002 22:41:17 GMT
Organization: At Home
Message-ID: <slrna4c0di.at4.jum@anubis.han.de>
In-Reply-To: <mng==Pine.LNX.4.40.0201151803020.940-100000@blue1.dev.mcafeelabs.com> <mng==1011149980.8756.180.camel@phantasy>
NNTP-Posting-Host: anubis.han.de
X-Trace: baghira.han.de 1011220877 12441 212.63.63.3 (16 Jan 2002 22:41:17 GMT)
X-Complaints-To: usenet@baghira.han.de
NNTP-Posting-Date: 16 Jan 2002 22:41:17 GMT
User-Agent: slrn/0.9.6.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002 03:00:45 GMT, Robert Love <rml@tech9.net> wrote:
>On Tue, 2002-01-15 at 21:04, Davide Libenzi wrote:
>
>> On 15 Jan 2002, Robert Love wrote:
>> > This isn't a bad idea, as long as we don't use it as a crutch or
>> > excuse.  That is, answer scheduling problems with "properly nice your
>> > tasks" -- the scheduler should be smart enough, to some degree.
>> >
>> > FWIW, Solaris actually implements a completely different scheduling
>> > policy, SCHED_INTERACT or something.  It is for windowed tasks in X --
>> > they get a large interactivity bonus.
>
>> Now ( with 2.5.3-pre1 ) intractivity is *very good* but SCHED_INTERACT
>> would help *a lot* to get things even more right.
>
>I looked it up; its called class IA.  I don't know if it grows from a
>limitation of their scheduler (i.e. they can't calculate priority and be
>as fair to interactive tasks as us) or if it offers a fundamental
>advantage.  I suspect their are a myriad of things things we can do with
>an interactive/GUI scheduling policy.
>
>One thing this is, since their kernel is preemptible, it marks processes
>that very much always deserve a scheduling boost based on interactivity,
>and thus their interactivity is quite nice.

I would believe the IA class is a hack to maintain good interactive
performance for the X window apps if the scheduler does not maintain
this itself in the TS (time sharing class). The standard Solaris
scheduler is not favoring I/O bound programs properly, especially if
these are driven by network connections. I have several programs that
are of the type poll() - recv() - work a little - send() type loops and
these get slow to a crawl if run in the TS class if the foreground
process (also in TS) is compute bound.

-- 
Jens-Uwe Mager	<pgp-mailto:62CFDB25>
