Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131056AbRBXBCa>; Fri, 23 Feb 2001 20:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131057AbRBXBCV>; Fri, 23 Feb 2001 20:02:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131056AbRBXBCE>; Fri, 23 Feb 2001 20:02:04 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: RFC: vmalloc improvements
Date: 23 Feb 2001 17:01:35 -0800
Organization: Transmeta Corporation
Message-ID: <97715f$sj1$1@penguin.transmeta.com>
In-Reply-To: <200102240026.QAA09446@k2.llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200102240026.QAA09446@k2.llnl.gov>,
Reto Baettig  <baettig@k2.llnl.gov> wrote:
>
>We would volounteer to improve vmalloc if there is any chance of
>getting it into the main kernel tree. We also have an idea how we
>Could do that (quite similar to the process address space management):
>
>1.      Create a generic avl-tree headerfile (similar to list.h)
....

No thanks.

Just use the process address space management as-is, and make the
vmalloc address list be the same as any other address list: it would just
be the "native" address list for "init_mm".

You could probably even use "insert_vm_struct()" directly, and have that
do the AVL tree stuff for you, no changes needed.

>Is this something that makes sense to do and that could make it
>into the 2.4 or the 2.5 kernel?

It's definitely not a 2.4.x thing.

		Linus
