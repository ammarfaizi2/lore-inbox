Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbTGFBOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 21:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbTGFBOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 21:14:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37515 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266585AbTGFBOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 21:14:51 -0400
Date: Sun, 6 Jul 2003 02:28:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030706012857.GA29544@mail.jlokier.co.uk>
References: <20030703023714.55d13934.akpm@osdl.org> <200307052309.12680.phillips@arcor.de> <20030705214413.GA28824@mail.jlokier.co.uk> <200307060010.26002.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307060010.26002.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> What are you going to do if you have one 
> application you want to take priority, re-nice the other 50?

Is that effective?  It might be just the trick.

> > Something I've often thought would fix this is to allow normal users
> > to set negative priority which is limited to using X% of the CPU -
> > i.e. those tasks would have their priority raised if they spent more
> > than a small proportion of their time using the CPU.
> 
> That's essentially SCHED_RR.  As I mentioned above, it's not clear
> to me why SCHED_RR requires superuser privilege, since the amount of
> CPU you can burn that way is bounded.  Well, the total of all
> SCHED_RR processes would need to be bounded as well, which is
> straightforward.

Your last point is most important.  At the moment, a SCHED_RR process
with a bug will basically lock up the machine, which is totally
inappropriate for a user app.

-- Jamie
