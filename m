Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWDMW14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWDMW14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWDMW14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:27:56 -0400
Received: from lixom.net ([66.141.50.11]:60325 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932474AbWDMW1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:27:55 -0400
Date: Thu, 13 Apr 2006 17:27:21 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB, V2
Message-ID: <20060413222721.GN24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net> <20060413022809.GD24769@pb15.lixom.net> <20060413025233.GE24769@pb15.lixom.net> <20060413064027.GH10412@granada.merseine.nu> <1144925149.4935.14.camel@localhost.localdomain> <20060413160712.GG24769@pb15.lixom.net> <1144961515.4935.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144961515.4935.22.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 06:51:55AM +1000, Benjamin Herrenschmidt wrote:

> an improvement with the DART thanks to virtual merging. Currently, we
> pay a cost due to our stupid invalidate mecanism that we should really
> fix by shooting the TLB directly.

What was keeping me from implementing this before was the lack of public
documentation on how to do it. Has that changed? I'd be happy to do the
implementation.

> Also have you made sure all your
> additions for handling crappy hardware are nicely wrapped in unlikely()
> statements ? :)

I would expect the dynamic predictor to work quite well on this. I'm not
worried about the overhead of the tests as much as the overhead of
having to enable the DART for smaller configs. If benchmark profiling
shows different down the road then we can add them.


-Olof
