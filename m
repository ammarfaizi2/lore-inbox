Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTJTVsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTJTVsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:48:32 -0400
Received: from [65.172.181.6] ([65.172.181.6]:9355 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262747AbTJTVsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:48:31 -0400
Date: Mon, 20 Oct 2003 14:48:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1
Message-Id: <20031020144836.331c4062.akpm@osdl.org>
In-Reply-To: <200310201811.18310.schlicht@uni-mannheim.de>
References: <20031020020558.16d2a776.akpm@osdl.org>
	<200310201811.18310.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> On Monday 20 October 2003 11:05, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2
> >.6.0-test8-mm1
> >
> >
> > . Included a much updated fbdev patch.  Anyone who is using framebuffers,
> >   please test this.
> >
> > . Quite a large number of stability fixes.
> 
> I've got a problem with NFS!
> If the kernel NFS server (nfs-utils 1.0.6) is started I get following Oops:
> 
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c0163c36
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[invalidate_list+37/211]    Not tainted VLI

A colleague here has discovered that this crash is repeatable, but goes
away when the radeon driver is disabled.  

Are you using that driver?
