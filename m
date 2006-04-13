Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWDMWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDMWiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWDMWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:38:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:51360 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750939AbWDMWiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:38:51 -0400
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060413222721.GN24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	 <20060413022809.GD24769@pb15.lixom.net>
	 <20060413025233.GE24769@pb15.lixom.net>
	 <20060413064027.GH10412@granada.merseine.nu>
	 <1144925149.4935.14.camel@localhost.localdomain>
	 <20060413160712.GG24769@pb15.lixom.net>
	 <1144961515.4935.22.camel@localhost.localdomain>
	 <20060413222721.GN24769@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 08:38:31 +1000
Message-Id: <1144967911.4935.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 17:27 -0500, Olof Johansson wrote:
> On Fri, Apr 14, 2006 at 06:51:55AM +1000, Benjamin Herrenschmidt wrote:
> 
> > an improvement with the DART thanks to virtual merging. Currently, we
> > pay a cost due to our stupid invalidate mecanism that we should really
> > fix by shooting the TLB directly.
> 
> What was keeping me from implementing this before was the lack of public
> documentation on how to do it. Has that changed? I'd be happy to do the
> implementation.

Darwin has the macros to access the TLB though it doesn't use them... I
suppose I can get the necessary doco bit from the microelectronics folks
for the CPC925, that should apply to U3 as well, though U4 has a
different format afaik. I'll dig and will come back to you.

> > Also have you made sure all your
> > additions for handling crappy hardware are nicely wrapped in unlikely()
> > statements ? :)
> 
> I would expect the dynamic predictor to work quite well on this. I'm not
> worried about the overhead of the tests as much as the overhead of
> having to enable the DART for smaller configs. If benchmark profiling
> shows different down the road then we can add them.

Ok.

Ben.


