Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULHRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULHRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULHRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:11:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27071 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261267AbULHRLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:11:52 -0500
Date: Wed, 8 Dec 2004 09:05:04 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Darren Hart <darren@dvhart.com>
Cc: lkml <linux-kernel@vger.kernel.org>, blainey@ca.ibm.com,
       Martin J Bligh <mbligh@aracnet.com>, nacc@us.ibm.com,
       johnstul@us.ibm.com, fultonm@ca.ibm.com, paulmck@us.ibm.com
Subject: Re: nanosleep resolution, jiffies vs microseconds
Message-ID: <20041208170504.GA4192@w-mikek2.beaverton.ibm.com>
References: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102524468.16986.30.camel@farah.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 08:47:48AM -0800, Darren Hart wrote:
> I am looking at trying to improve the latency of nanosleep for short
> sleep times (~1ms).  After reading Martin Schwidefsky's post for cputime
> on s390 (Message-ID:
> <20041111171439.GA4900@mschwid3.boeblingen.de.ibm.com>), it seems to me
> that we may be able to accomplish this by storing the expire time in
> microseconds rather than jiffies.

My only question would be 'why'?  Is there some environment where this
is an issue? -OR- Is this just 'something to do'?  Seems to me that the
only environment where this could be an issue is for 'realtime' tasks.
For non-realtime, I would guess that the variability of preemption/scheduling 
makes this almost a non-issue.  In environments where I have seen heavy
use of nanosleep, there were other scheduling issues that almost always
cause one to 'sleep' longer than the specified time.  I'm not opposed to
work in this area.  Just curious as to why?

-- 
Mike
