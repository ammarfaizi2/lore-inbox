Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVESRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVESRDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVESRDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:03:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26868 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261160AbVESRDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:03:15 -0400
Message-ID: <428CC6B5.3070206@mvista.com>
Date: Thu, 19 May 2005 10:02:45 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: joe.korty@ccur.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
References: <20050518201517.GA16193@tsunami.ccur.com> <m1hdh0yu14.fsf@muc.de>
In-Reply-To: <m1hdh0yu14.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
~>
> 
> If you do a new structure for this I would suggest adding a
> "precision" field (or the same with a different name). Basically
> precision would tell the kernel that the wakeup can be in a time
> range, not necessarily on the exact time specified. This helps
> optimizing the idle loop because you can batch timers better and is
> important for power management and virtualized environments. The
> kernel internally does not use support this yet, but there are plans
> to change the internal timers in this direction and if you're defining
> a new user interface I would add support for this.
> 
> I am not sure precision would be the right name, other suggestions
> are welcome.
>

I think the accepted and standard way to do this is to use different "clock"s. 
For example, in the HRT patch the clocks CLOCK_REALTIME_HR and 
CLOCK_MONOTONIC_HR are defined as high resolution clocks.
> 
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
