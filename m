Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276984AbRJIM1r>; Tue, 9 Oct 2001 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277102AbRJIM1i>; Tue, 9 Oct 2001 08:27:38 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:29658 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S277014AbRJIM1a>; Tue, 9 Oct 2001 08:27:30 -0400
Date: Tue, 9 Oct 2001 15:27:53 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Klaus Dittrich <kladit@t-online.de>
cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11-pre6 
In-Reply-To: <20011009130544.A737@df1tlpc.local.here>
Message-ID: <Pine.GSO.4.21.0110091503590.2709-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Almost a me too:

On a Compaq Armada 1750 with 2.4.3-20mdk (as installed from Mandrake 8.0):

dd if=/boot/grub/stage1 of=/dev/fd0 bs=512 seek=1
reports back: dd: /dev/fd0: Invalid argument

On the same laptop with 2.4.11-pre5 the same command barfs with:
dd: /dev/fd0: Permission denied

On a P180 w/ 2.4.10-pre13: dd: /dev/fd0: Permission denied

In the first kernel the floppy driver is compiled as a module.
Without the seek=1 (or whatever number there) it works in all cases.

I thought it was something that had to do with my drives but seeing
your report makes me wonder. Perhaps sombody more knowledgeable can
comment...

-K.


On Tue, 9 Oct 2001, Klaus Dittrich wrote:

> 
> dd and mkfs works with 2.4.3 but not with 2.4.11.x or 2.4.10.x
>  
> dd if=/dev/sda of=/dev/sdb bs=1024k   or   mkfs /dev/sdb3 
> both fail with "File size limit exceeded"
> 
> Booting the same system with 2.4.3 or 2.2.19 anything
> works as expected.
> 
> So is the problem with the kernel (as I assume) or do I miss something ?
> 
> Can anyone else please verify this ? 
> 
> (One really needs two disks, dd if=/dev/sda of=/dev/null does not show
> the problem)
> 
> -- 
> Best regards
> Klaus Dittrich
> 
> e-mail: kladit@t-online.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

