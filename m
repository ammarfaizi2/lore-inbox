Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVLCXi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVLCXi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLCXi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:38:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932173AbVLCXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:38:27 -0500
Date: Sat, 3 Dec 2005 15:35:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203233511.GL7991@shell0.pdx.osdl.net>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <20051203225105.GO31395@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203225105.GO31395@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> I don't get the point where the advantage is when every distribution 
> creates it's own stable branches.

They often start from a different base.

> AFAIR one of the reasons for the current 2.6 development model was to 
> reduce the amount of feature patches distributions ship by offering an 
> ftp.kernel.org kernel that gets new features early.
> 
> What's wrong with offering an unified branch with few regressions for 
> both users and distributions? It's not that every distribution will use 
> it, but as soon as one or two distributions are using it the amount of 
> extra work for maintaining the branch should become pretty low.

Backporting is real work, and can introduce instabilities of its own.
If the goal is to stop breaking userspace ABI, there's no guarantee this
will be done via backporting w/out careful inspection, esp. for sysfs and
proc entries.  More to the point, breaking userspace (I'm not talking about
deprecated features) should stop upstream, not only in some frozen branch.
If the goal is to make sure old kernels have security fixes, which old
kernel branch do you follow, the numbers will only grow.  Distros are in a
position to look at current -stable updates and see if security fixes are
relevant.  About the only thing I think is helpful in this case is perhaps
one extra -stable cycle on the last branch when newest branch is released
(basically flush the queue).  That much I'm willing to do in -stable.

thanks,
-chris
