Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310461AbSCPRYN>; Sat, 16 Mar 2002 12:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCPRYD>; Sat, 16 Mar 2002 12:24:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61192 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310459AbSCPRXu>; Sat, 16 Mar 2002 12:23:50 -0500
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined reference
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 16 Mar 2002 17:39:03 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <Pine.GSO.4.21.0203160515240.5891-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 16, 2002 05:16:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mI91-0006mI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* "Conditional" syscalls */
> +
> +asmlinkage long sys_nfsservctl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
> +asmlinkage long sys_quotactl(void) __attribute__ ((weak, alias ("sys_ni_syscall")));
> +

This is what Linus threw out before - when David wanted to use it to remove
all the intermodule crap.

It doesn't work with some architecture binutils
