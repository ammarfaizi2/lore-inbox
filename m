Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbTFLWuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFLWuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:50:15 -0400
Received: from web40603.mail.yahoo.com ([66.218.78.140]:7284 "HELO
	web40603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265043AbTFLWt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:49:57 -0400
Message-ID: <20030612230341.27168.qmail@web40603.mail.yahoo.com>
Date: Thu, 12 Jun 2003 16:03:41 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: RE: limit resident memory size
To: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEBMDKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, the goal is to enforce strict upper bounds on
how much resources a process can consume, including
memory, disk bandwidth etc.  I understand that this
may not give the best aggregate system performance,
but so is any proportional sharing scheme.  The impact
of swapping/paging on the other processes can be
minimized by rate-limiting the disk I/O that the
process does, for swapping or anything else.

Muthian.

--- David Schwartz <davids@webmaster.com> wrote:
> 
> > I would like to limit the maximum resident memory
> size
> > of a process within a threshold, i.e. if its
> virtual
> > memory footprint exceeds this threshold, it needs
> to
> > swap out pages *only* from within its VM space.
> 
> 	Why? If you think this is a good way to be nice to
> other processes, you're
> wrong.
> 
> > First, is there a way this can be done at
> application
> > level ? The setrlimit interface seems to contain
> an
> > option for specifying max resident set size, but
> it
> > doesnt seem like it is implemented as of 2.4 -- am
> I
> > wrong ?
> 
> > If the kernel doesnt currently support it, is
> there an
> > efficient way (data structure etc) to traverse the
> > resident set of a *process* in lru fashion ?  All
> the
> > page replacement and swapping code work on the
> entire
> > page lists -- is there any simple way to group
> these
> > per process ?
> 
> 	One process paging and swapping excessively will
> hurt other processes that
> aren't. What's your outer problem? What you're
> trying to do doesn't seem to
> have any rational purpose.
> 
> 	DS
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
