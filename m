Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270348AbUJTXdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270348AbUJTXdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270518AbUJTXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:30:43 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:16544
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270348AbUJTXKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:10:41 -0400
Date: Wed, 20 Oct 2004 16:04:50 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386
 archs
Message-Id: <20041020160450.0914270b.davem@davemloft.net>
In-Reply-To: <20041020225625.GD995@wotan.suse.de>
References: <3506.1098283455@redhat.com>
	<20041020150149.7be06d6d.davem@davemloft.net>
	<20041020225625.GD995@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 00:56:25 +0200
Andi Kleen <ak@suse.de> wrote:

> I don't think that's a good idea.  Normally new system calls 
> are relatively obscure and the system works fine without them,
> so urgent action is not needed.
> 
> And I think we can trust architecture maintainers to regularly
> sync the system calls with i386.

I disagree quite strongly.  One major frustration for users of
non-x86 platforms is that functionality is often missing for some
time that we can make trivial to keep in sync.

I religiously watch what goes into Linus's tree for this purpose,
but that is kind of a rediculious burdon to expect every platform
maintainer to do.  It's not just system calls, we have signal handling
bug fixes, trap handling infrastructure, and now the nice generic
IRQ handling subsystem as other examples.

Simply put, if you're not watching the tree in painstaking detail
every day, you miss all of these enhancements.

The knowledge should come from the person putting the changes into
the tree, therefore it gets done once and this makes it so that
the other platform maintainers will find out about it automatically
next time they update their tree.
