Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVCYHqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVCYHqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVCYHqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:46:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:30378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261520AbVCYHqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:46:12 -0500
Date: Thu, 24 Mar 2005 23:45:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: miles.lane@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-Id: <20050324234544.135a1eb2.akpm@osdl.org>
In-Reply-To: <20050325073846.A18596@flint.arm.linux.org.uk>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<a44ae5cd05032420122cd610bd@mail.gmail.com>
	<20050324202215.663bd8a9.akpm@osdl.org>
	<20050325073846.A18596@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Thu, Mar 24, 2005 at 08:22:15PM -0800, Andrew Morton wrote:
> > Miles Lane <miles.lane@gmail.com> wrote:
> > >  Unable to handle kernel paging request at virtual address 24fc1024
> > >  c0198448
> > >  *pde = 00000000
> > >  Oops: 0000 [#1]
> > >  CPU:    0
> > >  EIP:    0060:[<c0198448>]    Not tainted VLI
> > 
> > I wonder why the EIP sometimes doesn't get decoded.
> > 
> > >  Using defaults from ksymoops -t elf32-i386 -a i386
> > >  EFLAGS: 00210206   (2.6.12-rc1-mm2)
> 
> ksymoops seems to remove lines from the kernel output that it doesn't
> like.

but.  but.  There used to be a symbol+0xN/0xM in the EIP: line.  Are you
saying that ksymoops rubbed that out and stuck a hex number in there?

>   I've seen this many times on ARM, and each time I see an oops
> from a 2.6 kernel which has been ksymoopsed, I always ask the submitter
> to send the original non-ksymoopsed version.
> 
> Users need to be re-educated _not_ to use ksymoops.

I wonder if there's something clever we could do to the kallsymsised oops
output so that ksymoops would simply cease to recognise it.
