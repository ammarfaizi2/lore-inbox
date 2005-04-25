Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVDYVWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVDYVWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVDYVVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:21:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:54960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261215AbVDYVUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:20:24 -0400
Date: Mon, 25 Apr 2005 14:19:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-Id: <20050425141953.51a71862.akpm@osdl.org>
In-Reply-To: <20050425203952.GE25002@ca-server1.us.oracle.com>
References: <20050425151136.GA6826@redhat.com>
	<20050425203952.GE25002@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Coekaerts <wim.coekaerts@oracle.com> wrote:
>
> > This is a distributed lock manager (dlm) that we'd like to see added to
> > the kernel.  The dlm programming api is very similar to that found on
> > other operating systems, but this is modeled most closely after that in
> > VMS.
> 
> do you have any performance data at all on this ? I like to see a dlm
> but I like to see something that will also perform well. My main concern
> is that I have not seen anything relying on this code do "reasonably
> well". eg can you show gfs numbers w/ number of nodes and scalability ?
> 
> I think it's time we submit ocfs2 w/ it's cluster stack so that folks
> can compare (including actual data/numbers), we have been waiting to
> stabilize everything but I guess there is this preemptive strike going
> on so we might just as well. at least we have had hch and folks comment,
> before sending to submit code.

Preemptive strikes won't work, coz this little target will just redirect
the incoming munitions at his other aggressors ;)

It is good that RH has got this process underway.  David, I assume that
other interested parties (ocfs, lustre, etc) know that this is happening? 
If not, could you please let them know and invite them to comment?

> Andrew - we will submit ocfs2 so you can have a look, compare and move
> on.  we will work with any stack that eventuslly gets accepted, just want 
> to see the choice out there and an educated decision.

In an ideal world, the various clustering groups would haggle this thing
into shape, come to a consensus patch series which they all can use and I
would never need to look at the code from a decision-making POV.

The world isn't ideal, but merging something over the strenuous objections
of one or more major groups would be quite regrettable - let's hope that
doesn't happen.  Although it might.

> hopefully tomorrow, including data comparing single node and multinode
> performance.

OK.  I'm unlikely to merge any first-round patches, as I expect there will
be plenty of review comments and I'm already in a bit of a mess here wrt
patch backlog, email backlog, bug backlog and apparently there have been
some changes in the SCM area...
