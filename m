Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSI0BBo>; Thu, 26 Sep 2002 21:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261591AbSI0BBo>; Thu, 26 Sep 2002 21:01:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25584 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261590AbSI0BBn>;
	Thu, 26 Sep 2002 21:01:43 -0400
Message-ID: <3D93AF1C.13F96D79@mvista.com>
Date: Thu, 26 Sep 2002 18:06:36 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] High-res-timers part 1 (core)
References: <3D93A363.ACA56815@mvista.com> <20020926205808.A15402@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Thu, Sep 26, 2002 at 05:16:35PM -0700, george anzinger wrote:
> > hash list.  This change makes it easy to configure the list
> > size for those who are concerned with performance.  It also
> > eliminates the "time out" for the cascade operation every
> 
> Could you make the list size configurable at boot time or by sysctl?
> It's almost impossible for distro vendors to get these kinds of tunables
> right for everyone, so making them dynamic is preferred.
> 
>                 -ben
Hm, that would require dynamic allocation of the memory,
probably not an issue, but the masks would also need to be
dynamic.  The question is is it worth it.  The 512 entry
list seems to handle a very large number of timers with no
trouble.  We did tests measuring timer arm times with 4000
timers in the list.  The slope was so low that we did not
even try to increase the list size.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
