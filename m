Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVHIVZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVHIVZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVHIVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:25:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28622 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964981AbVHIVZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:25:47 -0400
Date: Tue, 9 Aug 2005 16:25:39 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Christoph Hellwig <hch@lst.de>
cc: davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>,
       Aaron Young <ayoung@sgi.com>
Subject: Re: Standardize shutdown of the system from enviroment control
 modules
In-Reply-To: <20050809211003.GA29361@lst.de>
Message-ID: <Pine.SGI.4.58.0508091619180.19699@gallifrey.americas.sgi.com>
References: <20050809211003.GA29361@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Aug 2005, Christoph Hellwig wrote:

> Currently snsc_event for Altix systems sends SIGPWR to init (and abuses
> tasklist_lock..) while the sbus drivers call execve for /sbin/shutdown
> (which is also ugly, it should at least use call_usermodehelper)
> With normal sysvinit both will end up the same, but I suspect the
> shutdown variant, maybe with a sysctl to chose the exact path to call
> would be cleaner.  What do you guys think about adding a common function
> to do this.

Sounds reasonable to me.  I'll copy Aaron Young, who I think
actually wrote the code to send the SIGPWR, in case he had a Good
Reason for doing it this way.  (Aaron, if I'm remembering wrong
and you're not the guy who wrote this, let me know...)

> Could you test such a patch for me?

Sure.  I'll need to get hold of some hardware/firmware that will
reproduce a critical environmental situation...  Might take a
litte while...

Thanks

--
Greg Howard, MTS - Core Platform SW     MS 10-1-061
SGI - Silicon Graphics Inc.             2750 Blue Water Road
ghoward@sgi.com                         Eagan, MN  55121

+--------------------------------------------------------------------+
  "This assignment has two parts: a hard part, and an easy part.  Do
   the easy part first; you might learn something that will help you
   on the hard part.  Or, maybe you'll go outside for a walk before
   you start the hard part, and get hit by a truck!"
                                        - Dr. Jeffrey W. Smith
+--------------------------------------------------------------------+
