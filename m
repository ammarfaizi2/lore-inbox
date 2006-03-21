Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWCUQVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWCUQVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWCUQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:10 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:13523 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S932371AbWCUQVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:09 -0500
In-Reply-To: <20060321121550.GA7009@infradead.org>
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Sensitivity: 
To: Christoph Hellwig <hch@infradead.org>
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       prasanna@in.ibm.com, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OFBA270CB3.3C73C256-ON80257138.0058B7AE-80257138.00597F69@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 21 Mar 2006 16:17:33 +0000
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2006 16:21:30
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





72

Christoph Hellwig <hch@infradead.org> wrote on 21/03/2006 12:15:50:

> > I think you'll find it happened the other way round. Sun openly
references
> > my white papers. They even stole the name of an ancestor to kprobes.
But
> > who cares, it not relevant or particularly interesting whether the
chicken
> > or the egg came first.
>
> I know your papers, too.  In fact dprobes' RPN program downloads are a
far
> better design than systemtap's generation of kernel code.  it's a pity
that
> you gave up on dprobes instead of applying the required work to it and
> integrate it with other bits of a tracing framework.

Fascinating, gave up on dprobes, not really! I thought the kernel community
felt it was the wrong implementation. We did remove all the RPN stuff to a
loadable kernel module and left behind a minimal API set - krpobes - which
comprised the kernel probing mechanism, user-space probes extensions and
watchpoint probes extension. The result was identical functionality to the
original dprobes but with a minimal patch to the mainline kernel. But in
addition it provided a very much more generalized interface that would
allow other utilities to exploit the kernel interface, which they have. In
this sense dprobes still exists and can be used on top of krpobes. What
would you recommend be retained from  dprobes? And what further
modifications?

