Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752286AbWKCIpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbWKCIpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbWKCIpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:45:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46564 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752153AbWKCIpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:45:20 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Timothy Shimmin <tes@sgi.com>
Subject: Re: [PATCH] Fix user.* xattr permission check for sticky dirs
Date: Fri, 3 Nov 2006 09:38:58 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200611021724.02886.agruen@suse.de> <200611022251.21816.agruen@suse.de> <BA8CE04BC202FBB09918854E@timothy-shimmins-power-mac-g5.local>
In-Reply-To: <BA8CE04BC202FBB09918854E@timothy-shimmins-power-mac-g5.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611030938.58873.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 November 2006 05:57, Timothy Shimmin wrote:
> > so this added the check to the xfs_getxattr() path by accident:
> >
> > []	if (!S_ISREG(inode->i_mode) &&
> > []	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
> > []		return -EPERM;
>
> Now, I'm a bit confused.
> xfs_getxattr?
> I see the "correct" version of the test in xfs_attr.c/attr_user_capable().

I meant to say fs/xattr.c:vfs_getxattr() and fs/xattr.c:vfs_setxattr(), sorry. 
The xfs code is fine, it just contains the same check once again in 
fs/xfs/xfs_attr.c:attr_user_capable().

Thanks,
Andreas
