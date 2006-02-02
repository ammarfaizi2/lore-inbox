Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWBBVtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWBBVtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWBBVtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:49:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:46747 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932304AbWBBVtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:49:05 -0500
Date: Thu, 2 Feb 2006 16:49:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Roland Dreier <rdreier@cisco.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Question about memory barriers
In-Reply-To: <adamzh9xx03.fsf@cisco.com>
Message-ID: <Pine.LNX.4.44L0.0602021647140.4715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Roland Dreier wrote:

> Most of this is correct, except that mb() is stronger than just rmb()
> and wmb() put together.  All memory operations before the mb() will
> complete before any operations after the mb().  A better way to
> understand this is to look at the sparc64 definition:
> 
> #define mb()    \
>         membar_safe("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad")

Thanks for the explanation.  Is there any appropriate place, say in 
Documentation/, where these things could be spelled out more completely?

Alan Stern

