Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbUKJCI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUKJCI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUKJCI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:08:27 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:50589 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S261868AbUKJCHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:07:51 -0500
Date: Wed, 10 Nov 2004 03:07:44 +0100
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ideas for a new io scheduler for desktop
Message-ID: <20041110020744.GA13741@larroy.com>
Mail-Followup-To: Robert Love <rml@novell.com>,
	linux-kernel@vger.kernel.org
References: <20041110013235.GA13691@larroy.com> <1100051419.18601.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1100051419.18601.105.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 08:50:19PM -0500, Robert Love wrote:
> On Wed, 2004-11-10 at 02:32 +0100, Pedro Larroy wrote:
> 
> > I think that a new io-scheduler that gave priority to bursty access to
> > block devices would be interesting for desktop and workstation use, and
> > even for some servers.
> > 
> > I'm often waiting for graphical aplications, vim, mutt, and almost every
> > program to which I have to interact with because they are blocked
> > waiting for just a few blocks of IO that won't get served fast just
> > because there's a single process hog that's provoking that high latency.
> > 
> > In network terminology the disk just feel like a network interface without QoS, 
> > service time just goes up insanely with just one client in the queue.
> > 
> > Although much care should be taken in designing this algorithm to
> > prevent unfairness, I believe there's room for improvement in this area.
> > 
> > I'd like to read about your opinions.
> 
> What you are seeing is the affect of read requests being synchronous,
> and thus the pain of read latency, and write requests to one part of the
> disk starving other requests.
> 
> Have you tried the new 2.6 I/O schedulers?  They should prevent this
> problem.
> 
> If you are using 2.6, then your problem might not lie with the I/O
> scheduler.  Read request deadlines are very low in both the deadline and
> anticipatory I/O scheduler.
> 
> 	Robert Love
> 

Yes, I use them in all of my boxes.

Regards.
-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
