Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266672AbUAWUQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUAWUQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:16:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:56767 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266672AbUAWUQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:16:41 -0500
Subject: Re: keyboard and USB problems (Re: 2.6.2-rc1-mm2)
From: john stultz <johnstul@us.ibm.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040123195439.GA7878@ucw.cz>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
	 <20040123160152.GA18073@ss1000.ms.mff.cuni.cz>
	 <20040123161946.GA6934@ucw.cz> <1074886056.12447.36.camel@localhost>
	 <20040123195439.GA7878@ucw.cz>
Content-Type: text/plain
Message-Id: <1074888902.12442.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 23 Jan 2004 12:15:03 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 11:54, Vojtech Pavlik wrote:
> On Fri, Jan 23, 2004 at 11:27:41AM -0800, john stultz wrote:
> > Well, loops_per_jiffy is actually being measured correctly as we're
> > using the acpi pm timesource to time udelay(). However there is a loss
> > of resolution using the slower time source, so udelay(1) might take
> > longer then 1 us. 
> 
> Longer udelay shouldn't cause trouble. Shorter one definitely would.

Hmm. 

> > If that is going to cause problems, then we'll need to pull out the
> > use-pmtmr-for-delay_pmtmr patch. I guess our only option is then to use
> > the TSC for delay_pmtrm() (as a loop based delay fails in other cases).
> > I'll write that up and send it your way, Andrew. 
> 
> I've seen the PM timer breaking the mouse operation rather badly in the
> past, the lost-sync check was triggering for many people when the PM
> timer was used. This implies time inacurracy in the range of 0.5
> seconds. Could that happen somehow?

Not in a way that I yet understand. Do you see similar problems with
folks using clock=pit?

thanks
-john


