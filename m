Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSJDWUj>; Fri, 4 Oct 2002 18:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261787AbSJDWUj>; Fri, 4 Oct 2002 18:20:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54283 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261686AbSJDWUi>; Fri, 4 Oct 2002 18:20:38 -0400
Date: Fri, 4 Oct 2002 15:25:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chuck Lever <cel@citi.umich.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] direct-IO API change
In-Reply-To: <Pine.LNX.4.44.0210041807340.8094-100000@dexter.citi.umich.edu>
Message-ID: <Pine.LNX.4.31.0210041525010.59482-100000@torvalds-p95.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 4 Oct 2002, Chuck Lever wrote:
>
> this patch adds a "struct file *" argument to direct I/O.  this is needed
> by NFS direct I/O to make the file's credentials available to direct I/O
> subroutines.  we can't remove "struct inode *" yet because the raw driver
> still needs it.

Why isn't the raw driver changed to just use file->f_dentry->d_inode
instead?

		Linus

