Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVBBBGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVBBBGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVBBBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:06:51 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:983 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261960AbVBBBGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:06:49 -0500
Subject: Re: [PATCH] Dynamic tick, version 050127-1
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tony Lindgren <tony@atomide.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1107289206.18349.16.camel@krustophenia.net>
References: <20050127212902.GF15274@atomide.com>
	 <1107289206.18349.16.camel@krustophenia.net>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 20:06:51 -0500
Message-Id: <1107306411.8029.9.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 15:20 -0500, Lee Revell wrote:

> I was wondering how Windows handles high res timers, if at all.  The
> reason I ask is because I have been reverse engineering a Windows ASIO
> driver, and I find that if the latency is set below about 5ms, by

By default, Windows "multimedia" timers have 10ms resolution (this
depends on the exact version of Windows used...).  You can call the
timeBeginPeriod() function to lower the resolution to 1ms.

This resolution seem related to the task scheduler timeslice.  After you
call this function, the Sleep() call has also a resolution of 1ms
instead of 10ms.

I remember reading that the multimedia timers are implemented as a high
priority thread.

You can found more details on this site :

http://www.geisswerks.com/ryan/FAQS/timing.html

Best regards,

Eric St-Laurent


