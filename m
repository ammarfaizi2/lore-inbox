Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUH0UWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUH0UWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUH0UTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:19:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266630AbUH0USJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:18:09 -0400
Date: Fri, 27 Aug 2004 13:17:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: airlied@linux.ie, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drm fixup 2/2 - optimise i8x0 accesses..
Message-Id: <20040827131739.6be24ee0.davem@redhat.com>
In-Reply-To: <20040827200815.GE23505@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0408271512330.32411@skynet>
	<20040827130415.754d4451.davem@redhat.com>
	<20040827200815.GE23505@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 22:08:15 +0200
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Fri, Aug 27, 2004 at 01:04:15PM -0700, David S. Miller wrote:
> > On Fri, 27 Aug 2004 15:13:54 +0100 (IST)
> > Dave Airlie <airlied@linux.ie> wrote:
> > 
> > >    the patch below optimises the drm code to not do put_user() on memory the
> > >    kernel allocated and then mmap-installed to userspace, but instead makes it
> > >    use the kernel virtual address directly instead.
> > 
> > This might cause major problems on systems with virtually indexed
> > caches if precautions are not made at buffer allocation time such
> > that the virtual cache color of the kernel mapping is the same
> > as the user mapping.
> 
> actually it's uncachable memory ;)

Then no problem :-)  Thanks for clearing that up.

