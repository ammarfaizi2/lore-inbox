Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278097AbRJPFVt>; Tue, 16 Oct 2001 01:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278095AbRJPFVi>; Tue, 16 Oct 2001 01:21:38 -0400
Received: from rj.sgi.com ([204.94.215.100]:36825 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278092AbRJPFVd>;
	Tue, 16 Oct 2001 01:21:33 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] fix NFS root in 2.4.12 
In-Reply-To: Your message of "Mon, 15 Oct 2001 19:01:08 MST."
             <3BCB94E4.AB6703D9@sun.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 15:21:56 +1000
Message-ID: <20387.1003209716@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001 19:01:08 -0700, 
Tim Hockin <thockin@sun.com> wrote:
>This one liner fixes NFS root for kernel 2.4.12.  Please apply.
>diff -ruN dist-2.4.12+patches/fs/super.c cvs-2.4.12+patches/fs/super.c
>--- dist-2.4.12+patches/fs/super.c	Mon Oct 15 10:23:02 2001
>+++ cvs-2.4.12+patches/fs/super.c	Mon Oct 15 10:23:02 2001
>@@ -935,7 +935,7 @@
> 	data = nfs_root_data();
> 	if (!data)
> 		goto no_nfs;
>-	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", data);
>+	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", NULL, data);
> 	if (!IS_ERR(vfsmnt)) {
> 		printk ("VFS: Mounted root (%s filesystem).\n", "nfs");
> 		ROOT_DEV = vfsmnt->mnt_sb->s_dev;

XFS only.  Fixed in XFS CVS tree now.

