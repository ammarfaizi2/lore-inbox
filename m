Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVLMPGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVLMPGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVLMPGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:06:51 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:27855 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S964991AbVLMPGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:06:50 -0500
Date: Tue, 13 Dec 2005 10:06:48 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Keith Owens <kaos@sgi.com>, <sekharan@us.ibm.com>, <ak@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7]: Fix for unsafe notifier chain 
In-Reply-To: <7639.1134450150@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44L0.0512131005150.4831-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Keith Owens wrote:

> On Thu, 8 Dec 2005 14:53:56 -0500 (EST), 
> Alan Stern <stern@rowland.harvard.edu> wrote:
> >The code below defines three new data structures: atomic_notifier_head,
> >blocking_notifier_head, and raw_notifier_head.  The first two correspond
> >to what we had in the earlier patch, and raw_notifier_head is almost the
> >same as the current implementation, with no locking or protection at all.  
> 
> Acked-By: Keith Owens <kaos@sgi.com>
> 
> I do not care how this problem is fixed, I am happy with any solution that
> 
> (a) stops notify chains being racy and
> (b) allows users of notify_die() to be safely unloaded.

Andrew, I've been waiting to hear back about this.  Was that latest
proposal (three separate types of notifier chains, each with its own API,
one of them being completely raw) acceptable?

Alan Stern

