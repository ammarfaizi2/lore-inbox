Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUFPBBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUFPBBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 21:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUFPBBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 21:01:22 -0400
Received: from fmr06.intel.com ([134.134.136.7]:63372 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266049AbUFPBBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 21:01:20 -0400
Date: Tue, 15 Jun 2004 18:01:04 -0700
From: Rusty Lynch <rusty@linux.jf.intel.com>
To: faith@redhat.com
Cc: linux-kernel@vger.kernel.org, atul_sabharwal@linux.jf.intel.com
Subject: Re: [Announce] Non Invasive Kernel Monitor for threads/processes
Message-ID: <20040616010104.GA23727@penguin2.jf.intel.com>
References: <40CF4233.70709@linux.jf.intel.com> <40CF5D39.1060701@linux.jf.intel.com> <20040615142304.5d9591d5.akpm@osdl.org> <40CF9382.2010008@linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CF9382.2010008@linux.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton wrote:
> >Atul Sabharwal <atul_sabharwal@linux.jf.intel.com> wrote:
> >>We have been working with a solution for non-intrusively trapping on 
> >>lifetime
> >>of processes/threads.
> >>   
> >>
> >
> >I expect this functionality can be provided without kernel changes via
> >auditing of the relevant system calls.  See
> >http://people.redhat.com/faith/audit/.

If a process segfaults is there currently a message sent from the auditing
code?

> >Maybe there are shortcomings in the current auditing/filtering framework. 
> >If so, perhaps they could be addressed.

I have worries about both the complexity required from the client for just
monitoring the life time of a process/thread, and the overhead of doing
this with the auditing/netlink implementation, but do not have any proof.

We can take a crack at implementing a couple of hello world monitors for
process/thread creation and exec'ing, and come back with any limitations
in the existing auditing code that would make this particular type of 
monitoring painful.

    --rustyl
