Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276745AbRJBW2Y>; Tue, 2 Oct 2001 18:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276748AbRJBW2O>; Tue, 2 Oct 2001 18:28:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276745AbRJBW2B>; Tue, 2 Oct 2001 18:28:01 -0400
Subject: Re: [PATCH] 2.4.10-ac3: fs/cramfs/Makefile
To: fdavis@si.rr.com
Date: Tue, 2 Oct 2001 23:33:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <3BBA3C4E.6020604@si.rr.com> from "Frank Davis" at Oct 02, 2001 06:14:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oY6b-0006BG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  O_TARGET := cramfs.o
>  
> -obj-y  := inode.o uncompress.o
> +obj-y  := inode.o uncompress.o ../inflate_fs/inflate_fs.o
>  
>  obj-m := $(O_TARGET)

ugghhhhhhhh

subdir-$(CONFIG_ZLIB_FS_INFLATE) += inflate_fs

So all you need to do is ensure CONFIG_ZLIB_FS_INFLATE is set right for
cramfs

and the logic in fs/config.in looks irght to me, but make you want to check
it

Alan
