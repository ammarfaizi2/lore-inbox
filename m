Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbTIQI0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTIQI0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:26:16 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.251]:31174 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id S262692AbTIQI0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:26:13 -0400
Date: Wed, 17 Sep 2003 10:26:08 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <info@melware.de>, <kkeil@suse.de>, <isdn4linux@listserv.isdn4linux.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: ISDN_DIVAS link error: multiple "errno"
In-Reply-To: <20030916175653.GD17690@fs.tum.de>
Message-ID: <Pine.LNX.4.31.0309171025070.19072-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

thanks for pointing out. I will create a patch.

Armin


On Tue, 16 Sep 2003, Adrian Bunk wrote:

> I got the following link error in 2.6.0-test5-mm2 (it desn't seem to be
> specific to -mm) with CONFIG_ISDN_DIVAS=y :
>
> <--  snip  -->
>
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.bss+0x123d60): multiple definition of `errno'
> lib/lib.a(errno.o)(.bss+0x0): first defined here
>
> <--  snip  -->
>
>
> drivers/isdn/hardware/eicon/divasmain.c has a non-static variable errno
> (on a first sight it doesn't seem to be really used) that conflicts
> with the variable in lib/errno.c .
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>

