Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269850AbRHMWFk>; Mon, 13 Aug 2001 18:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269851AbRHMWFa>; Mon, 13 Aug 2001 18:05:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57098 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269850AbRHMWFO>; Mon, 13 Aug 2001 18:05:14 -0400
Subject: Re: 2.4.9-pre2 breaks UFS as a module
To: alessandro.suardi@oracle.com (Alessandro Suardi)
Date: Mon, 13 Aug 2001 23:07:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Alessandro Suardi" at Aug 13, 2001 11:49:28 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WPsE-0008MG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make[2]: Entering directory `/share/src/linux-2.4.9-pre2/fs/ufs'
> gcc -D__KERNEL__ -I/share/src/linux-2.4.9-pre2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -DMODULE   -c -o file.o file.c
> file.c:80: `generic_file_open' undeclared here (not in a function)
> file.c:80: initializer element is not constant
> file.c:80: (near initialization for `ufs_file_operations.open')
> make[2]: *** [file.o] Error 1
> make[2]: Leaving directory `/share/src/linux-2.4.9-pre2/fs/ufs'
> make[1]: *** [_modsubdir_ufs] Error 2
> make[1]: Leaving directory `/share/src/linux-2.4.9-pre2/fs'
> make: *** [_mod_fs] Error 2

I'll take a look at that, Im trying to merge VFS things with Linus and its
non trivial to get all the bits in place and in the right order 8(
