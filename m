Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUDCCQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 21:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUDCCQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 21:16:48 -0500
Received: from s-utl01-lapop.stsn.com ([12.129.240.11]:19492 "HELO
	s-utl01-lapop.stsn.com") by vger.kernel.org with SMTP
	id S261273AbUDCCQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 21:16:46 -0500
Subject: Re: [bkbits] predicted outage
From: David T Hollis <dhollis@davehollis.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, dev@work.bitmover.com
In-Reply-To: <200404020218.i322I0GC017257@work.bitmover.com>
References: <200404020218.i322I0GC017257@work.bitmover.com>
Content-Type: text/plain
Message-Id: <1080958586.2688.3.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (1.5.5-1) 
Date: Fri, 02 Apr 2004 21:16:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 18:18 -0800, Larry McVoy wrote:

> We're moving office space in about 10 days.  We expect one of our T1 lines
> to be switched to the new office as of April 9th.  If that works, then we'll
> move all the hardware to the new office and flip the routes to that T1 from
> the old T1.  Sounds simple and since the new ISP is the old ISP it might 
> actually work (Hah.  Like anything goes that smoothly).  On the other hand,
> it might not go great and there might be some time where bkbits.net is not
> off the air but it might be at a different IP address.  And DNS takes a 
> while to time out.

Hopefully not point out the obvious, but since you have the lead time,
you could set the TTLs on the DNS entries pretty low (say 5 minutes or
so) now so by the time the changeover is happening, it's fully
propagated.  This way, if you do wind up with the different IP address
scenario, just make the DNS change and it will propagate within minutes
and most folks will never notice.  Once everything is stable again, you
can run the TTL back up.  

A quick check shows that www.bkbits.net has it's TTL set to 86400 (1
day) which means other servers will cache that for up to a day and with
multiple levels of DNS, that can wind up taking awhile to expire.  Bring
that down and things should go smoothly.

Just a thought....

-- 
David T Hollis <dhollis@davehollis.com>

