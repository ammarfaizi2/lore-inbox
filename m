Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSGKHHh>; Thu, 11 Jul 2002 03:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317773AbSGKHHg>; Thu, 11 Jul 2002 03:07:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19447 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317772AbSGKHHf>;
	Thu, 11 Jul 2002 03:07:35 -0400
Message-ID: <3D2D2F3D.BB1D309E@mvista.com>
Date: Thu, 11 Jul 2002 00:09:49 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "'CaT'" <cat@zip.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
       Andrew Morton <akpm@zip.com.au>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F94@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > From: CaT [mailto:cat@zip.com.au]
> > On Wed, Jul 10, 2002 at 05:42:51PM -0400, Benjamin LaHaise wrote:
> > > On Wed, Jul 10, 2002 at 02:38:32PM -0700, Andrew Morton wrote:
> > > > OK, I'll grant that.  Why is this useful?
> > >
> > > Think video playback, where you want to queue the frame to
> > be played as
> > > close to the correct 1/60s time as possible.  With HZ=100,
> > the code will
> >
> > Or 1/50 (think PAL), no? (Of course HZ=100 would be sweet for that. ;)
> 
> I don't know if I should mention this, but...
> 
> Win2k's default timer tick is 10ms (i.e. 100HZ) but it will go as low as 1ms
> (1000HZ) if people request timers with that level of granularity. On the
> fly.

This is what the high-res-timers patch does.  It always does
the 1/HZ tick, but if a timer is requested with finer
granularity (resolution) an interrupt is scheduled to take
care of it.  Check it out.  You will find it here:
http://sourceforge.net/projects/high-res-timers/
> 
> So, a changing tick *can* be done. If Linux does the same thing, seems like
> everyone is happy. What are the obstacles to this for Linux? If code is
> based on the assumption of a constant timer tick, I humbly assert that the
> code is broken.
> 
> Regards -- Andy
> -

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
