Return-Path: <linux-kernel-owner+w=401wt.eu-S1751002AbXAHVYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXAHVYV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXAHVYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:24:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44596 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXAHVYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:24:20 -0500
Date: Mon, 8 Jan 2007 13:19:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-Id: <20070108131957.cbaf6736.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	<20070108111852.ee156a90.akpm@osdl.org>
	<Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 14:43:39 -0500 (EST)
Shaya Potter <spotter@cs.columbia.edu> wrote:

> On Mon, 8 Jan 2007, Andrew Morton wrote:
> 
> > On Sun,  7 Jan 2007 23:12:53 -0500
> > "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> >
> >> +Modifying a Unionfs branch directly, while the union is mounted, is
> >> +currently unsupported.
> >
> > Does this mean that if I have /a/b/ and /c/d/ unionised under /mnt/union, I
> > am not allowed to alter anything under /a/b/ and /c/d/?  That I may only
> > alter stuff under /mnt/union?
> >
> > If so, that sounds like a significant limitation.
> 
> haven't we been through this?

If it's not in the changelog or the documentation, it doesn't exist.  It's
useful for the developers to keep track of obvious and frequently-asked
questions such as this and to address them completely in the changelog
and/or documentation.  Otherwise things just come around again and again,
as we see here.

>  It's the same thing as modifying a block 
> device while a file system is using it.  Now, when unionfs gets confused, 
> it shouldn't oops, but would one expect ext3 to allow one to modify its 
> backing store while its using it?

There's no such problem with bind mounts.  It's surprising to see such a
restriction with union mounts.

