Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbUKPJgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUKPJgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUKPJgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:36:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:39565 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261585AbUKPJgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:36:44 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: john stultz <johnstul@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1100592718.2811.8.camel@laptop.fenrus.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
	 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
	 <1100592718.2811.8.camel@laptop.fenrus.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 01:36:32 -0800
Message-Id: <1100597793.13732.7.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 09:11 +0100, Arjan van de Ven wrote:
> > While there are a great number of systems that can use the TSC, cpufreq
> > scaling laptops, and a number of SMP and NUMA systems cannot use it as a
> > time source. 
> 
> please don't drag cpufreq into this; cpufreq adjusts this timer on
> frequency changes just fine.

Fair enough. Dominik and others have done some great work there and I
shouldn't cast doubt on it.  I just haven't played with it enough to
really get confident that there really aren't any holes with it. 

That said, not all laptops properly notify the kernel when they change
frequency. The BIOS just changes it on its own. My old one had this
problem and the pmtmr helped quite a bit there. But maybe these cases
are just rare enough that its not an issue.

thanks
-john

