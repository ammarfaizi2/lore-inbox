Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSBXM6Y>; Sun, 24 Feb 2002 07:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSBXM6P>; Sun, 24 Feb 2002 07:58:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287386AbSBXM6H>; Sun, 24 Feb 2002 07:58:07 -0500
Subject: Re: KMOD error messages - proposal and patch
To: perex@suse.cz (Jaroslav Kysela)
Date: Sun, 24 Feb 2002 13:12:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.31.0202241325270.510-100000@pnote.perex-int.cz> from "Jaroslav Kysela" at Feb 24, 2002 01:36:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eySE-0001co-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* Don't allow request_module() when ramfs based rootfs is mounted! */
> +	if ( ! strcmp("rootfs", current->fs->pwdmnt->mnt_sb->s_type->name) ) {
> +		printk(KERN_ERR "request_module[%s]: Real root fs not mounted\n",
> +			module_name);
> +		return -EPERM;
> +	}

The ramfs based root file system once the load ramfs from tar stuff is 
working may have a completely valid modprobe on it.

Perhaps request_module() needs a 'quiet' flag
