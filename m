Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWIVQLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWIVQLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWIVQLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:11:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751097AbWIVQLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:11:52 -0400
Date: Fri, 22 Sep 2006 09:11:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 & DLM merge request
Message-Id: <20060922091134.8602588b.akpm@osdl.org>
In-Reply-To: <1158940944.11901.417.camel@quoit.chygwyn.com>
References: <1158935874.11901.408.camel@quoit.chygwyn.com>
	<20060922143627.GA24953@infradead.org>
	<1158940944.11901.417.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:02:24 +0100
Steven Whitehouse <swhiteho@redhat.com> wrote:

> > >  include/linux/fs.h                 |    3 
> > >  include/linux/iflags.h             |  102 
> > >  include/linux/kernel.h             |    1 
> > >  mm/filemap.c                       |    3 
> > >  mm/readahead.c                     |    1 
> > 
> > And while we're at it, please don't push core change as part of a subsystem
> > tree ever.  They should go into clearly marked and separately patches via
> > -mm.
> 
> Ok, I'm quite happy to do that. They are pretty minor changes, but the
> usual argument is that such changes are not acceptable until there is
> something in the kernel that makes use of them, and they have to happen
> one way around or the other,

There's no 100% comfortable solution to this.  Steven presumably needs
those changes present in his tree so he can test.

What I usually suggest is that the developer get the core changes reviewed
on-list at an early stage and then explicitly flag their presence in the
covering description when sending the please-pull email.
