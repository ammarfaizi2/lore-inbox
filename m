Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTJWU5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTJWU5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:57:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3253 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261746AbTJWU5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:57:52 -0400
Subject: Re: [pm] fix time after suspend-to-*
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F9838B4.5010401@mvista.com>
References: <20031022233306.GA6461@elf.ucw.cz>
	 <1066866741.1114.71.camel@cog.beaverton.ibm.com>
	 <20031023081750.GB854@openzaurus.ucw.cz>  <3F9838B4.5010401@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066942532.1119.98.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Oct 2003 13:55:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 13:23, George Anzinger wrote:

> I lost (never saw) the first of this thread, BUT, if this is 2.6, I strongly 
> recommend that settimeofday() NOT be called.  It will try to adjust 
> wall_to_motonoic, but, as this appears to be a correction for time lost while 
> sleeping, wall_to_monotonic should not change.

While suspended should the notion monotonic time be incrementing? If
we're not incrementing jiffies, then uptime isn't being incremented, so
to me it doesn't follow that the monotonic time should be incrementing
as well. 

It may very well be a POSIX timers spec issue, but it just strikes me as
odd.

thanks
-john


