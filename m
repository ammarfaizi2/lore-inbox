Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270448AbUJUBXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbUJUBXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbUJTX3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:29:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:41901 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270465AbUJTXZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:25:15 -0400
Date: Thu, 21 Oct 2004 01:25:09 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041020232509.GF995@wotan.suse.de>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net> <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020160450.0914270b.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 04:04:50PM -0700, David S. Miller wrote:
> On Thu, 21 Oct 2004 00:56:25 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > I don't think that's a good idea.  Normally new system calls 
> > are relatively obscure and the system works fine without them,
> > so urgent action is not needed.
> > 
> > And I think we can trust architecture maintainers to regularly
> > sync the system calls with i386.
> 
> I disagree quite strongly.  One major frustration for users of
> non-x86 platforms is that functionality is often missing for some
> time that we can make trivial to keep in sync.

I'm not sure really if the users of some embedded platform
are all sheering for key management system calls...

I guess they will prefer just something that compiles.

> 
> I religiously watch what goes into Linus's tree for this purpose,
> but that is kind of a rediculious burdon to expect every platform
> maintainer to do.  It's not just system calls, we have signal handling
> bug fixes, trap handling infrastructure, and now the nice generic
> IRQ handling subsystem as other examples.

Most of that is optional. When the arch maintainer choses not to
use it you have just unnecessarily  broken the build.

IMHO breaking the build unnecessarily is extremly bad because
it will prevent all testing. And would you really want to hold
up the whole linux testing machinery just for some obscure 
system call? IMHO not a good tradeoff.

> 
> Simply put, if you're not watching the tree in painstaking detail
> every day, you miss all of these enhancements.

I would assume the other maintainers go at least from time to 
time through the i386 diffs and check if they miss anything
(that is what I do). For system calls they do definitely, although
it may take some time.

> 
> The knowledge should come from the person putting the changes into
> the tree, therefore it gets done once and this makes it so that
> the other platform maintainers will find out about it automatically
> next time they update their tree.

And causing merging headaches and all kind of other problems.

-Andi

