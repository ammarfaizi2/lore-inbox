Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVBBQig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVBBQig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVBBQe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:34:56 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35206 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262586AbVBBQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:34:25 -0500
Date: Wed, 2 Feb 2005 09:34:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc2] Move <linux/prio_tree.h> down in <linux/fs.h>
Message-ID: <20050202163421.GC15359@smtp.west.cox.net>
References: <20050201160642.GA15359@smtp.west.cox.net> <1107361283.12383.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107361283.12383.0.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 04:21:23PM +0000, David Woodhouse wrote:
> On Tue, 2005-02-01 at 09:06 -0700, Tom Rini wrote:
> > <linux/prio_tree.h> is unsafe for inclusion by userland apps, but it
> > is in the userland-exposed portion of <linux/fs.h>.  It's only needed
> > in the __KERNEL__ protected portion of the file, so move the #include
> > down to there.
> 
> You accidentally posted this patch to the kernel list, not to the
> maintainers of the libc-kernelheaders package. And you might as well
> just remove the offending #include rather than moving it to a section of
> the file which is never used.

Ignoring your hint for a moment, since __KERNEL__ is still scattered all
over the place, and I haven't see anything (changeset-wise) adding "You
must use libc-kernelheaders now" in Documentation/feature-removal-schedule.txt
this is still an actual problem.  Thanks.

Feel free to correct me by getting something added to
Documentation/feature-removal-schedule.txt :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
