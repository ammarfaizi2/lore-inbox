Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbUKJBxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbUKJBxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUKJBva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:51:30 -0500
Received: from peabody.ximian.com ([130.57.169.10]:23259 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261830AbUKJBth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:49:37 -0500
Subject: Re: Ideas for a new io scheduler for desktop
From: Robert Love <rml@novell.com>
To: Pedro Larroy <piotr@larroy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041110013235.GA13691@larroy.com>
References: <20041110013235.GA13691@larroy.com>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 20:50:19 -0500
Message-Id: <1100051419.18601.105.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 02:32 +0100, Pedro Larroy wrote:

> I think that a new io-scheduler that gave priority to bursty access to
> block devices would be interesting for desktop and workstation use, and
> even for some servers.
> 
> I'm often waiting for graphical aplications, vim, mutt, and almost every
> program to which I have to interact with because they are blocked
> waiting for just a few blocks of IO that won't get served fast just
> because there's a single process hog that's provoking that high latency.
> 
> In network terminology the disk just feel like a network interface without QoS, 
> service time just goes up insanely with just one client in the queue.
> 
> Although much care should be taken in designing this algorithm to
> prevent unfairness, I believe there's room for improvement in this area.
> 
> I'd like to read about your opinions.

What you are seeing is the affect of read requests being synchronous,
and thus the pain of read latency, and write requests to one part of the
disk starving other requests.

Have you tried the new 2.6 I/O schedulers?  They should prevent this
problem.

If you are using 2.6, then your problem might not lie with the I/O
scheduler.  Read request deadlines are very low in both the deadline and
anticipatory I/O scheduler.

	Robert Love


