Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUCOEZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 23:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUCOEZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 23:25:44 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:53454 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262244AbUCOEZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 23:25:42 -0500
Date: Mon, 15 Mar 2004 05:25:41 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Message-ID: <20040315042541.GA31412@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314201457.23fdb96e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 08:14:57PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> >  ; this patch adds some functionality to the --bind
> >  ; type of vfs mounts.
> 
> This won't apply any more.  We very recently changed a large number of
> filesystems to not call update_atime() from within their readdir functions.
> That operation was hoisted up to vfs_readdir().

good decision, very recently probably means in the bk repository,
is there any link where I could download those changes?

> Also, rather than adding MNT_IS_RDONLY() and having to remember to check
> both the inode and the mount all over the kernel it would be better to
> change IS_RDONLY() to take two arguments - the inode and the vfsmnt.  That
> way we won't miss places, and unconverted code simpy won't compile, thus
> drawing attention to itself.  I don't know if this is feasible, but please
> consider it.

I don't have a problem with that, and it sounds good to me so
far, so I'll have a look at it, and will update the patch
accordingly ...

thanks for the response,
Herbert

