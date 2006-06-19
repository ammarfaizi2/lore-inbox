Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWFSV4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWFSV4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWFSV4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:56:48 -0400
Received: from fmr17.intel.com ([134.134.136.16]:5340 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964927AbWFSV4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:56:48 -0400
Date: Mon, 19 Jun 2006 14:58:22 -0700
From: mark gross <mgross@linux.intel.com>
To: Thomas Gleixner <tglx@timesys.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ
Message-ID: <20060619215822.GA4178@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <1150643426.27073.17.camel@localhost.localdomain> <449580CA.2060704@gmail.com> <1150660202.27073.23.camel@localhost.localdomain> <200606192209.38403.kernel@kolivas.org> <1150720304.27073.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150720304.27073.70.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 02:31:44PM +0200, Thomas Gleixner wrote:
> On Mon, 2006-06-19 at 22:09 +1000, Con Kolivas wrote:
> > Also suffers from:
> > WARNING: "timespec_to_jiffies" [fs/fuse/fuse.ko] undefined!
> > 
> > Here is a fix
> 
> Doh, where is the brown paperbag shop ?
> 
> Thanks, applied.
> 
> New queue:
> 
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patch
> 
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patches.tar.bz2
> 

I'm just giving this a test spin now on my desktop boot.  looking at uptime and cat /proc/interrupts 
~/work> uptime;cat /proc/interrupts 
  2:51pm  up   0:28,  5 users,  load average: 0.00, 0.02, 0.08
	CPU0       
	0:      80007          XT-PIC  timer
	1:       1776          XT-PIC  i8042
	2:          0          XT-PIC  cascade
	8:          2          XT-PIC  rtc
	9:          0          XT-PIC  acpi
	11:       2156          XT-PIC  eth0
	12:       2879          XT-PIC  i8042
	14:      20402          XT-PIC  ide0
	15:         11          XT-PIC  ide1
	NMI:          0 
	LOC:          0 
	ERR:          0
	MIS:          0

or about 47.6 timer's a second.

This system is mostly idle, is this about right or should I expect even fewer timer ticks?

Is there a way to see timer stats?

FWIW Its nice to see this stuff start getting real.

thanks

--mgross
