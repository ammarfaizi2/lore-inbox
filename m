Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJKLfs>; Fri, 11 Oct 2002 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbSJKLfr>; Fri, 11 Oct 2002 07:35:47 -0400
Received: from dp.samba.org ([66.70.73.150]:7108 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262147AbSJKLfr>;
	Fri, 11 Oct 2002 07:35:47 -0400
Date: Fri, 11 Oct 2002 21:40:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41-mm3
Message-ID: <20021011114033.GA1677@krispykreme>
References: <200210112026.24155.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210112026.24155.conman@kolivas.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Compile failure:
> 
>   gcc -Wp,-MD,fs/smbfs/.inode.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic 
> -fomit-frame-pointer -nostdinc -iwithprefix include  -DSMBFS_PARANOIA  
> -DKBUILD_BASENAME=inode   -c -o fs/smbfs/inode.o fs/smbfs/inode.c
> fs/smbfs/inode.c: In function `smb_show_options':
> fs/smbfs/inode.c:436: `CONFIG_NLS_DEFAULT' undeclared (first use in this 
> function)
> fs/smbfs/inode.c:436: (Each undeclared identifier is reported only once
> fs/smbfs/inode.c:436: for each function it appears in.)
> fs/smbfs/inode.c: In function `smb_fill_super':
> fs/smbfs/inode.c:536: `CONFIG_NLS_DEFAULT' undeclared (first use in this 
> function)

There is a space missing in fs/nls/Config.in:

===== fs/nls/Config.in 1.7 vs edited =====
--- 1.7/fs/nls/Config.in	Fri Oct 11 05:16:07 2002
+++ edited/fs/nls/Config.in	Fri Oct 11 10:25:51 2002
@@ -12,7 +12,7 @@
 # msdos and Joliet want NLS
 if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" != "n" \
 	-o "$CONFIG_NTFS_FS" != "n" -o "$CONFIG_NCPFS_NLS" = "y" \
-	-o "$CONFIG_SMB_NLS" = "y" -o "$CONFIG_JFS_FS" != "n" -o "$CONFIG_CIFS" != "n"]; then
+	-o "$CONFIG_SMB_NLS" = "y" -o "$CONFIG_JFS_FS" != "n" -o "$CONFIG_CIFS" != "n" ]; then
   define_bool CONFIG_NLS y
 else
   define_bool CONFIG_NLS n
