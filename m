Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWJRIeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWJRIeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJRIef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:34:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750866AbWJRIee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:34:34 -0400
Date: Wed, 18 Oct 2006 01:31:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-Id: <20061018013103.4ad6311a.akpm@osdl.org>
In-Reply-To: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 00:23:23 -0400
Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:

> Few weeks ago, I noticed that fs/namei.c defines struct path:
> 
> struct path {
> 	struct vfsmount *mnt;
> 	struct dentry *dentry;
> };
> 
> I think it would make sense to move it into include/linux/ as it is quite
> useful (and it would discourage the (ab)use of struct nameidata.)
> 
> The fsstack code could benefit from it as the stackable fs dentries have to
> keep track of the lower dentry as well as the lower vfsmount.
> 
> One, rather unfortunate, fact is that struct path is also defined in
> include/linux/reiserfs_fs.h as something completely different - reiserfs
> specific.
> 
> Any thoughts?
> 

reiserfs is being bad.  s/path/reiserfs_path/g
