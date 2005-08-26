Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVHZT0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVHZT0j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbVHZT0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:26:39 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:40672 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030220AbVHZT0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:26:38 -0400
Subject: Re: Need better is_better_time_interpolator() algorithm
From: Alex Williamson <alex.williamson@hp.com>
To: george@mvista.com
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <430F6A7E.203@mvista.com>
References: <1124988269.5331.49.camel@tdi>
	 <1124991406.20820.188.camel@cog.beaverton.ibm.com>
	 <1124995405.5331.90.camel@tdi>
	 <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
	 <1125073089.5182.30.camel@tdi>  <430F6A7E.203@mvista.com>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 26 Aug 2005 13:26:57 -0600
Message-Id: <1125084417.5182.58.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 12:16 -0700, George Anzinger wrote:
> Alex Williamson wrote:
> > On Fri, 2005-08-26 at 08:39 -0700, Christoph Lameter wrote: 
> >>1. If a system boots up with a single cpu then there is no question that 
> >>the ITC/TSC should be used because of the fast access.
> 
> We need to factor in frequency shifting here, especially if it happens 
> with out notice.

   Would we ever want to favor a frequency shifting timer over anything
else in the system?  If it was noticeable perhaps we'd just need a
callback to re-evaluate the frequency and rescan for the best timer.  If
it happens without notice, a flag that statically assigns it the lowest
priority will due.  Or maybe if the driver factored the frequency
shifting into the drift it would make the timer undesirable without
resorting to flags.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

