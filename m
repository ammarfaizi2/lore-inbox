Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWJUXNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWJUXNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWJUXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 19:13:19 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:20632 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161157AbWJUXNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 19:13:18 -0400
Date: Sat, 21 Oct 2006 19:13:15 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@infradead.org
Subject: Re: [PATCH 08 of 23] isofs: change uses of f_{dentry, vfsmnt} to
 use f_path
In-Reply-To: <15a2d7465501c952a2af.1161411453@thor.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.64.0610211909210.17454@d.namei>
References: <15a2d7465501c952a2af.1161411453@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006, Josef Jeff Sipek wrote:

> +	struct inode *inode = file->f_path.dentry->d_inode;

It seems clumsy to pepper the kernel code with the above.

What about something like:

static inline struct inode *fpath_ino(struct file *file)
{
	return file->f_path.dentry->d_inode;
}



-- 
James Morris
<jmorris@namei.org>
