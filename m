Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCSUVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUCSUU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:20:59 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32908
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261942AbUCSUUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:20:55 -0500
Message-ID: <405B5613.9080301@redhat.com>
Date: Fri, 19 Mar 2004 12:20:35 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fab Tillier <ftillier@infiniconsys.com>
CC: "Woodruff, Robert J" <woody@co.intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A7A@mercury.infiniconsys.com>
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A7A@mercury.infiniconsys.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For the IBAL stack, there are numerous documents on the Linux InfiniBand
> Project (http://infiniband.sourceforge.net/) describing most everything from
> the overall architecture to the APIs.

That's not the same, and it incidentally shows a problem in what you do.

First, the working group I refer to is this:

  http://www.opengroup.org/icsc/

Dave Edmondson from Sun gave a presentation at the Austin group meeting
(in 2002, not 2001 as I said before) which you can see here:

  http://www.opengroup.org/austin/docs/austin_105.pdf


This is the information I cannot get to.  Now why would I want that
instead of what you do?

First of all, these are the extensions to the existing interfaces.
These extensions not only influence existing code, but the extensions
can also be useful for non-interconnect usage.  That is, if we can adopt
them if necessary.  Many of the interconnect problems also are present
in Gig and 10Gig ethernet.  The ICSC refused to give anyone outside
their group access to the document despite the fact that they want to
have the extensions added to POSIX.  If we develop separate extensions
they will collide and/or cause unnecessary duplication of code and effort.


Now, why is ICSC relevant?  In my opinion, and I'm not really that
knowledgeable about all these networking issues but I know a thing or
two about APIs, going down the road with Infiniband specific APIs is
bad.  Why would we want to have separate APIs for other interconnect
fibers?  The ICSC, according to my understanding, tries to unify the
APIs to be usable not only by Infiniband.  This is IMO highly desirable.

You can get a glimpse of what they are doing by looking at the documents
referenced in

  http://www.opengroup.org/icsc/

But that's all there is.  The socket extension working group

  http://www.opengroup.org/icsc/sockets/

only has some meeting minutes available.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
