Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbTGEX42 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 19:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbTGEX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 19:56:27 -0400
Received: from [163.118.102.59] ([163.118.102.59]:2944 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S266568AbTGEX4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 19:56:21 -0400
Date: Sat, 5 Jul 2003 20:01:33 -0400
From: paterley <paterley@DrunkenCodePoets.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2
Message-Id: <20030705200133.3aa1da18.paterley@DrunkenCodePoets.com>
In-Reply-To: <20030705160445.2ab1e0ec.akpm@osdl.org>
References: <20030705132528.542ac65e.akpm@osdl.org>
	<20030705175830.4ccfead8.paterley@DrunkenCodePoets.com>
	<20030705182359.269b404d.paterley@DrunkenCodePoets.com>
	<20030705160445.2ab1e0ec.akpm@osdl.org>
Organization: DrunkenCodePoets.com
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same oops, at the same point with smbfs compiled in.  

fstab: (I've removed all the non samba mounts due to it being rather large)

#samba mounts
//udrive.fit.edu/perley           /mnt/smb         smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0
//163.118.102.61/f$               /mnt/smb2        smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0
//163.118.102.55/pat$             /mnt/55        smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0
//spaz.it.fit.edu/LambdaChiAlpha  /mnt/lcawebpage  smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0
//spaz.it.fit.edu/itit$ 	  /mnt/itit        smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0
//roadrunner.fit.edu/itit$        /mnt/roadrunner  smbfs     noatime,nosuid,users,credentials=/etc/smbmnt.auth 0 0
//roadrunner.fit.edu/support      /mnt/support     smbfs     noatime,nosuid,users,noauto,credentials=/etc/smbmnt.auth 0 0


On Sat, 5 Jul 2003 16:04:45 -0700
Andrew Morton <akpm@osdl.org> wrote:

> paterley <paterley@DrunkenCodePoets.com> wrote:
> >
> > ok, I get 4 of a kernel oops during boot, but the kernel seems to stay happy.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  EIP:    0060:[<00000000>]    Not tainted VLI
>   [<c01637ab>] __lookup_hash+0x9b/0xd0
>   [<c0163ff7>] open_namei+0x2e7/0x420
>   [<c0153751>] filp_open+0x41/0x70
>   [<c0153bd3>] sys_open+0x53/0x90
>   [<c010945f>] syscall_call+0x7/0xb
> 
> inode->i_op->lookup() is NULL.  Not good.
> 
> > according to dmesg, immediately prior to the first oops, smbfs was
> > unloaded due to unsafe usage.
> 
> Well no, it say it cannot be unloedad.
> 
> Could you please unconfigure smbfs in the kernel build?  And any other
> less commonly used filesytems?
> 
> Does it still oops if smbfs is build into the kernel (not a module).
> 
> Please send a copy of your /etc/fstab.
> 
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
