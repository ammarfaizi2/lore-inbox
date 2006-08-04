Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWHDGqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWHDGqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWHDGqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:46:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932294AbWHDGqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:46:09 -0400
Date: Thu, 3 Aug 2006 23:45:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803234537.e9b6736d.akpm@osdl.org>
In-Reply-To: <20060804062036.GA28137@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
	<20060803223650.423f2e6a.akpm@osdl.org>
	<20060804062036.GA28137@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 11:50:36 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > And now we've dumped the good infrastructure and instead we've contentrated
> > on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> > layer.
> 
> FWIW, this controller was originally written for f-series.

What the heck is an f-series?

<googles, looks at
http://images.automotive.com/cob/factory_automotive/images/Features/auto_shows/2005_IEAS/2005_Ford_F-series_Harley-Davidson_front.JPG,
gets worried about IBM design methodologies>

> It should
> be trivial to put it back there. So really, f-series isn't gone 
> anywhere. If you want to merge it, I am sure it can be re-submitted.

Well.  It shouldn't be a matter of what I want to merge - you're the
resource-controller guys.  But...

> > I wonder how many of the consensus-makers were familiar with the
> > contemporary CKRM core?
> 
> I think what would be nice is a clear strategy on whether we need
> to work out the infrastructure or the controllers first.

We should put our thinking hats on and decide what sort of infrastructure
will need to be in place by the time we have a useful number of useful
controllers implemented.

> One of
> the strongest points raised in the BoF was - forget the infrastructure
> for now, get some mergable controllers developed.

I wonder what inspired that approach.  Perhaps it was a reaction to CKRM's
long and difficult history?  Perhaps it was felt that doing standalne
controllers with ad-hoc interfaces would make things easier to merge?

Perhaps.  But I think you guys know that the end result would be inferior,
and that getting good infrastructure in place first will produce a better
end result, but you decided to go this way because you want to get
_something_ going?

> If you
> want to stick to f-series infrastructure and want to see some
> consensus controllers evolve on top of it, that can be done too.

Do you think that the CKRM core as last posted had any unnecessary
features?  I don't have the operational experience to be able to judge
that, so I'd prefer to trust your experience and judgement on that.  But
the features which _were_ there looked quite OK from an implementation POV.

So my take was "looks good, done deal - let's go get some sane controllers
working".  And now this!
