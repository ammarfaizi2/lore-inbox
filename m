Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTFYPLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTFYPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:11:18 -0400
Received: from [198.149.18.6] ([198.149.18.6]:55015 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264531AbTFYPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:11:17 -0400
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
From: Steve Lord <lord@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, grendel@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625161627.A20049@infradead.org>
References: <20030625095126.GD1745@thanes.org>
	<1056545505.1170.19.camel@laptop.americas.sgi.com>
	<20030625134129.GG1745@thanes.org>
	<1056551143.5779.0.camel@laptop.fenrus.com>
	<20030625153545.A16074@infradead.org>
	<1056553902.1416.61.camel@laptop.americas.sgi.com> 
	<20030625161627.A20049@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jun 2003 10:25:26 -0500
Message-Id: <1056554727.1174.86.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 10:16, Christoph Hellwig wrote:
> On Wed, Jun 25, 2003 at 10:11:40AM -0500, Steve Lord wrote:
> > This is all backwards compatibility with folks expecting Irix behavior,
> > and I think on Irix it is even a backwards compatibility thing. If we
> > were not having a major power outage at work right now I could look
> > at Irix and confirm this. Imposing different semantics on the rest of
> > the filesystems did not seem like the right thing to do.
> 
> Actually there's a posix option group for finding out exactly that,
> (see http://people.redhat.com/drepper/posix-option-groups.html#CHOWN_RESTRICTED)
> but yeah it might be more of a legacy thing.
> 
> Adding a common sysctl for this would allow glibc to properly implement
> patchconf(..., _PC_CHOWN_RESTRICTED), but it seems SuSv2/3 sais it must
> be always defined:
> 
> http://www.opengroup.org/onlinepubs/007908799/xsh/chown.html

Thanks, I also found out that the unrestricted  chown behavior is the
way AT&T system V did it originally. I vote for this being a legacy
thing.

Steve



