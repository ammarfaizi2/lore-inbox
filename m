Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968662AbWLEThc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968662AbWLEThc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968663AbWLEThc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:37:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53167 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968662AbWLEThb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:37:31 -0500
Subject: Re: PMTMR running too fast
From: john stultz <johnstul@us.ibm.com>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165304498.5499.62.camel@localhost.localdomain>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <1165261226.5499.54.camel@localhost.localdomain>
	 <1165263296.6152.8.camel@localhost.localdomain>
	 <1165304498.5499.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 11:34:01 -0800
Message-Id: <1165347242.8326.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 07:41 +0000, Ian Campbell wrote:
> On Mon, 2006-12-04 at 12:14 -0800, john stultz wrote:
> > I don't have a dev box to test on at the moment, but here's a quick hack
> > attempt at re-adding the code. Does the following work for you? 
> 
> I get:
>         PM-Timer running at invalid rate: 200% of normal - aborting.
>         ...
>         Time: pit clocksource has been installed.
>         
> Without the clocksource parameter.

Great!

> Should tsc be preferred to pit though?

Depends on your system. If C2/C3 or cpufreq state changes are detected,
we mark the tsc as unstable. 

It sounds as if from your earlier email the TSC works fine, so we might
want to look at what's making the system think its not ok. I probably
need to add a message as to why it was disqualified. However, that's a
separate issue from the last patch.

Thanks for the testing!

-john




