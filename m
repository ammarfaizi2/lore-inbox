Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTIBSI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTIBSGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:06:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:9371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263947AbTIBSAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:00:32 -0400
Date: Tue, 2 Sep 2003 10:43:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-Id: <20030902104340.1e360f1b.akpm@osdl.org>
In-Reply-To: <20030902184236.A14715@infradead.org>
References: <20030902104212.GA23978@londo.lunn.ch>
	<20030902150808.A7388@infradead.org>
	<20030902102141.44dc7297.akpm@osdl.org>
	<20030902184236.A14715@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > IOW: we broke it.  Have you any theory as to which change caused this?
> 
> That's the magic use uid/gid of the process calling devfs_Register flag
> I killed.  With a big HEADSUP and explanation on lkml..

So what is the impact here?  That libc5 will break if the user is using
devfs and old-style pty's?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Christoph Hellwig <hch@infradead.org> wrote:
>
> > IOW: we broke it.  Have you any theory as to which change caused this?
> 
> That's the magic use uid/gid of the process calling devfs_Register flag
> I killed.  With a big HEADSUP and explanation on lkml..

So what is the impact here?  That libc5 will break if the user is using
devfs and old-style pty's?
