Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbTIYI1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTIYI1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:27:23 -0400
Received: from dp.samba.org ([66.70.73.150]:8088 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261770AbTIYI1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:27:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Hockin <thockin@hockin.org>
Cc: akpm@zip.com.au, neilb@cse.unsw.edu.au, braam@clusterfs.com,
       davem@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, tridge@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl-controlled number of groups. 
In-reply-to: Your message of "Wed, 24 Sep 2003 21:14:17 MST."
             <20030924211417.A16753@hockin.org> 
Date: Thu, 25 Sep 2003 18:17:30 +1000
Message-Id: <20030925082720.8244A2C2D2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030924211417.A16753@hockin.org> you write:
> On Thu, Sep 25, 2003 at 01:21:01PM +1000, Rusty Russell wrote:
> > We have a client (using SAMBA) who has people in 190 groups.  Since NT
> > has hierarchical groups, this is not all that rare.
> > 
> > What do people think of this patch?
> 
> Excuse me but JESUS FUCKING CHRIST.  I've been sending that patch since last
> year.

Yes, I saw this (google sent me to a much older version when I looked,
but I just found your more recent one).

I like the fact that you have no internal array, but I like the fact
that I preserve the raw groups pointer.  You go furthur and try to do
better than linear search, too, I was aiming for minimalism.

> No sysctl - I didn't think it was needed at all.

Perhaps, but I was being cautious.  With the default setting, it's
identical to the current situation.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
