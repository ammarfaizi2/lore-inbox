Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOBba>; Tue, 14 Nov 2000 20:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKOBbU>; Tue, 14 Nov 2000 20:31:20 -0500
Received: from [213.8.185.152] ([213.8.185.152]:23817 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129045AbQKOBbG>;
	Tue, 14 Nov 2000 20:31:06 -0500
Date: Wed, 15 Nov 2000 02:59:36 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: test11-pre5
In-Reply-To: <200011150025.QAA01893@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0011150250050.28006-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, David S. Miller wrote:

>    Date: 	Wed, 15 Nov 2000 02:25:38 +0200 (IST)
>    From: Dan Aloni <karrde@callisto.yi.org>
> 
>    Agreed. BTW, after grepping for IFNAMSIZ references I've noticed
>    some architectures (sparc64, mips64) define IFNAMSIZ for
>    themsleves, for example, arch/sparc64/kernel/ioctl32.c, which
>    defines it to 16, the same include/linux/if.h does. But if they are
>    not the same?
> 
> Then the compiler will start warning us :-)

I've also noticed that routing_ioctl() in arch/mips64/kernel/ioctl32.c
assumes the 16. Are those two platforms depend on having IFNAMSIZ == 16,
or this code just needs cleaning up?

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
