Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310280AbSCGKsQ>; Thu, 7 Mar 2002 05:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310284AbSCGKsG>; Thu, 7 Mar 2002 05:48:06 -0500
Received: from h139n1fls24o900.telia.com ([213.66.143.139]:63710 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S310280AbSCGKr7>;
	Thu, 7 Mar 2002 05:47:59 -0500
Date: Thu, 7 Mar 2002 11:48:45 +0100
From: Voluspa <voluspa@bigfoot.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
Message-Id: <20020307114845.530abcfa.voluspa@bigfoot.com>
In-Reply-To: <Pine.GSO.4.21.0203070329090.24127-100000@weyl.math.psu.edu>
In-Reply-To: <20020307085636.4feb2372.voluspa@bigfoot.com>
	<Pine.GSO.4.21.0203070329090.24127-100000@weyl.math.psu.edu>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002 03:42:32 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> and what filesystems are compiled in?  Actually, adding printk("%s\n", p);
> in the same place might give some hints...

Gave:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ext2
VFS: Cannot open root device "302" or 03:02
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:02

Since I've used "make oldconfig" and:

loke:loke:/usr/src/test$ diff my-2.5.6-pre2-.config my-2.5.6-pre3-.config 
288d287
< CONFIG_IDE_TASK_IOCTL=y
291c290
< # IDE chipset support/bugfixes
---
> # IDE chipset support
301d299
< # CONFIG_BLK_DEV_IDEDMA_FORCED is not set

only show enforced differences, I could boot into 2.5.6-pre2 tonight (about 6 hours from now) and dump whatever info you need - if it is deemed necessary. Otherwise I'll just enjoy the -ac series until a -preX turns up that is bootable.

Regards,
Mats Johannesson
Sweden
