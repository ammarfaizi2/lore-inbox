Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbTCTALl>; Wed, 19 Mar 2003 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbTCTALj>; Wed, 19 Mar 2003 19:11:39 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:8832 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S261242AbTCTALe>;
	Wed, 19 Mar 2003 19:11:34 -0500
Date: Wed, 19 Mar 2003 16:21:42 -0800
From: Jerry Cooperstein <coop@axian.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC] linux-2.5.65_clock-override_A0
Message-ID: <20030320002142.GA1478@p3.attbi.com>
References: <1048114445.4821.256.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048114445.4821.256.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 02:54:05PM -0800, john stultz wrote:
> All,
> 	Inspired by Stephen Hemminger's "boot time parameter to turn of TSC
> usage" patch, I implemented my own version that is a tad bit more
> flexible. 
> 
> With this patch, one can manually specify on the boot cmdline which time
> source should be used (if available) for calculating gettimeofday().
> This will override the default probed selection. Should the requested
> time-source not be available, the code defaults to using the PIT (and
> prints a warning saying so). 
> 
> Please let me know if you have any comments or suggestions.
> 
> thanks
> -john

Works fine on the hardware that started the whole thing.  This one requires
CONFIG_CPU_FREQ turned off (otherwise the keyboard freezes).  Stephen
Hemminger's required CONFIG_CPU_FREQ to be set (otherwise the keyboard
froze in this case as well, not being able to register interrupts), 
which made less sense.

good work.

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================
