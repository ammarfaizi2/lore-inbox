Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTIBScB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTIBScA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:32:00 -0400
Received: from [63.205.85.133] ([63.205.85.133]:57329 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261196AbTIBSb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:31:59 -0400
Date: Tue, 2 Sep 2003 11:39:14 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] might_sleep() improvements
Message-ID: <20030902183914.GA67783@gaz.sfgoth.com>
References: <20030902075145.GA12817@sfgoth.com> <1062510937.28552.7.camel@boobies.awol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062510937.28552.7.camel@boobies.awol.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> >  o Add a "might_sleep_if()" macro for when we might sleep only if some
> >    condition is met.
> 
> But I am neutral about this.

That's understandable - I have some of the same reservations myself.  In
the end I think it's a slight win though.

> Maybe
> renaming this "might_sleep_on()" at least brings it more in line with
> BUG_ON(), and avoids looking like the gross constructs I fear.

I named it that at first but I was afraid that someone might get confused
and thing the semantics were "might_sleep_on(&waitqueue)" since 'sleeping
on' means something already.  To me might_sleep_if(cond) looked a lot
clearer at first glance.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Robert Love wrote:
> >  o Add a "might_sleep_if()" macro for when we might sleep only if some
> >    condition is met.
> 
> But I am neutral about this.

That's understandable - I have some of the same reservations myself.  In
the end I think it's a slight win though.

> Maybe
> renaming this "might_sleep_on()" at least brings it more in line with
> BUG_ON(), and avoids looking like the gross constructs I fear.

I named it that at first but I was afraid that someone might get confused
and thing the semantics were "might_sleep_on(&waitqueue)" since 'sleeping
on' means something already.  To me might_sleep_if(cond) looked a lot
clearer at first glance.

-Mitch
