Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271884AbTGRVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271880AbTGRVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:01:42 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:27272 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S270373AbTGRU7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:59:31 -0400
Date: Sat, 19 Jul 2003 09:05:53 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software suspend testing in 2.6.0-test1
In-reply-to: <20030718094542.07b2685a.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058562011.2015.17.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
 <20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com>
 <20030718032433.4b6b9281.akpm@osdl.org> <20030718152205.GA407@elf.ucw.cz>
 <m2el0nvnhm.fsf@telia.com> <20030718094542.07b2685a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-19 at 04:45, Andrew Morton wrote:
> Oh, we shouldn't be doing this sort of thing when the kernel threads are
> refrigerated.  We do need kswapd services for the trick you tried.
> 
> And all flavours of ext3_writepage() can block on kjournald activity, so if
> kjournald is refrigerated during the memory shrink the machine can deadlock.
> 
> It would be much better to freeze kernel threads _after_ doing the big
> memory shrink.

Yes, that's what the 2.4 version does. And it freezes the kernel threads
in a particular order to avoid deadlocking.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

