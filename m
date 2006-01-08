Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWAHWVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWAHWVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWAHWVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:21:16 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:21344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964957AbWAHWVP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:21:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VULTj4WXcTSzj92dwCrzoWWmeEf7/luIf9lv+kJc6DSVhWgAIsbSg1+XlPAcOlrvqeQRcuIDPzarGqdHXCx+QDf3aytJw9LsxISAZyYly724rEbsBw7nWkZ5L4zUE6Jkk1kQjIImSHY4TkB5e/L4518k+ZfWcf/VMEHn/viUygg=
Message-ID: <5bdc1c8b0601081421h55d9c66clb1e9c52123f1e0c1@mail.gmail.com>
Date: Sun, 8 Jan 2006 14:21:13 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <43C18E09.9060600@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
	 <43C17E50.4060404@stud.feec.vutbr.cz>
	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
	 <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
	 <43C18E09.9060600@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/06, Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> Mark Knecht wrote:
> > On 1/8/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >>>>  I did run across a way that I can create a repeatable xrun on my
> >>>>AMD64 machine by burning a CD in k3b while Jack is running.
> >>>>Unfortunately I do not see any good trace data in dmesg when I do it.
> >>>Maybe your cdrecord is running with realtime priority higher than Jack?
> >>>Michal
> >>cdrecord does run with SCHED_RR/99 when started with proper privileges.
> >>
> > Ah, then it's likely that this isn't a real problem and it would be
> > expected to cause an xrun?
>
> By running cdrecord with a higher priority than Jack, you're telling the
> system that burning the CD is more important than not getting xruns in Jack.

Logically what you say makes sense but cdrecord, if it's running at
all, is running inside of an app called k3b. k3b doesn't seem to have
a config option for priorities, etc., so maybe it's hardwired. I'll
ask on the k3b list.

Sorry for the noise.

Cheers,
Mark
