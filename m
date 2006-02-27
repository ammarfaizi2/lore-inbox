Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWB0TJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWB0TJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWB0TJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:09:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:7891 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751723AbWB0TJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:09:46 -0500
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <4402C3BB.7010705@yahoo.com.au>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141027923.5785.50.camel@elinux04.optonline.net>
	 <4402C3BB.7010705@yahoo.com.au>
Content-Type: text/plain
Organization: IBM
Date: Mon, 27 Feb 2006 11:09:42 -0800
Message-Id: <1141067382.4770.699.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 20:17 +1100, Nick Piggin wrote:
> >  #ifdef CONFIG_SCHEDSTATS
> > +
> > +int schedstats_sysctl = 0;		/* schedstats turned off by default */
> 
> Should be read mostly.
> 
> > +static DEFINE_PER_CPU(int, schedstats) = 0;
> > +
> 
> When the above is in the read mostly section, you won't need this at all.
> 
> You don't intend to switch the sysctl with great frequency, do you?

No, it is not expected to switch often.

We originally coded it as __read_mostly, but thought the variable
bouncing between CPUs would be costly. Is it cheaper with
__read_mostly ? or it doesn't matter ?


-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


