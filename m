Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751640AbVH0TbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbVH0TbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbVH0TbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 15:31:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62132 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751639AbVH0TbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 15:31:20 -0400
Date: Sat, 27 Aug 2005 13:55:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Alex Williamson <alex.williamson@hp.com>, george@mvista.com,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
Message-ID: <20050827115531.GA1109@openzaurus.ucw.cz>
References: <1124988269.5331.49.camel@tdi> <1124991406.20820.188.camel@cog.beaverton.ibm.com> <1124995405.5331.90.camel@tdi> <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com> <1125073089.5182.30.camel@tdi> <430F6A7E.203@mvista.com> <1125084417.5182.58.camel@tdi> <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    Would we ever want to favor a frequency shifting timer over anything
> > else in the system?  If it was noticeable perhaps we'd just need a
> > callback to re-evaluate the frequency and rescan for the best timer.  If
> > it happens without notice, a flag that statically assigns it the lowest
> > priority will due.  Or maybe if the driver factored the frequency
> > shifting into the drift it would make the timer undesirable without
> > resorting to flags.  Thanks,
> 
> Timers are usually constant. AFAIK Frequency shifts only occur through 
> power management. In that case we usually have some notifiers running 

Usually is the key word here. Older APM stuff changes frequency behind
your back, and sometimes frequency shift is time-critical.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

