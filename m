Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317668AbSFLIWn>; Wed, 12 Jun 2002 04:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317670AbSFLIWm>; Wed, 12 Jun 2002 04:22:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317668AbSFLIWl>; Wed, 12 Jun 2002 04:22:41 -0400
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 12 Jun 2002 08:57:52 +0100 (BST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
In-Reply-To: <E17Hflq-0005Hf-00@wagner.rustcorp.com.au> from "Rusty Russell" at Jun 11, 2002 05:08:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I30q-00077h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.21.24110/fs/ntfs/compress.c	Sat May 25 14:34:53 2002
>  		return -ENOMEM;
> -	for (i = 0; i < smp_num_cpus; i++) {
> +	for (i = 0; i < NR_CPUS; i++) {
>  		ntfs_compression_buffers[i] = (u8*)vmalloc(NTFS_MAX_CB_SIZE);
>  		if (!ntfs_compression_buffers[i])
>  			break;

2Mbytes !!!!!!

Add a cpu count changed notifier ?

