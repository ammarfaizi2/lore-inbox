Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCUT52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCUT52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVCUT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:57:28 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:20924 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S261651AbVCUT5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:57:23 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] NMI handler message passing / work deferral API
Date: Mon, 21 Mar 2005 11:51:31 -0800
User-Agent: KMail/1.5.3
Cc: oprofile-list@lists.sourceforge.net, bluesmoke-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dave_peterson@pobox.com
References: <200503202056.02429.dave_peterson@pobox.com> <200503211103.56930.dsp@llnl.gov> <20050321190741.GA98750@muc.de>
In-Reply-To: <20050321190741.GA98750@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211151.31109.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 11:07 am, Andi Kleen wrote:
> > Yes exactly.  That's one reason why I posted the patch.  Different
> > sybsystems that need this type of functionality shouldn't have to
> > individually reinvent the wheel.  With a single implementation, code
> > is more compact and easier to understand and maintain.  I would argue
>
> More compact? Sorry, but even all existing implementations together
> are still far less code than your really complicated subsystem which
> seems quite overengineered for this simple task for me.
>
> Also lockless programming is tricky and I would feel quite uneasy
> about auditing so much code.
>
> > that code maintenance is of particular concern to code such as NMI
> > and machine check handlers because bugs in this type of code can be
> > hard to track down.
>
> Yeah, that is why we use simple, not complex, code in there.

It's really not that much code.  When you strip out most of the comments
(including the big 65-line copyright blurb required by my employer), the
entire implementation is less than 300 lines of code.  A large part of
the patch is just comments (which in this case I think should be there
because as you say, lockless programming is tricky).

I do think there should be some sort of API that provides the same type
of functionality as my patch.  It's much better than having lots of
replicated code.  However I am not very attached to my particular
implementation.  If you or someone else wants to post a patch that is
simpler yet provides similar functionality, I think that would be great.
Perhaps some code could be borrowed from oprofile or the machine check
handling code or somewhere else.

Dave
