Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVK1Sa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVK1Sa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVK1Sa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:30:57 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:45781 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932148AbVK1Sa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:30:56 -0500
Date: Mon, 28 Nov 2005 10:35:17 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
Message-ID: <20051128183517.GA4549@hockin.org>
References: <1133179554.11491.3.camel@localhost.localdomain> <20051128173040.GA32547@hockin.org> <1133199568.7416.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133199568.7416.31.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 12:39:28PM -0500, Lee Revell wrote:
> On Mon, 2005-11-28 at 09:30 -0800, thockin@hockin.org wrote:
> > The kernel's use of TSC is wholly incorrect.  TSCs can ramp up and
> > down and *do* vary between nodes as well as between cores within a
> > node.  You really can not compare TSCs between cpu cores at all, as is
> > (and the kernel assumes 1 global TSC in at least a few places). 
> 
> That's one way to look at it; another is that the AMD dual cores have a
> broken TSC implementation.  The kernel's use of the TSC was never a
> problem in the past...

Sure.  But the OS can be fixed, the chips can not.  That said, I'd like to
see a spec that says TSCs are a) synced, b) linear.  If such a beast
exists, then we can all mock AMD publicly.  If not, we should hush up and
fix the parts that can be fixed.
