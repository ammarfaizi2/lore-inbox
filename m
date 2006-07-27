Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWG0VKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWG0VKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWG0VKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:10:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:16882 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751179AbWG0VKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:10:12 -0400
Date: Thu, 27 Jul 2006 23:09:49 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Tom Horsley <tom.horsley@ccur.com>
cc: 7eggert@gmx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] documentation: Documentation/initrd.txt
In-Reply-To: <1154020546.5166.35.camel@tweety>
Message-ID: <Pine.LNX.4.58.0607272257100.5867@be1.lrz>
References: <6DfYt-7zU-49@gated-at.bofh.it>  <E1G69M4-0001Um-Jg@be1.lrz>
 <1154020546.5166.35.camel@tweety>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Tom Horsley wrote:
> On Thu, 2006-07-27 at 19:08 +0200, Bodo Eggert wrote:

> > > I spent a long time the other day trying to examine an initrd
> > > image on a fedora core 5 system because the initrd.txt file
> > > is apparently obsolete. Here is a patch which I hope
> > > will reduce future confusion for others.
> > 
> > Your documentation is technically wrong, and there is a better
> > explanation:
> 
> I find it easy to believe my document is wrong, but looking at
> the Documentation/filesystems/ramfs-rootfs-initramfs.txt file
> would never have led me to believe that the initrd.img file
> was related in any way. The ramfs-rootfs-initramfs.txt
> file describes the the archive as being built into the
> kernel, so it needs updating too I guess (and fedora
> should change the name of the initrd files to be
> initramfs files so I'll look for documentation in the right
> place :-).

Yes.

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- 2.6.17/Documentation/initrd.txt.ori	2006-07-27 18:49:25.000000000 +0200
+++ 2.6.17/Documentation/initrd.txt	2006-07-27 18:58:19.000000000 +0200
@@ -15,6 +15,9 @@ initrd is mainly designed to allow syste
 where the kernel comes up with a minimum set of compiled-in drivers, and
 where additional modules are loaded from initrd.
 
+initrd has recently been obsoleted by initramfs, which is described in
+Documentation/filesystems/ramfs-rootfs-initramfs.txt.
+
 This document gives a brief overview of the use of initrd. A more detailed
 discussion of the boot process can be found in [1].
 
--- 2.6.17/Documentation/filesystems/ramfs-rootfs-initramfs.txt.ori	2006-07-27 23:05:44.000000000 +0200
+++ 2.6.17/Documentation/filesystems/ramfs-rootfs-initramfs.txt	2006-07-27 23:06:26.000000000 +0200
@@ -96,6 +96,10 @@ All this differs from the old initrd in 
     into the linux kernel image.  (The directory linux-*/usr is devoted to
     generating this archive during the build.)
     
+    However, if you use one or more compressed cpio archives (concatenated) 
+    instead of an initrd image, they will be unpacked, too, possibly
+    replacing existing files.
+
   - The old initrd file was a gzipped filesystem image (in some file format,
     such as ext2, that had to be built into the kernel), while the new
     initramfs archive is a gzipped cpio archive (like tar only simpler,
-- 
Fun things to slip into your budget
Request for 'supermodel access' to the UNIX server.
	Just don't tell the PHB why your home directory is named 'jpgs.'
