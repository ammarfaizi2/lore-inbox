Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWBXPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWBXPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWBXPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:04:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:21986 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932236AbWBXPEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:04:23 -0500
Date: Fri, 24 Feb 2006 10:04:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060224144028.GB7101@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0602241003450.5071-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> On Thu, Feb 23, 2006 at 10:18:18PM -0500, Alan Stern wrote:
> > Ben, earlier you expressed concern about the extra overhead due to 
> > cache-line contention (on SMP) in the down_read() call added to 
> > blocking_notifier_call_chain.  I don't remember which notifier chain in 
> > particular you were worried about; something to do with networking.
> > 
> > Does this still bother you?  I can see a couple of ways around it.
> 
> Yes it's a problem.  Any read lock is going to act as a memory barrier, 
> and we need fewer of those in hot paths, not more to slow things down.  

What do you think of the two suggestions in my previous message?

Alan Stern

