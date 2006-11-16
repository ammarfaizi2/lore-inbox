Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424648AbWKPV0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424648AbWKPV0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424646AbWKPV0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:26:54 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:63909 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1424636AbWKPV0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:26:53 -0500
Date: Thu, 16 Nov 2006 16:26:52 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Thomas Gleixner <tglx@timesys.com>
cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: BUG: cpufreq notification broken
In-Reply-To: <1163711368.10333.41.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0611161625020.2460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Thomas Gleixner wrote:

> There is another issue with this SRCU change:
> 
> The notification comes actually after the real change, which is bad. We
> try to make the TSC usable by backing it with pm_timer accross such
> states, but this behaviour breaks the safety code.

I don't understand.  Sending notifications is completely separate from 
setting up the notifier chain's head.  The patch you mentioned didn't 
touch the code that sends the notifications.

Alan Stern

