Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVILMxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVILMxs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVILMxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:53:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60841 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750793AbVILMxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:53:48 -0400
Date: Mon, 12 Sep 2005 18:23:28 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050912125327.GB3804@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <210180000.1126505790@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210180000.1126505790@[10.10.2.4]>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 11:16:30PM -0700, Martin J. Bligh wrote:
> 
> 
> --Theodore Ts'o <tytso@mit.edu> wrote (on Sunday, September 11, 2005 23:16:36 -0400):
> 
> > On Sun, Sep 11, 2005 at 05:30:46PM +0530, Dipankar Sarma wrote:
> >> Do you have the /proc/sys/fs/dentry-state output when such lowmem
> >> shortage happens ?
> > 
> > Not yet, but the situation occurs on my laptop about 2 or 3 times
> > (when I'm not travelling and so it doesn't get rebooted).  So
> > reproducing it isn't utterly trivial, but it's does happen often
> > enough that it should be possible to get the necessary data.
> >
> >> This is a problem that Bharata has been investigating at the moment.
> >> But he hasn't seen anything that can't be cured by a small memory
> >> pressure - IOW, dentries do get freed under memory pressure. So
> >> your case might be very useful. Bharata is maintaing an instrumentation
> >> patch to collect more information and an alternative dentry aging patch 
> >> (using rbtree). Perhaps you could try with those.
> > 
> > Send it to me, and I'd be happy to try either the instrumentation
> > patch or the dentry aging patch.
> 
> Other thing that might be helpful is to shove a printk in prune_dcache
> so we can see when it's getting called, and how successful it is, if the
> more sophisticated stuff doesn't help ;-)
> 

I have incorporated this in the dcache stats patch I have. I will 
post it tommorrow after adding some more instrumentation data
(number of inuse and free dentries in lru list) and after a bit of
cleanup and testing.

Regards,
Bharata.
