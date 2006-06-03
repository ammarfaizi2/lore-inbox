Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWFCAFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWFCAFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 20:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWFCAFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 20:05:51 -0400
Received: from ns.suse.de ([195.135.220.2]:23710 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751581AbWFCAFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 20:05:50 -0400
Date: Fri, 2 Jun 2006 17:03:17 -0700
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Updated v3]: How to become a kernel driver maintainer
Message-ID: <20060603000317.GA10037@kroah.com>
References: <1136736455.24378.3.camel@grayson> <1136756756.1043.20.camel@grayson> <1136792769.2936.13.camel@laptopd505.fenrus.org> <1136813649.1043.30.camel@grayson> <1136842100.2936.34.camel@laptopd505.fenrus.org> <1141841013.24202.194.camel@grayson> <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com> <1141845047.12175.7.camel@laptopd505.fenrus.org> <9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com> <1149284317.4533.312.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149284317.4533.312.camel@grayson>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 05:38:36PM -0400, Ben Collins wrote:
> The real work of maintainership begins after your code is in the tree.
> This is where some maintainers fail, and is the reason the kernel
> developers are so reluctant to allow new drivers into the main tree.

I don't think this is true.  On-going maintenance of a driver is quite
minor over time, unless you are adding new support, or if there are bugs
in your driver.  We will gladly accept any driver, as long as it follows
the proper coding style rules and plays nice with the rest of the
kernel.

> The other side of the coin is keeping changes in the kernel synced to your
> code. Often times, it is necessary to change a kernel API (driver model,
> USB stack changes, networking subsystem change, etc). These sorts of
> changes usually affect a large number of drivers. It is not feasible for
> these changes to be individually submitted to the driver maintainers. So
> instead, the changes are made together in the kernel tree. If your driver
> is affected, you are expected to pick up these changes and merge them with
> your temporary development copy.  Usually this job is made easier if you
> use the same source control system that the kernel maintainers use
> (currently, git), but this is not required. Using git, however, allows you
> to merge more easily.

Almost always, the person doing the API change fixes all in-kernel
versions of the api change.  So the driver author/maintainer does not
have to fix up anything.
> 
> There are times where changes to your driver may happen that are not the
> API type of changes described above. A user of your driver may submit a
> patch directly to Linus to fix an obvious bug in the code. Sometimes these
> trivial and obvious patches will be accepted without feedback from the
> driver maintainer. Don't take this personally. We're all in this together.
> Just pick up the change and keep in sync with it. If you think the change
> was incorrect, try to find the mailing list thread or log comments
> regarding the change to see what was going on. Then email the patch author
> about the change to start discussion.
> 
> 
> How should I maintain my code after it's in the kernel tree?
> ------------------------------------------------------------
> 
> The suggested, and certainly the easiest method, is to start a git tree
> cloned from the primary kernel tree. In this way, you are able to
> automatically track the kernel changes by pulling from Linus' tree. You
> can read more about maintaining a kernel git tree at
> http://linux.yyz.us/git-howto.html.

I disagree, quilt is _much_ easier for maintaining patches against a
common tree.  Combined with ketchup and it makes things dirt simple.

Everything else looks good, very nice job.

thanks,

greg k-h
