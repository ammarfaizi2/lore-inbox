Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbUCJVvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUCJVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:51:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15100 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262849AbUCJVtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:49:53 -0500
Subject: Re: ACPI PM Timer vs. C1 halt issue
From: john stultz <johnstul@us.ibm.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Dominik Brodowski <linux@brodo.de>
In-Reply-To: <404E4913.3020005@gmx.de>
References: <404E38B7.5080008@gmx.de>
	 <1078870289.12084.8.camel@cog.beaverton.ibm.com>  <404E4913.3020005@gmx.de>
Content-Type: text/plain
Message-Id: <1078955372.2696.23.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 10 Mar 2004 13:49:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-09 at 14:45, Prakash K. Cheemplavam wrote:
> john stultz wrote:
> > On Tue, 2004-03-09 at 13:35, Prakash K. Cheemplavam wrote:
> > 
> >>I found out what causes higher idle temps when using mm-sources and 
> >>2.6.4-rc vanilla sources: If I use PM Timer as timesource, it seems the 
> >>C1 halt isn't properly called, at least CPU disconnect doesn't seem to 
> >>work, thus leaving my CPU as hot as without disconnect.
> [snip]
> > 
> > Sounds like a bug. I'm not very familiar w/ the ACPI cpu power states,
> > is there anything you have to do to trigger C1 Halt? Or is it just
> > called in the idle loop?
> 
> It should be called within the idle loop.

Hmm. I'm still stumped. Looking at acpi_processor_idle(), the C1 state
doesn't touch the ACPI PM timer. The C2 and C3 states do, but they just
read.  

Dominik: Do you have a clue on this?

thanks
-john

