Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbVIZP5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbVIZP5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbVIZP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:57:03 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:1287 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751650AbVIZP5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:57:01 -0400
Date: Mon, 26 Sep 2005 11:56:44 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Resource limits
Message-ID: <20050926155644.GC2100@hmsreliant.homelinux.net>
References: <200509251712.42302.a1426z@gawab.com> <Pine.LNX.4.63.0509252335560.28108@cuia.boston.redhat.com> <200509261718.17658.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261718.17658.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 05:18:17PM +0300, Al Boldi wrote:
> Rik van Riel wrote:
> > On Sun, 25 Sep 2005, Al Boldi wrote:
> > > Resource limits in Linux, when available, are currently very limited.
> > >
> > > i.e.:
> > > Too many process forks and your system may crash.
> > > This can be capped with threads-max, but may lead you into a lock-out.
> > >
> > > What is needed is a soft, hard, and a special emergency limit that would
> > > allow you to use the resource for a limited time to circumvent a
> > > lock-out.
> > >
> > > Would this be difficult to implement?
> >
> > How would you reclaim the resource after that limited time is
> > over ?  Kill processes?
> 
> That's one way,  but really, the issue needs some deep thought.
> Leaving Linux exposed to a lock-out is rather frightening.
> 
What exactly is it that you're worried about here?  Do you have a particular
concern that a process won't be able to fork or create a thread?  Resources that
can be allocated to user space processes always run the risk that their
allocation will not succede.  Its up to the application to deal with that.

> Neil Horman wrote:
> > Whats insufficient about the per-user limits that can be imposed by the
> > ulimit syscall?
> 
> Are they system wide or per-user?
> 
ulimits are per-user.
Neil

> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
