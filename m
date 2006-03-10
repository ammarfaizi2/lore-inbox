Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752086AbWCJGlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWCJGlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWCJGlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:41:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:36240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752086AbWCJGlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:41:12 -0500
Date: Thu, 9 Mar 2006 22:34:01 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310063401.GA30968@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com> <20060310010050.GA9945@suse.de> <1141966693.14517.20.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141966693.14517.20.camel@camp4.serpentine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:58:13PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 17:00 -0800, Greg KH wrote:
> 
> > They are in the latest -mm tree if you wish to use them.  Unfortunatly
> > it might look like they will not work out, due to the per-cpu relay
> > files not working properly with Paul's patches at the moment.
> 
> Hmm, OK.
> 
> > What's wrong with debugfs?
> 
> It's not configured into the kernels of either of the distros I use (Red
> Hat or SUSE).

Well, I can do something about SuSE, it's up to someone else to persuade
Red Hat :)

> I can't have a required part of my driver depend on a feature that's
> not enabled in the major distro kernels.

Fair enough.

> I'd like a mechanism that is (a) always there (b) easy for kernel to use
> and (c) easy for userspace to use.  A sysfs file satisfies a, b, and c,
> but I can't use it; a sysfs bin file satisfies all three (a bit worse on
> b), but I can't use it; debugfs isn't there, so I can't use it.
> 
> That leaves me with few options, I think.  What do you suggest?  (Please
> don't say netlink.)

Write your own filesystem?  Seriously, you do that and you get to set
all of your own rules (well, within reason).  It's only 200 lines of
code, max.

thanks,

greg k-h
