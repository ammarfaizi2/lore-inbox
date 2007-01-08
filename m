Return-Path: <linux-kernel-owner+w=401wt.eu-S964893AbXAHVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXAHVtv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbXAHVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:49:51 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46054 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXAHVtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:49:50 -0500
Date: Mon, 8 Jan 2007 13:29:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 06/24] Unionfs: Dentry operations
Message-Id: <20070108132953.b24339e6.akpm@osdl.org>
In-Reply-To: <11682295974095-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<11682295974095-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:12:58 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> This patch contains the dentry operations for Unionfs.
> 
> +/* declarations added for "sparse" */
> +extern int unionfs_d_revalidate_wrap(struct dentry *dentry,
> +				     struct nameidata *nd);
> +extern void unionfs_d_release(struct dentry *dentry);
> +extern void unionfs_d_iput(struct dentry *dentry, struct inode *inode);

No, declarations go in header files, visible to the definition and to all
callers.  (Ditto all the other places where this is done)
