Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWJIUrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWJIUrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWJIUrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:47:07 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:40425 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964844AbWJIUrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:47:04 -0400
Date: Mon, 9 Oct 2006 16:46:44 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, notting@redhat.com, torvalds@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Introduce vfs_listxattr
Message-ID: <20061009204644.GB4707@filer.fsl.cs.sunysb.edu>
References: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu> <20061009133332.5c8285ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009133332.5c8285ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 01:33:32PM -0700, Andrew Morton wrote:
> On Mon, 9 Oct 2006 16:10:48 -0400
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> 
> > This patch moves code out of fs/xattr.c:listxattr into a new function -
> > vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
> > Nottingham <notting@redhat.com> to Unionfs.
> 
> That tells us what the patch does.  In general, please be sure to also tell
> us *why* you prepared a patch.
>
> Does this patch allow unionfs to be loaded into an otherwise unpatched
> kernel.org kernel?  If so, that seems to be a good reason for including
> this patch into the mainline kernel.

Sorry about that. The reason for this submission is to make the listxattr
code in fs/xattr.c a little cleaner (as well as to clean up some code in
Unionfs.)

Currently, Unionfs has vfs_listxattr defined in its code. I think that's
very ugly, and I'd like to see it (re)moved. The logical place to put it, is
along side of all the other vfs_*xattr functions. Overall, I think this
patch is benefitial for both kernel.org kernel and Unionfs.

Josef "Jeff" Sipek.

-- 
Humans were created by water to transport it upward.
