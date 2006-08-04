Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWHDGYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWHDGYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 02:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWHDGYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 02:24:53 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:43668 "EHLO ausmtp06")
	by vger.kernel.org with ESMTP id S1750753AbWHDGYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 02:24:52 -0400
Date: Fri, 4 Aug 2006 11:50:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804062036.GA28137@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803223650.423f2e6a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:36:50PM -0700, Andrew Morton wrote:
> On Fri, 4 Aug 2006 10:37:53 +0530
> 
> > Resource management has been talked about quite extensively in the
> > past, more recently in the context of containers. The basic requirement
> > here is to provide isolation between *groups* of task wrt their use
> > of various resources like CPU, Memory, I/O bandwidth, open file-descriptors etc.
> > 
> > Different maintainers have however expressed different opinions over the need to
> > complicate the kernel to meet this need, especially since it involves core 
> > kernel code like the resource schedulers. 
> > 
> > A BoF was hence held at OLS this year to come to a consensus on the minimum 
> > requirements of a resource management solution for Linux kernel. Some notes 
> > taken at the BoF are posted here:
> > 
> > 	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0607.3/0896.html
> > 
> > An important consensus point of the BoF seemed to be "focus on real 
> > controllers more, preferably memory first, using some simple interface
> > and task grouping mechanism".
> 
> ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
> this whole strategy.

Ah, wish you were there :)

> I thought the most recently posted CKRM core was a fine piece of code.  It
> provides the machinery for grouping tasks together and the machinery for
> establishing and viewing those groupings via configfs, and other such
> common functionality.  My 20-minute impression was that this code was an
> easy merge and it was just awaiting some useful controllers to come along.
> 
> And now we've dumped the good infrastructure and instead we've contentrated
> on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
> layer.

FWIW, this controller was originally written for f-series. It should
be trivial to put it back there. So really, f-series isn't gone 
anywhere. If you want to merge it, I am sure it can be re-submitted.

> I wonder how many of the consensus-makers were familiar with the
> contemporary CKRM core?

I think what would be nice is a clear strategy on whether we need
to work out the infrastructure or the controllers first. One of
the strongest points raised in the BoF was - forget the infrastructure
for now, get some mergable controllers developed. If you
want to stick to f-series infrastructure and want to see some
consensus controllers evolve on top of it, that can be done too.

Thanks
Dipankar
