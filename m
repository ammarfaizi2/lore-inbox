Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992895AbWJUH2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992895AbWJUH2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992898AbWJUH2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:28:21 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46728 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992895AbWJUH2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:28:19 -0400
Date: Sat, 21 Oct 2006 03:28:07 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@infradead.org,
       jack@suse.cz
Subject: Re: [PATCH 01 of 23] VFS: change struct file to use struct path
Message-ID: <20061021072807.GF30620@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu> <b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu> <20061021002200.4731cdeb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061021002200.4731cdeb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 12:22:00AM -0700, Andrew Morton wrote:
> On Sat, 21 Oct 2006 02:17:26 -0400
> Josef "Jeff" Sipek <jsipek@cs.sunysb.edu> wrote:
> 
> > From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> > 
> > This patch changes struct file to use struct path instead of having
> > independent pointers to struct dentry and struct vfsmount, and converts all
> > users of f_{dentry,vfsmnt} in fs/ to use f_path.{dentry,mnt}.
> > 
> 
> why?

It's little cleaner than having two pointers. In general, there is a number
of users of dentry-vfsmount pairs in the kernel, and struct path nicely
wraps it.

As to why struct file in particular, and not some other structure, it's
mostly because Al suggested it... "I can give you a dozen examples of
possible users right now - starting with struct file" (from the struct path
thread few days ago.)

Josef "Jeff" Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
