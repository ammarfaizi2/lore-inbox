Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVJQXQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVJQXQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJQXQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:16:07 -0400
Received: from hera.kernel.org ([140.211.167.34]:63162 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751362AbVJQXQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:16:05 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] RNG rewrite...
Date: Mon, 17 Oct 2005 16:15:49 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dj1bb5$riu$1@terminus.zytor.com>
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1129590949 28255 127.0.0.1 (17 Oct 2005 23:15:49 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 17 Oct 2005 23:15:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20051016005341.GB5946@plexity.net>
By author:    Deepak Saxena <dsaxena@plexity.net>
In newsgroup: linux.dev.kernel
> 
> It's a magic regsiter we just read/write and could be done in userspace.
> I also took a look at MPC85xx and it has the same sort of interface but
> also has an error interrupt capability. On second thought a class
> interface is overkill b/c there will only be one RNG per system, so
> I can just do something like watchdogs where we have a bunch of simple
> drivers exposing the same interface. We could do it in user space but
> then we have separate RNG implementations for  x86 and !x86 and I'd
> rather not see that. Can we move the x86 code out to userspace and
> just let the daemon eat the numbers directly from HW? We can mmap() 
> PCI devices, but I don't know enough about x86 to say whether msr 
> instructions can execute out of userspace (or if we want them to...).
> 

MSR instructions cannot execute out of userspace, but the MSR driver
might be possible to use.  It's usually quite slow, however.

	-hpa
