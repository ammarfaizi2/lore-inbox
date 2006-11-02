Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752374AbWKBT1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbWKBT1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbWKBT1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:27:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752374AbWKBT1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:27:52 -0500
Date: Thu, 2 Nov 2006 11:27:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
Message-Id: <20061102112741.e1bb88c9.akpm@osdl.org>
In-Reply-To: <200611021724.02886.agruen@suse.de>
References: <200611021724.02886.agruen@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006 17:24:02 +0100
Andreas Gruenbacher <agruen@suse.de> wrote:

> The user.* extended attributes are only allowed on regular files and
> directories. Sticky directories further restrict write access to the
> owner and privileged users. (See the attr(5) man page for an
> explanation.)
> 
> The original check in ext2/ext3 when user.* xattrs were merged was more
> restrictive than intended, and when the xattr permission checks were moved 
> into the VFS, read access to user.* attributes on sticky directores ended up
> being denied in addition.

Am struggling to understand the impact of this.  I assume this problem was
introduced on Jan 9 by e0ad7b073eb7317e5afe0385b02dcb1d52a1eedf "move xattr
permission checks into the VFS"?

If so, the fix is applicable to 2.6.18, 2.6.19 and of course 2.6.20.

But to which of those should it be applied?
