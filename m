Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269589AbRHMAaZ>; Sun, 12 Aug 2001 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHMAaP>; Sun, 12 Aug 2001 20:30:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269589AbRHMAaJ>; Sun, 12 Aug 2001 20:30:09 -0400
Subject: Re: 2.4.9-pre1 unresolved symbols in fat.o/smbfs.o
To: alessandro.suardi@oracle.com (Alessandro Suardi)
Date: Mon, 13 Aug 2001 01:32:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <no.id> from "Alessandro Suardi" at Aug 13, 2001 02:05:19 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15W5eq-0006Y5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/fs/fat/fat.o
> depmod: 	generic_file_llseek
> depmod: *** Unresolved symbols in /lib/modules/2.4.9-pre1/kernel/fs/smbfs/smbfs.o
> depmod: 	generic_file_llseek
>  

Oops my fault. My kernel/ksyms goes

EXPORT_SYMBOL(vfs_unlink);
EXPORT_SYMBOL(vfs_rename);
EXPORT_SYMBOL(vfs_statfs);
EXPORT_SYMBOL(generic_file_llseek);
EXPORT_SYMBOL(generic_read_dir);
EXPORT_SYMBOL(__pollwait);
EXPORT_SYMBOL(poll_freewait);


If you edit yours and drop that line in then rebuild from clean all should
be well
