Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVBNGTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVBNGTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 01:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVBNGTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 01:19:04 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:45715 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261354AbVBNGTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 01:19:00 -0500
Subject: Re: Linux 2.6.8.1 CPU Scheduler Documentation
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: Josh Aas <josha@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050214052812.GA31941@alpha.home.local>
References: <420FEF73.30908@sgi.com>
	 <20050214052812.GA31941@alpha.home.local>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 17:18:56 +1100
Message-Id: <1108361936.5256.22.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 06:28 +0100, Willy Tarreau wrote:
> Hello Josh,
> 
> On Sun, Feb 13, 2005 at 06:23:15PM -0600, Josh Aas wrote:
> > Hello,
> > 
> > I have written an introduction to the Linux 2.6.8.1 CPU scheduler 
> > implementation. It should help people to understand what is going on in 
> > the scheduler code faster than they would be able to by just reading 
> > through the code. The paper can be downloaded in PDF or LyX form from 
> > here:
> > 
> > http://josh.trancesoftware.com/linux/
> 
> This is quite an interesting documentation.
> 

The multiprocessor scheduling documentation looks pretty
accurate, at a quick glance. A few small things though:

I don't think you place enough emphasis on the per-CPU-ness
of the 2.6 scheduler. For most workloads, this probably
yields by far the biggest improvement over the 2.4 scheduler
on even small SMP systems, due to much less lock and cacheline
contention.

Secondly, 7.1.2 can probably be removed completely. We can
actually handle this type of SMT balancing correctly without
shared runqueues (and in an arguably nicer way).

Nick


