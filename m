Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWBDTwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWBDTwo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWBDTwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:52:44 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:47883 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932552AbWBDTwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:52:43 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: athlon 64 dual core tsc out of sync
Date: Sat, 4 Feb 2006 19:52:40 +0000
User-Agent: KMail/1.9.1
Cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
References: <43E40D14.7070606@comcast.net> <1139079812.2791.45.camel@mindpipe>
In-Reply-To: <1139079812.2791.45.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602041952.40945.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 February 2006 19:03, Lee Revell wrote:
> On Fri, 2006-02-03 at 21:10 -0500, Ed Sweetman wrote:
> > I know this has been gone over before, and I am aware of the possible
> > fix being the use of the pmtmr.
> >
> > My question is, if there is support builtin to the kernel for more than
> > one timer, and we know that no timer but the pmtimer is reliable on a
> > dual core system, why doesn't the startup of the kernel choose the
> > pmtimer based on if it detects the system is a dual core proc with smp
> > enabled?   And if the pmtimer doesn't fix this sync issue, is there a
> > fix out there?   Currently with 2.6.16-rc1-mm5 the non-customized boot
> > args to the kernel results in these messages.
>
> Excellent question.  What's the status of this bug?  It's a showstopper
> for a ton of people on the JACK list...

As Andi has recounted many times already, pmtmr is now the default on x86-64 
if it's built in. I'm sure you can confirm this from the sources.

[alistair] 19:52 [~] uname -a
Linux damocles 2.6.15.1 #5 SMP PREEMPT Wed Feb 1 09:43:23 GMT 2006 x86_64 
x86_64 x86_64 GNU/Linux

[alistair] 19:52 [~] dmesg | egrep -e time.c.*PM
time.c: Using 3.579545 MHz PM timer.
time.c: Using PM based timekeeping.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
