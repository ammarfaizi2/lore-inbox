Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUBRJnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBRJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:43:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:30351 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263880AbUBRJnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:43:12 -0500
Date: Wed, 18 Feb 2004 01:44:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Niraj Kumar <niraj17@iitbombay.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6]  UFS2 Read Only Patch
Message-Id: <20040218014422.7a1144b3.akpm@osdl.org>
In-Reply-To: <40332F42.9070605@iitbombay.org>
References: <40332F42.9070605@iitbombay.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niraj Kumar <niraj17@iitbombay.org> wrote:
>
> lease  apply this patch .
>  They provide the bare minimum read-only support for
>  ufs2 variant (from FreeBSD 5.x ) of the UFS filesystem .
> 
>  The patch for 2.6.3 is here :
>  http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p1.txt
>  http://ufs-linux.sourceforge.net/ufs2/2.6.3/ufs2-read-only-p2.txt

ooh, I see you have a mkfs.ufs there.  Does it support UFS1 as well?

Does current UFS support little-endian machines?  If so, has this code been
tested on a little-endian host?  The code _looks_ OK, but one does need to
test...

Has the patched filesystem been regression tested against a UFS1 filesystem?


The patches which you have there are a bit of a disaster coding-style wise.

- Use hard tabs everywhere, not eight-spaces.

- No space before terminating semicolons

-

+        if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
+        {
+	     uspi->s_u2_size  = fs64_to_cpu(sb, usb->fs_u11.fs_u2.fs_size);

  should be

	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2) {

  etcetera.   See Documentation/CodingStyle.


Thanks.
