Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFOQ0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFOQ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:26:37 -0400
Received: from lmout01.st1.spray.net ([212.78.202.120]:25582 "EHLO
	lmout01.st1.spray.net") by vger.kernel.org with ESMTP
	id S262361AbTFOQ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:26:32 -0400
From: =?ISO-8859-1?Q?=20Jos=E9?= Luis =?ISO-8859-1?Q?=20Alarc=F3n?=
	  =?ISO-8859-1?Q?=20S=E1nch?= =?ISO-8859-1?Q?ez?= 
	 <jlas9@lycos.es>
Message-ID: <1055695221031088@lycos-europe.com>
X-Mailer: LycosMail 
X-Originating-IP: [80.58.9.45]
Mime-Version: 1.0
Subject: Re: [PATCH] remove superfluous inode superblock check from shmem_mmap
Date: Sun, 15 Jun 2003 18:40:21 +0100
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0310881055695221_ID"
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0310881055695221_ID
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>
> ------- Mensaje Original -------
>
> DeJames Morris <jmorris@intercode.com.au>
> FechaMon, 16 Jun 2003 02:14:37 +1000 (EST)
>
>This patch against current 2.5 bk removes a (now) unecessary check 
for an 
>inode superblock in shmem_mmap().  In the current kernel, all inodes 
must 
>be associated with a superblock.
>
>- James
>-- 
>James Morris
>
>
>diff -purN -X dontdiff bk.pending/mm/shmem.c bk.w1/mm/shmem.c
>--- bk.pending/mm/shmem.c 2003-06-16 00:56:13.000000000 +1000
>+++ bk.w1/mm/shmem.c 2003-06-16 02:06:55.142303751 +1000
>@@ -1010,7 +1010,7 @@ static int shmem_mmap(struct file *file,
>  struct inode *inode = file->f_dentry->d_inode;
> 
>  ops = &shmem_vm_ops;
>- if (!inode->i_sb || !S_ISREG(inode->i_mode))
>+ if (!S_ISREG(inode->i_mode))
>   return -EACCES;
>  update_atime(inode);
>  vma->vm_ops = ops;
>

  Can i apply this patch against the 2.5.69 kernel?.

  Thanks yo very much, in advance.

  Regards.

  Jose.

http://linuxespana.scripterz.org

FreeBSD RELEASE 4.8.
Mandrake Linux 9.1 Kernels 2.4.21 & 2.5.69 XFS.
Registered Linux User #213309.
Memories..... You are talking about memories. 
Rick Deckard. Blade Runner.

_________________________________________________________
Envia tus postales desde Tarjetas Nico. Entra en http://www.tarjetasnico.com/es/index.html?partner=lycoses&nico_usr=premium



--=_NextPart_Lycos_0310881055695221_ID--

