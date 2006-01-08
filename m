Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932777AbWAHWEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWAHWEM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWAHWEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:04:12 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:148 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932777AbWAHWEM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:04:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/Elcqt5AX2mlohH6uo+zYs88nYMg+x16p+nCxKJPfXByL6S1hOmusJToQ0F9FLSSJnaS9p4OhRaFO3aIMyXA0rnMbIBnLfIZC5GBI3+mXeLE4VqHgTSNz2m6nYRlBdSjXJEpW7i8EvYBJTNYPGaZaPUykdgwDXv8GF2g41I/eA=
Message-ID: <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
Date: Sun, 8 Jan 2006 14:04:10 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com>
	 <43C17E50.4060404@stud.feec.vutbr.cz>
	 <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Hi,
> >>   I did run across a way that I can create a repeatable xrun on my
> >> AMD64 machine by burning a CD in k3b while Jack is running.
> >> Unfortunately I do not see any good trace data in dmesg when I do it.
> >
> > Maybe your cdrecord is running with realtime priority higher than Jack?
> > Michal
>
> cdrecord does run with SCHED_RR/99 when started with proper privileges.
>
Ah, then it's likely that this isn't a real problem and it would be
expected to cause an xrun?

Anyway, it seems strange that the trace doesn't show anything. I
suppose that's because cdrecord just grabs a lot of time at a higher
priority than Jack and Jack ends up not getting serivces at all for
5-10mS?

OK, back to the drawing board about debugging my problems!

thanks!

- Mark
