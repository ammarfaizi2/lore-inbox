Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVLMXhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVLMXhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVLMXhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:37:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030311AbVLMXhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:37:03 -0500
Date: Tue, 13 Dec 2005 15:36:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kaos@sgi.com, sekharan@us.ibm.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain
Message-Id: <20051213153639.2235c445.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512131005150.4831-100000@iolanthe.rowland.org>
References: <7639.1134450150@kao2.melbourne.sgi.com>
	<Pine.LNX.4.44L0.0512131005150.4831-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 13 Dec 2005, Keith Owens wrote:
> 
> > On Thu, 8 Dec 2005 14:53:56 -0500 (EST), 
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > >The code below defines three new data structures: atomic_notifier_head,
> > >blocking_notifier_head, and raw_notifier_head.  The first two correspond
> > >to what we had in the earlier patch, and raw_notifier_head is almost the
> > >same as the current implementation, with no locking or protection at all.  
> > 
> > Acked-By: Keith Owens <kaos@sgi.com>
> > 
> > I do not care how this problem is fixed, I am happy with any solution that
> > 
> > (a) stops notify chains being racy and
> > (b) allows users of notify_die() to be safely unloaded.
> 
> Andrew, I've been waiting to hear back about this.

Was subconciously hoping it'd go away, I guess.

> Was that latest
> proposal (three separate types of notifier chains, each with its own API,
> one of them being completely raw) acceptable?

Yes, it looks sane enough.
