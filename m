Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVHHPGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVHHPGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVHHPGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:06:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51598 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750929AbVHHPGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:06:43 -0400
Date: Mon, 8 Aug 2005 20:36:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Message-ID: <20050808150656.GA16993@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com> <20050808073822.GF28070@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808073822.GF28070@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:38:23AM -0700, Tony Lindgren wrote:
> It should not matter when the PIT gets reprogrammed, as the system time is
> not updated from PIT timer. Jiffies are calculated from a second timer, such
> as ACPI PM timer or TSC.

I am more worried about timer latencies and its effects. Because of this skew 
between when jiffy interrupt was originally supposed to happen and when it 
will now happen, it can lead to, for example, scheduling latencies upto
1 jiffy (for HZ=100, that could hurt some apps?) Not to mention that
this will not play well with high-res-timers, but that is probably
not a concern now!


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
