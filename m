Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVLCS03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVLCS03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVLCS02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:26:28 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:38554 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932123AbVLCS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:26:28 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Vinay Venkataraghavan <raghavanvinay@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <p73hd9p4xmu.fsf@verdi.suse.de>
References: <5fv0G-3kS-11@gated-at.bofh.it> <5fvam-3vP-9@gated-at.bofh.it>
	 <43910731.4090404@shaw.ca> <1133580225.4894.29.camel@localhost.localdomain>
	 <p73hd9p4xmu.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 13:26:18 -0500
Message-Id: <1133634378.6724.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 15:35 -0700, Andi Kleen wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> > 
> > Nope, the kernel is always locked into memory.  If you take a page fault
> > from the kernel world, you will crash and burn. The kernel is never
> > "swapped out".  So if you are in kernel mode, going into do_page_fault
> > in arch/i386/mm/fault.c there is no path to swap a page in.
> 
> Actually there is - when the page fault was caused by *_user. 

Sorry I wasn't clearer.  I know the copy_user case (and explained it in
detail earlier in this thread). I was talking about what happens in the
memcpy case.  So that should have said "outside of copy_user and
friends, there is no path to swap a page in".

-- Steve


