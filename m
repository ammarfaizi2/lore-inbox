Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUEIVtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUEIVtq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUEIVtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 17:49:46 -0400
Received: from vinc17.net1.nerim.net ([62.4.18.82]:36651 "EHLO ay.vinc17.org")
	by vger.kernel.org with ESMTP id S261162AbUEIVto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 17:49:44 -0400
Date: Sun, 9 May 2004 23:49:41 +0200
From: Vincent Lefevre <vincent@vinc17.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040509214941.GG7161@ay.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.org>,
	linux-kernel@vger.kernel.org
References: <20040509001045.GA23263@ay.vinc17.org> <Pine.LNX.4.53.0405082142100.25076@chaos> <20040509022043.GE23263@ay.vinc17.org> <20040509140611.28e4b2bf.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040509140611.28e4b2bf.pj@sgi.com>
X-Mailer-Info: http://www.vinc17.org/mutt/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-05-09 14:06:11 -0700, Paul Jackson wrote:
> Vincent wrote:
> > NULL == (void *) 0 and NULL == 0 must be true
> Yes - NULL is compares equal to both (void *)0 and 0.
> No - not necessarily the _same_ value - one could be
> on a system with 32 bit ints, 64 bit pointers, for example.

And so?

> > The goal of malloc is to reserve memory.
> It's up to the kernel whether sbrk (used by malloc to
> obtain virtual address space) reserves memory or not.

More old_mmap than brk (BTW, I forgot to say that this was on
an x86 machine, I don't know if this matters...).

> Check out:
>     /proc/sys/vm/overcommit_memory
>     Documentation/sysctl/vm.txt - overcommit_memory

But the documentation is wrong (on an official 2.4.26 kernel).
It seems that there is no way to get malloc() always return 0
when there isn't enough memory, even in simple cases (see my
program posted in the first message).

-- 
Vincent Lefèvre <vincent@vinc17.org> - Web: <http://www.vinc17.org/>
100% validated (X)HTML - Acorn / RISC OS / ARM, free software, YP17,
Championnat International des Jeux Mathématiques et Logiques, etc.
Work: CR INRIA - computer arithmetic / SPACES project at LORIA
