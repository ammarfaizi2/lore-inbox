Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbWKUVCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWKUVCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWKUVCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:02:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10964 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161098AbWKUVCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:02:41 -0500
Date: Tue, 21 Nov 2006 21:06:22 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [2.6.19 patch] i386/x86_64: remove the unused
 EXPORT_SYMBOL(dump_trace)
Message-ID: <20061121210622.6cea428f@localhost.localdomain>
In-Reply-To: <20061121201844.GA7099@infradead.org>
References: <20061121194138.GF5200@stusta.de>
	<200611212047.30192.ak@suse.de>
	<20061121201844.GA7099@infradead.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 20:18:44 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Nov 21, 2006 at 08:47:30PM +0100, Andi Kleen wrote:
> > On Tuesday 21 November 2006 20:41, Adrian Bunk wrote:
> > > This patch removes the unused EXPORT_SYMBOL(dump_trace) added on i386 
> > > and x86_64 in 2.6.19-rc.
> > > 
> > > By removing them before the final 2.6.19 we avoid the possibility of 
> > > people later whining that we removed exports they started using.
> > 
> > I exported it for systemtap so that they can stop using the broken
> > hack they currently use as unwinder.
> 
> Nack, dump_trace is nothing that should be export for broken out of tree
> junk.

It is exported for systemtap not random broken out of tree junk, and the
result is a good deal prettier. Systemtap guys really ought to get their
stuff merged too, although how we merge a dynamic module writing tool I'm
not so sure ?

Alan
