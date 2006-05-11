Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWEKSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWEKSfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWEKSfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:35:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44552 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750849AbWEKSfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:35:22 -0400
Date: Thu, 11 May 2006 14:35:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <jes@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow raw_notifier callouts to unregister themselves
In-Reply-To: <20060511112509.6c9db883.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0605111433380.5834-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, Andrew Morton wrote:

> Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Since raw_notifier chains don't benefit from any centralized locking
> > protections, they shouldn't suffer from the associated limitations.  
> > Under some circumstances it might make sense for a raw_notifier callout
> > routine to unregister itself from the notifier chain.  This patch (as678)
> > changes the notifier core to allow for such things.
> 
> ok...  Can you see any reason why 2.6.17 needs this?

No.  The patch was submitted in preparation for some work that Jes
Sorensen is doing on task notifiers.  It definitely is not needed
immediately.

Alan Stern


