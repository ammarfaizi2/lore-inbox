Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVK1Rk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVK1Rk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVK1Rk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:40:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:5804 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751262AbVK1Rk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:40:26 -0500
Date: Mon, 28 Nov 2005 23:12:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128174203.GB4359@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com> <20051128160547.GA20775@brahms.suse.de> <20051128161747.GA4359@in.ibm.com> <20051128162709.GC20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128162709.GC20775@brahms.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 05:27:09PM +0100, Andi Kleen wrote:
> On Mon, Nov 28, 2005 at 09:47:47PM +0530, Dipankar Sarma wrote:
> > On Mon, Nov 28, 2005 at 05:05:47PM +0100, Andi Kleen wrote:
> > >   *
> > >   *	Returns zero on success, or %-ENOENT on failure.
> > >   */
> > > @@ -175,6 +181,7 @@
> > >  
> > 
> > There should be an smp_read_barrier_depends() here for the first
> > dereferencing of the notifier block head, I think.
> 
> Why? The one at the top of the block should be enough, shouldn' it?
> 

Don't we insert at the front of the list ? Shouldn't the read-side
on alpha see the contents of the new notifier block before it sees
the pointer to the first notifier block in the list head ?

Thanks
Dipankar
