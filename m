Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVD0D2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVD0D2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 23:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVD0D2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 23:28:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48620 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261900AbVD0D2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 23:28:21 -0400
Date: Wed, 27 Apr 2005 11:32:00 +0800
From: David Teigland <teigland@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050427033200.GC9963@redhat.com>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050426053930.GA12096@redhat.com> <20050426184845.GA938@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426184845.GA938@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:48:45AM -0700, Mark Fasheh wrote:
> On Tue, Apr 26, 2005 at 01:39:30PM +0800, David Teigland wrote:

> > No.  What kind of performance measurements do you have in mind?  Most
> > dlm lock requests involve sending a message to a remote machine and
> > waiting for a reply.  I expect this network round-trip is the bulk of
> > the time for a request, which is why I'm a bit confused by your
> > question.

> Resource lookup times, times to deliver events to clients (asts, basts,
> etc) for starters. How long does recovery take after a node crash? How
> does all of this scale as you increase the number of nodes in your
> cluster?  Sure, network speed is a part of the equation, but it's not
> the *whole* equation and I've seen dlms that can get downright nasty
> when it comes to recovery speeds, etc.

Ok, we'll look into how to measure some of that in a way that's
meaningful.


> > > My main concern is that I have not seen anything relying on this
> > > code do "reasonably well". eg can you show gfs numbers w/ number of
> > > nodes and scalability ?
> > 
> > I'd suggest that if some cluster application is using the dlm and has
> > poor performance or scalability, the reason and solution lies mostly
> > in the app, not in the dlm.  That's assuming we're not doing anything
> > blatantly dumb in the dlm, butI think you may be placing too much
> > emphasis on the role of the dlm here.

> Well, obviously the dlm is only one component of an entire system, but
> for a cluster application it can certainly be an important component,
> one whose performance is worth looking into. I don't think asking for
> this information is out of the question.

GFS measurements will wait until gfs comes along, but we can do some dlm
measuring now.

Dave

