Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbTHOQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbTHOQf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:35:27 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:35013
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S266054AbTHOQbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:31:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] O12.2int for interactivity
Date: Sat, 16 Aug 2003 02:38:05 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <20030814070119.GN32488@holomorphy.com> <3F3BEA65.8080907@techsource.com>
In-Reply-To: <3F3BEA65.8080907@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308160238.05185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 06:00, Timothy Miller wrote:
> If my guess from my previous email was correct (that is pri 5 gets
> shorter timeslide than pri 6), then that means that tasks of higher
> static priority have are penalized more than lower pri tasks for expiring.
>
> Say a task has to run for 15ms.  If it's at a priority that gives it a
> 10ms timeslice, then it'll expire and get demoted.  If it's at a
> priority that gives it a 20ms timeslice, then it'll not expire and
> therefore get promoted.
>
> Is that fair?

Yes, it's a simple cutoff at the end of the timeslice. If you use up the 
timeslice allocated to you, then you have to pass a test to see if you can go 
onto the active array or get expired. Since higher static priority (lower 
nice) tasks get longer timeslices, they are less likely to expire unless they 
are purely cpu bound and never sleep.

Con

