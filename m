Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUBWByd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUBWByd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:54:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:920 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbUBWByc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:54:32 -0500
Date: Sun, 22 Feb 2004 17:55:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
Message-Id: <20040222175507.558a5b3d.akpm@osdl.org>
In-Reply-To: <40395ACE.4030203@cyberone.com.au>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<40395ACE.4030203@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Andrew Morton wrote:
> 
> >
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/
> >
> >
> 
> URL is of course,
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/

Yes, thanks.

> This still doesn't shrink slab correctly on highmem machines
> because you dropped my patch :(

First, one needs to define "correctly".

Certainly, it is not "solves the alleged updatedb problem".

The design behind the slab shrinking is to reclaim slab in response to
memory demand.  Not in response to lowmem demand.  With all the scaling,
accounting-for-seeks-and-locality, etc.


