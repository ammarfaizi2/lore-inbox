Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUIGVsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUIGVsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268684AbUIGVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:47:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3580 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268685AbUIGVou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:44:50 -0400
Message-ID: <413E2B2E.3000706@mvista.com>
Date: Tue, 07 Sep 2004 14:42:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, paulus@samba.org,
       schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> <20040903151710.GB12956@wotan.suse.de> <1094242317.14662.556.camel@cog.beaverton.ibm.com> <20040904130022.GB21912@wotan.suse.de> <Pine.LNX.4.58.0409070908290.8484@schroedinger.engr.sgi.com> <413DFCC2.7080405@mvista.com> <Pine.LNX.4.58.0409071354150.9990@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409071354150.9990@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 7 Sep 2004, George Anzinger wrote:
> 
> 
>>Also, we don't "know" what rate the TSC is actually clocking so we must
>>"discover" it at boot time.  This process either is inaccurate or slow (I think
>>we use ~ 50 ms these days which gives an error of ~10 TSC cycles on a 800MHZ
>>box).  FWIW the problem here is the sync up with the I/O backplane to find the
>>start and ending of the measured time.
>>
>>I suspect that the IA64 "tells" you what its clock rate is.  Right?
> 
> 
> Not the CPU itself. There is a special hardware I/O interface called the
> PAL/SAL that allows one to retrieve that information. Doesn't the BIOS on
> i386 allow you to get to that information?

Not as far as I know.  If it did we would kick out the calibrate loop and boot 
some 50ms faster (always a good thing).  Could be somebody else has better info 
here...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

