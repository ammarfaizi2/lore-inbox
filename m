Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVK1SbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVK1SbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVK1SbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:31:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932162AbVK1SbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:31:16 -0500
Date: Mon, 28 Nov 2005 13:30:23 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: thockin@hockin.org, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] read_tsc: ACK! TSC went backward! Unsynced TSCs?
Message-ID: <20051128183023.GC30899@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	john stultz <johnstul@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1133179554.11491.3.camel@localhost.localdomain> <20051128173040.GA32547@hockin.org> <1133199568.7416.31.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133199568.7416.31.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
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

Not true. Speedstep, or anything else that uses SMI to disappear
into magick bios code for long periods of time also have exactly
the same issue.

This is not a new problem.

		Dave

