Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVL3ELe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVL3ELe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 23:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbVL3ELe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 23:11:34 -0500
Received: from rtr.ca ([64.26.128.89]:15054 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751026AbVL3ELe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 23:11:34 -0500
Message-ID: <43B4B37A.6010608@rtr.ca>
Date: Thu, 29 Dec 2005 23:11:38 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <43B4ADD0.4040906@rtr.ca> <43B4B034.20807@rtr.ca> <20051230040235.GE20371@redhat.com>
In-Reply-To: <20051230040235.GE20371@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Dec 29, 2005 at 10:57:40PM -0500, Mark Lord wrote:
>  > Mark Lord wrote:
>  > >
>  > >Okay, I'm complaining:  /proc/cpuinfo is no longer correct
>  > >for my Pentium-M notebook, as ov 2.6.15-rc7.  Now it reports
>  > >a cpu speed of approx 800Mhz for a 2.0Mhz Pentium-M.
>  > 
>  > 2.0GHz, not Mhz!  (blush)
>  > 
>  > Prior to -rc7, /proc/cpuinfo would scale according to the
>  > current speedstep of the CPU.  Now it seems stuck at the
>  > lowest setting for some reason.
> 
> Ok, if the scaling doesn't work any more, that's a bug rather
> than an intentional breakage.  More details please? dmesg ?
> /sys/devices/system/cpu/cpufreq contents? What were you using
> to do the scaling previously?  (An app, or ondemand)

The actual speedstep component ("ondemand" cpufreq) is working just
fine, according to /sys/devices/system/cpu/cpufreq.  But /proc/cpuinfo
is no longer reflecting the current values -- stuck at 800Mhz
regardless of /sys/devices/system/cpu/cpufreq showing other values.

Cheers
