Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWHXQCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWHXQCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWHXQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:02:47 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:24318 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030205AbWHXQCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:02:46 -0400
Subject: Re: [patch] dubious process system time.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608241718.29406.ak@suse.de>
References: <20060824121825.GA4425@skybase> <p731wr6fh54.fsf@verdi.suse.de>
	 <1156426103.28464.29.camel@localhost>  <200608241718.29406.ak@suse.de>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 24 Aug 2006 18:02:43 +0200
Message-Id: <1156435363.28464.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 17:18 +0200, Andi Kleen wrote:
> > At the moment hardirq+softirq is just added to a random process, in
> > general this is completely wrong. 
> 
> It's better than not accounting it at all.

I think it is worse than not accounting it. You are "charging" a process
of some user for something that the user has nothing to do with.

> > You just need a system with a cpu hog 
> > and an i/o bound process and you get queer results.
> 
> Yes, but system load that is invisible to standard monitoring
> tools is even worse.

But it isn't invisible. cpustat->hardirq and cpustate->softirq will be
increased. /proc/stat will show the system time spent in these two
contexts.

> If you stop accounting it to random processes you have to 
> account it somewhere else. Preferably somewhere that standard tools
> automatically pick up.

Again, why do I have to account non-process related time to a process?
Ihmo that is completly wrong.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


