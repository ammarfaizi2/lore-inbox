Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTFIX1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTFIX1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:27:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:42926 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262271AbTFIX1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:27:14 -0400
Subject: Re: [PATCH] Some clean up of the time code.
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Eric Piel <Eric.Piel@Bull.Net>
In-Reply-To: <3EE510E7.60801@mvista.com>
References: <3EE510E7.60801@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055201760.18643.6.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 16:36:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 15:57, george anzinger wrote:
> Pushs down the change from timeval to timespec in the settime routines.

No complaints here. 

> Fixes two places where time was set without updating the monotonic
> clock offset.  (Changes sys_stime() to call do_settimeofday() and
> changes clock_warp to do the update directly.)  These were bugs!

Yea, that sys_stime bug really needed fixing. Thanks for kicking this
out.

> Changes the uptime code to use the posix_clock_monotonic notion of
> uptime instead of the jiffies.  This time will track NTP changes and
> so should be better than your standard wristwatch (if your using ntp).

Hmmm. Might want to see if the btime changes from last week could
benefit from a similar change. 

Didn't test it personally, but looks good. 

thanks
-john

