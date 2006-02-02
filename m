Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWBBWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWBBWSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBBWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:18:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932343AbWBBWSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:18:43 -0500
Date: Thu, 2 Feb 2006 14:20:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060202142041.6222e846.akpm@osdl.org>
In-Reply-To: <6bffcb0e0602021306l6b6c1423r@mail.gmail.com>
References: <20060124232406.50abccd1.akpm@osdl.org>
	<6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	<43D7A047.3070004@yahoo.com.au>
	<6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	<43D92754.4090007@yahoo.com.au>
	<43D927F6.9080807@yahoo.com.au>
	<6bffcb0e0601270211v787f91d2r@mail.gmail.com>
	<43E0718F.1020604@yahoo.com.au>
	<20060201005106.35ca4b8c.akpm@osdl.org>
	<6bffcb0e0602021306l6b6c1423r@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> On 01/02/06, Andrew Morton <akpm@osdl.org> wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> [snip]
> > > Andrew this one looks unrelated -
> > >  have you seen anything similar?
> >
> > No, I don't think I have.
> >
> > > Any ideas?
> >
> > This has a greggy feel to it.  udev is trying to read a symlink in sysfs,
> > probably USB-related, but it hit a bad address.  It might boot OK without
> > CONFIG_DEBUG_PAGEALLOC.
> >
> > Michal, it'd be useful to look up 0xb0161cdd in gdb, see what line it died
> > at.
> >
> 
> Here is output form gdb:
> http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-do_path_lookup

I actually meant `l *0xb0161cdd' so we get file-n-line.  But from that, it
appears that we won't get very interesting info anyway.

Oh well, let's see if this still happens in next -mm.  Bugs like this have
a habit of simply vanishing as people fix stuff up.
