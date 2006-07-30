Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWG3G0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWG3G0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWG3G0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:26:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbWG3G0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:26:35 -0400
Date: Sat, 29 Jul 2006 23:26:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nate.diller@gmail.com, ak@suse.de, torvalds@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
Message-Id: <20060729232625.c8bcac66.akpm@osdl.org>
In-Reply-To: <1154233334.5784.93.camel@localhost>
References: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
	<1154207668.5784.35.camel@localhost>
	<5c49b0ed0607291804j28193807t83d8237cad8d5ecd@mail.gmail.com>
	<1154233334.5784.93.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 00:22:14 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > of course, it could be that some quirk of the NFS client VFS interface
> > causes "spurious" -EIO returns.  either way, i'd rather see it fixed
> > rather than the printk removed, since it is useful to point out that
> > some performance degradation is occuring.
> 
> We have no way of telling. That printk doesn't give us any useful
> information whatsoever for debugging that sort of problem. It should
> either be replaced with something that does, or it should be thrown out.

err, the printk has found a probable bug in NFS.  That was pretty useful
of it.

Do we know why nfs's readpage isn't bringing the page up to date?
