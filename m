Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTLDVpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTLDVpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:45:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:39085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263513AbTLDVpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:45:22 -0500
Date: Thu, 4 Dec 2003 13:45:17 -0800
From: cliff white <cliffw@osdl.org>
To: Larry McVoy <lm@bitmover.com>
Cc: hannal@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Minutes from OSDL talk at LSE call today
Message-Id: <20031204134517.0c7a4ec4.cliffw@osdl.org>
In-Reply-To: <20031204033535.GA2370@work.bitmover.com>
References: <189470000.1070500829@w-hlinder>
	<20031204033535.GA2370@work.bitmover.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003 19:35:35 -0800
Larry McVoy <lm@bitmover.com> wrote:

> On Wed, Dec 03, 2003 at 05:20:29PM -0800, Hanna Linder wrote:
> > The Mozilla Tinderbox is based on CVS and can do fancy things with
> > triggers. The kernel one is not as fancy because they are still
> > working out issues with BK.
> 
> If we could get a list of these issues we'll try and see what we can do
> to help.  My response has been a bit spotty lately, I've needed to take
> some personal time, so pinging support@bitmover.com is more likely to
> get you help.

We've exchanged some email with support@bitmover.com, and they've been a great help.
Really, there are two things.

The first is triggers. The Mozilla tinderbox is driven by triggers from CVS commits.
I believe that triggers are resevered for the commercial version of BK.

However, unlike CVS, BK has a nice way of asking the remote repository if new changes exist,
so we really don't need a trigger to tell us when to start a build. 
Instead, we run the timestamp column on a cron, so it is constantly incrementing.
( Mozilla only increments their timestamp column when a trigger is recieved ) 

The change from trigger-driven to time-driven timestamps meant we didn't try 
to create a link between timestamp->source commit. Again, since Mozilla is
trigger driven, they have this link.

So, the second piece is linking either the time-stamp column or the build machine column
directly to a Web-based view of the code. BkWeb already provides the view. 

The main issue here is finding the proper syntax for the bkweb url so we get 
all of the changesets included in the commit. We've recieved a few examples from
your support people, and we're using one currently. 

cliffw


> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by OSDN's Audience Survey.
> Help shape OSDN's sites and tell us what you think. Take this
> five minute survey and you could win a $250 Gift Certificate.
> http://www.wrgsurveys.com/2003/osdntech03.php?site=8
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
