Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWBBVwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWBBVwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBBVwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:52:43 -0500
Received: from xenotime.net ([66.160.160.81]:25799 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932317AbWBBVwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:52:43 -0500
Date: Thu, 2 Feb 2006 13:52:41 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Stern <stern@rowland.harvard.edu>
cc: Roland Dreier <rdreier@cisco.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about memory barriers
In-Reply-To: <Pine.LNX.4.44L0.0602021647140.4715-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.58.0602021351560.16597@shark.he.net>
References: <Pine.LNX.4.44L0.0602021647140.4715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Alan Stern wrote:

> On Thu, 2 Feb 2006, Roland Dreier wrote:
>
> > Most of this is correct, except that mb() is stronger than just rmb()
> > and wmb() put together.  All memory operations before the mb() will
> > complete before any operations after the mb().  A better way to
> > understand this is to look at the sparc64 definition:
> >
> > #define mb()    \
> >         membar_safe("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad")
>
> Thanks for the explanation.  Is there any appropriate place, say in
> Documentation/, where these things could be spelled out more completely?

Info could be added to Documentation/DocBook/kernel-locking.tmpl
which already has some barrier info.

-- 
~Randy
