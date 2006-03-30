Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWC3Ha5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWC3Ha5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWC3Ha5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:30:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751185AbWC3Ha4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:30:56 -0500
Date: Wed, 29 Mar 2006 23:30:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060329233037.14a24d4f.akpm@osdl.org>
In-Reply-To: <20060330072149.GI13476@suse.de>
References: <20060329122841.GC8186@suse.de>
	<20060329143758.607c1ccc.akpm@osdl.org>
	<Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
	<20060329180830.50666eff.akpm@osdl.org>
	<20060330072149.GI13476@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > > Right now "flags" doesn't do anything at all, and you should just pass in 
>  > > zero.
>  > 
>  > In that case perhaps we should be enforcing flags==0 so that future
>  > flags-using applications will reliably fail on old flags-not-understanding
>  > kernels.
>  > 
>  > But that won't work if we later define a bit in flags to mean "behave like
>  > old kernels used to".  So perhaps we should require that bits 0-15 of
>  > `flags' be zero and not care about bits 16-31.
>  > 
>  > IOW: it might be best to make `flags' just go away, and add new syscalls in
>  > the future as appropriate.
> 
>  Not if flags == 0 maintains the same behaviour. The only flag I can
>  think of right now is the 'move' or 'gift' flag, meaning that the caller
>  wants to migrate pages from the pipe instead of copying them. I'd
>  imagine we'd get that in way before 2.6.17 anyways, so I think we're
>  fine.

OK..  Do you plan to make it reject unrecognised flags?
