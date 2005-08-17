Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVHQAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVHQAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVHQAV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:21:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:30602 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750771AbVHQAV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:21:26 -0400
Date: Tue, 16 Aug 2005 17:21:01 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: john stultz <johnstul@us.ibm.com>
cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
In-Reply-To: <1124237849.8630.112.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0508161718010.9893@schroedinger.engr.sgi.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com> 
 <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>
  <1124151001.8630.87.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com> 
 <1124236081.8630.110.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.62.0508161710580.9829@schroedinger.engr.sgi.com>
 <1124237849.8630.112.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005, john stultz wrote:

> That is why I'm suggesting time_interpolator users to move to my code
> (when they're ready, of course :).

Both are basically timesources. That is why I would suggest you upgrade 
the interpolators to timesources. Doing that would enable a gradual 
transition instead of a cutover to a new time subsystem. It should also 
insure that the gains we have made in terms of accuracy of time will be 
preserved in the new system. And the code would be able to use the 
existing proven code that already allows system time with nanosecond 
precision.


