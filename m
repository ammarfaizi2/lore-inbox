Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSGOMKX>; Mon, 15 Jul 2002 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSGOMKW>; Mon, 15 Jul 2002 08:10:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22008 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317446AbSGOMKV>; Mon, 15 Jul 2002 08:10:21 -0400
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sam Vilain <sam@vilain.net>
Cc: dax@gurulabs.com, linux-kernel@vger.kernel.org
In-Reply-To: <E17U4YE-0000TL-00@hofmann>
References: <1026490866.5316.41.camel@thud> <1026679245.15054.9.camel@thud>
	<E17U1BD-0000m0-00@hofmann>
	<1026736251.13885.108.camel@irongate.swansea.linux.org.uk> 
	<E17U4YE-0000TL-00@hofmann>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 14:23:03 +0100
Message-Id: <1026739383.13885.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 13:02, Sam Vilain wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>    "Yes, we know that there is no directory hashing in ext2/3.  You'll have 
> to find another solution to the problem, I'm afraid.  Why not ease the
> burden on the filesystem by breaking up the task for it, and giving it
> to it in small pieces.  That way it's much less likely to choke."

Actually there are several other reasons for it. It sucks a lot less
when you need to use ls and friends to inspect part of the spool. It
also makes it much easier to split the mail spool over multiple disks as
it grows without having to backup/restore the spool area

> Sure, you could set up hierarchical mail spools.  But it sure stinks of a
> temporary solution for a long-term problem.  What about the next
> application that grows to massive proportions?

JFS ?

> Hey, while I've got your attention, how do you go about debugging your 
> kernel?  I'm trying to add fair scheduling to the new O(1) scheduler,
> something of a token bucket filter counting jiffies used by a
> process/user/s_context (in scheduler_tick()) and tweaking their 
> priority accordingly (in effective_prio()).  It'd be really nice if I
> could run it under UML or something like that so I can trace through
> it with gdb, but I couldn't get the UML patch to apply to your tree. 
> Any hints?

The UML tree and my tree don't quite merge easily. Your best bet is to
grab the Red Hat Limbo beta packages for the kernel source, which if I
remember rightly are both -ac based and include the option to build UML

Alan

