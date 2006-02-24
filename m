Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWBXEEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWBXEEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWBXEEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:04:07 -0500
Received: from mx1.rowland.org ([192.131.102.7]:7949 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751824AbWBXEED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:04:03 -0500
Date: Thu, 23 Feb 2006 23:04:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andi Kleen <ak@suse.de>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] The idle notifier chain should be atomic
In-Reply-To: <200602240427.27441.ak@suse.de>
Message-ID: <Pine.LNX.4.44L0.0602232300250.21298-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Andi Kleen wrote:

> On Friday 24 February 2006 04:24, Alan Stern wrote:
>  
> > In do_IRQ() there's a call to exit_idle(), which calls __exit_idle(), 
> > which runs the idle_notifier call chain.  Surely you're not saying that we 
> > can do a down_read() in this pathway?
> 
> No, but not because it's in an interrupt but because sleeping in the idle
> task is illegal.

Well, either reason is sufficient justification for making idle_notifier 
an atomic chain.

> > And actually the chain's type doesn't seem to make much difference, since
> > at the moment there's nothing in the vanilla kernel that registers for the
> > idle_notifier chain.
> 
> Will come eventually.

Will that be just for x86_64 or for all architectures?

Alan Stern

