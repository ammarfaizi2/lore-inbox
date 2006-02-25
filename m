Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWBYCXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWBYCXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBYCXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:23:41 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:53136 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932504AbWBYCXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:23:40 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix next_timer_interrupt() for hrtimer
Date: Sat, 25 Feb 2006 13:22:46 +1100
User-Agent: KMail/1.9.1
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Russell King <linux@arm.linux.org.uk>
References: <20060224002653.GC4578@atomide.com> <20060224011044.GE4578@atomide.com> <20060225004333.GA5116@atomide.com>
In-Reply-To: <20060225004333.GA5116@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251322.47480.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 11:43, Tony Lindgren wrote:
> Here's one more version. This one fixes a bug in ktime_to_jiffies()
> by removing - 1 from jiffies and cuts down some conversions too.

Tony, thanks for picking this up. I like how you keep the semantics of 
next_timer_interrupt intact. As you've mentioned in your comments we should 
move the users of that function to nanosecond timers, and it would be nice to 
use a different function name so there's no confusion (suggest 
next_hrtimer_interrupt).

Cheers,
Con
