Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVBAUUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVBAUUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVBAUUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:20:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36769 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262120AbVBAUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:20:09 -0500
Subject: Re: [PATCH] Dynamic tick, version 050127-1
From: Lee Revell <rlrevell@joe-job.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20050127212902.GF15274@atomide.com>
References: <20050127212902.GF15274@atomide.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 15:20:05 -0500
Message-Id: <1107289206.18349.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 13:29 -0800, Tony Lindgren wrote:
> Hi all,
> 
> Thanks for all the comments, here's an updated version of the dynamic
> tick patch.

Hi,

I was wondering how Windows handles high res timers, if at all.  The
reason I ask is because I have been reverse engineering a Windows ASIO
driver, and I find that if the latency is set below about 5ms, by
examining the kernel timer queue with SoftICE I can see that several
kernel timers with 1ms period are created.  (Presumably the sound card's
interval timer is used for longer periods).

But, I have seen people mention in the "singing capacitor" threads on
this list that Windows uses 100 for HZ.

So, how do they implement 1ms timers with a 10ms tick rate?  Does
Windows dynamically reprogram the PIT as well?

Lee

