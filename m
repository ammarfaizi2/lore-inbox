Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWHYK3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWHYK3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWHYK3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:29:32 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44381 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932400AbWHYK3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:29:32 -0400
Subject: Re: [patch] dubious process system time.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <44EECCF9.7080902@aitel.hist.no>
References: <20060824121825.GA4425@skybase> <p731wr6fh54.fsf@verdi.suse.de>
	 <1156426103.28464.29.camel@localhost>  <200608241718.29406.ak@suse.de>
	 <1156435363.28464.33.camel@localhost>  <44EECCF9.7080902@aitel.hist.no>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 25 Aug 2006 12:29:28 +0200
Message-Id: <1156501768.1640.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 12:12 +0200, Helge Hafting wrote:
> > Again, why do I have to account non-process related time to a process?
> > Ihmo that is completly wrong.
> >   
> If softirq time have to be accounted to a process (so as to not
> get lost), how about accounting it to the softirqd process?  Much
> more reasonable than random processes.

The main question still is if it is correct to add softirq/hardirq time
to the system time of a process. If the answer turns out to be yes, then
it might be a clever idea to account softirq time to the softirqd. That
still leaves the question what to do with hardirq time ..
My take still is that softirq/hardirq time does not belong to the system
time of any process.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


