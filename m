Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVCKW3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVCKW3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVCKW1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:27:43 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4044 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261329AbVCKWX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:23:59 -0500
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: george@mvista.com
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <4230087E.3080307@mvista.com>
References: <1109869828.2908.18.camel@mindpipe>
	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>
	 <42283857.9050007@mvista.com> <1109968985.6710.16.camel@mindpipe>
	 <4228CBFB.3000602@mvista.com> <1110313644.4600.13.camel@mindpipe>
	 <422E33F0.6020403@mvista.com>  <4230087E.3080307@mvista.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:23:49 -0500
Message-Id: <1110579830.19661.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 00:42 -0800, George Anzinger wrote:
> This patch changes the update of the cmos clock to be timer driven
> rather than poll driven by the timer interrupt function.  If the clock
> is not being synced to an outside source the timer is removed and thus
> system overhead is nill in that case.  The update frequency is still ~11
> minutes and missing the update window still causes a retry in 60
> seconds.

No replies yet.  Are there any objections to this patch?

If not, it should be applied as it reduces the worst case latency of the
-RT kernel from about 90 to 40 usecs on my hardware.

The effect on mainline should be negligible.

Lee

