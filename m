Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265803AbUFOSEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbUFOSEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUFOSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:04:55 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:47013 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265803AbUFOSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:04:54 -0400
Date: Tue, 15 Jun 2004 13:05:25 -0500
From: Dean Nelson <dcn@sgi.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, dcn@sgi.com
Subject: Re: calling kthread_create() from interrupt thread
Message-ID: <20040615180525.GA17145@sgi.com>
References: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com> <1087321777.2710.43.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087321777.2710.43.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:49:37PM +0200, Arjan van de Ven wrote:
> On Tue, 2004-06-15 at 19:42, Dean Nelson wrote:
> > I'm working on a driver that needs to create threads that can sleep/block
> > for an indefinite period of time.
> > 
> >     . Can kthread_create() be called from an interrupt handler?
> 
> no
> 
> > 
> >     . Is the cost of a kthread's creation/demise low enough so that one
> >       can, as often as needed, create a kthread that performs a simple
> >       function and exits?  Or is the cost too high for this?
> 
> for that we have keventd in 2.4, work queues in 2.6

As mentioned above, it is possible for this "simple" function to sleep/block
for an indefinite period of time. I was under the impression that one
couldn't block a work queue thread for an indefinite period of time. Am
I mistaken?

Thanks,
Dean



