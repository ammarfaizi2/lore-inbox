Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVGKPVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVGKPVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGKPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:19:40 -0400
Received: from fsmlabs.com ([168.103.115.128]:65248 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261967AbVGKPQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:16:57 -0400
Date: Mon, 11 Jul 2005 09:21:47 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
In-Reply-To: <42D28A27.9000507@didntduck.org>
Message-ID: <Pine.LNX.4.61.0507110919270.16055@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel>
 <p73eka614t7.fsf@verdi.suse.de> <Pine.LNX.4.61.0507110718500.16055@montezuma.fsmlabs.com>
 <42D28A27.9000507@didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Brian Gerst wrote:

> Zwane Mwaikambo wrote:
> > On Sun, 11 Jul 2005, Andi Kleen wrote:
> > 
> > 
> > > Why per node? Why not go the whole way and make it per CPU?
> > > 
> > > I would also not define it statically, but allocate it at boot time
> > > in node local memory.
> > 
> > 
> > I went per node so that it would be minimal/zero impact for the no-node
> > case, it would also simplify hotplug cpu since once a cpu in a node goes
> > down, we still have other participating processors capable of handling its
> > devices without having to do too much migration work. I'll definitely
> > incorporate the node local allocations however, for some i386 systems we
> > might be forced to stick some additional IDTs on node 0 since the IDTR will
> > only take 32bit addresses and we could end up with only highmem on some
> > nodes.
> 
> Doesn't the IDTR take a virtual address?  It has to or else the f00f bug fix
> wouldn't work.

Yes you're right, i wasn't quite awake when i replied, thanks for 
correcting that.

	Zwane

