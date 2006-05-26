Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWEZIDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWEZIDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWEZIDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:03:06 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16348 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750821AbWEZIDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:03:03 -0400
Date: Fri, 26 May 2006 11:03:01 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Paul Drynoff <pauldrynoff@gmail.com>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
In-Reply-To: <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com> 
 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Paul Drynoff wrote:
> Actually, this is not full duplication:
> __do_kmalloc(size_t size, gfp_t flags,
>                                          void *caller)
> and
> void *kmalloc(size_t size, gfp_t gfp)
> 
> they have different amount of arguments and different arguments names.
> 
> But as I see include/linux/slab.h is better place. See patch.
> 
> It will be great to create another entry for flags of "kmalloc* family
> functions,
> so we can avoid duplication of this in __do_kmalloc and kmalloc
> comments, but I don't know is it possible with scripts/kernel-doc.
> 
> Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>

Just drop the __do_kmalloc() comment completely.  Did you check that 
kerneldoc picks it up for the generated API docs?  Btw, you should send 
this to Andrew at akpm@osdl.org instead of Linus.

				Pekka
