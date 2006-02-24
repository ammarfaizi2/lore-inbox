Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWBXUVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWBXUVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBXUVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:21:43 -0500
Received: from mx1.rowland.org ([192.131.102.7]:30224 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932455AbWBXUVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:21:42 -0500
Date: Fri, 24 Feb 2006 15:21:41 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060224183704.GA9384@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0602241517440.27891-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> > > A read lock is a memory barrier.  That's why I'm opposed to using non-rcu 
> > > style locking for them.
> > 
> > But RCU-style locking can't be used in situations where the reader may 
> > block.  So it's not possible to use it with blocking notifier chains.
> 
> Then we shouldn't have non-atomic notifier chains in performance critical 
> codepaths.  The original implementation's hooks into critical paths held 
> these characteristics.  If that property has been broken, please fix it 
> instead of adding more locking.

Sorry, no can do.  You'll have to complain to the people who put blocking
code into critical paths in the first place.  I don't know which paths are
critical nor do I know how to change the code to make it non-blocking.

Or you could write some patches yourself instead of asking other people to 
do it for you.

Alan Stern

