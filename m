Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTKQQfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTKQQfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:35:45 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:29642 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263553AbTKQQfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:35:38 -0500
Date: Mon, 17 Nov 2003 11:33:34 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Lars Ehrhardt <1103@ng.h42.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-bk22 does not compile on sparc64: undefined reference
 to `vga_writeb'
In-Reply-To: <3FB8F401.6070504@ng.h42.de>
Message-ID: <Pine.GSO.4.33.0311171131070.26356-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0311171131072.26356@sweetums.bluetronic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Lars Ehrhardt wrote:
>2.6.0-test9 does not compile on sparc64:
>
>(...)
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>drivers/built-in.o(.text+0x55ecc): In function `vgacon_do_font_op':
>: undefined reference to `vga_writeb'
>drivers/built-in.o(.text+0x55f1c): In function `vgacon_do_font_op':
>: undefined reference to `vga_writeb'
>drivers/built-in.o(.text+0x56264): In function `vgacon_do_font_op':
>: undefined reference to `vga_readb'
>drivers/built-in.o(.text+0x56288): In function `vgacon_do_font_op':
>: undefined reference to `vga_readb'
>make: *** [.tmp_vmlinux1] Error 1

"CONFIG_VGA_CONSOLE=y" is your problem.  Sparcs don't have a VGA console.
Use the prom console or a FB (or serial console.)

(This has come up a thousand times on the sparclinux list.)

--Ricky


