Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSGVMsa>; Mon, 22 Jul 2002 08:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSGVMsa>; Mon, 22 Jul 2002 08:48:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41899 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316848AbSGVMs3>;
	Mon, 22 Jul 2002 08:48:29 -0400
Date: Mon, 22 Jul 2002 08:51:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: martin@dalecki.de
cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 sysctl
In-Reply-To: <3D3BE699.9000708@evision.ag>
Message-ID: <Pine.GSO.4.21.0207220843320.6045-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jul 2002, Marcin Dalecki wrote:

> > The kernel is full of GNUisms, and this one is actually usefull.
> 
> Its is not half as full as you may think.

Trailing comma in enums has _exactly_ the same status as .foo = bar in
structure initializers.  Both appear in C99 and were compiler-specific
extensions before that.

If -pedantic is unhappy about one but not another - take it with gcc
folks, it's a bug in gcc.

Speaking of GNUisms, inline assembler is one and it's by far the worst
obstacle to portability.  Speaking of *REALLY* ugly stuff - may I point
you to abuses of ##?  Yes, it's legal C.  No, using it is a Bad Idea(tm).
And the actual uses of _that_ one in the tree can give you the second
look at your breakfast - grep around and you'll see.

