Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTHSTGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTHSTFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:05:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55051
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261185AbTHSTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:02:53 -0400
Date: Tue, 19 Aug 2003 12:02:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
Message-ID: <20030819190249.GE19465@matchmail.com>
Mail-Followup-To: Eric St-Laurent <ericstl34@sympatico.ca>,
	Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au> <1061266033.2900.43.camel@orbiter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061266033.2900.43.camel@orbiter>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:07:13AM -0400, Eric St-Laurent wrote:
> - a /proc tunable might be needed to let the user choose the
> interactivity vs efficiency compromise. for example, with 100 background
> tasks, does the user want the most efficiency or prefer wasting some
> cycles to get a smoother progress between jobs?
> 

No, this should be avoided.  Then you get a bunch of web pages talking about
how this tunable should be set this way, and the problem cases will not be
reported to the people who can fix them.  This is good.

> - nanoseconds, or better, cycle accurate (rdtsc) timeslice accouting, it
> may help heuristics.
> 

Already done.  See the scheduler patch Ingo submitted a few weeks ago.

