Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUCZXJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCZXJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:09:21 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:64156 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261418AbUCZXJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:09:20 -0500
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Praedor Atrebates <praedor@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200403261654.57525.praedor@yahoo.com>
References: <200403261430.18629.praedor@yahoo.com>
	 <1080336165.5408.307.camel@cog.beaverton.ibm.com>
	 <200403261654.57525.praedor@yahoo.com>
Content-Type: text/plain
Message-Id: <1080342556.5408.322.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 26 Mar 2004 15:09:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 13:54, Praedor Atrebates wrote:
> On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> > On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > > In doing a web search on system clock speeds being too high, I found
> > > entries describing exactly what I am experiencing in the linux-kernel
> > > list archives, but have not yet found a resolution.
> [...]
> > > Does anyone have any enlightenment, or a fix, to offer?  The exact same
> > > software setup on a desktop system, Athlon XP2700+, has no such problems.
> >
> > Could you please send me dmesg output for this system?
> >
> > Does booting w/ "clock=pit" help?
> 
> Thank you, this did fix the problem.  Now I have to set the type-matic setting 
> up because it is so sluggish.  
> 
> What is clock=pit doing?  What is behind this accelerated clock?

This is just manually overriding the automatic time source selection.
You're using the PIT (programmable interval timer) over what was being
automatically selected (according the to the dmesg you sent me, the
pmtmr or ACPI PM timer) by your kernel config. 

As clock=pit seemed to solve the problem, it looks like its a ACPI PM
issue. 

thanks
-john

