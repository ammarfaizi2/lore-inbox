Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135760AbRAGFKf>; Sun, 7 Jan 2001 00:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135778AbRAGFKZ>; Sun, 7 Jan 2001 00:10:25 -0500
Received: from smtp.mountain.net ([198.77.1.35]:60425 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S135760AbRAGFKL>;
	Sun, 7 Jan 2001 00:10:11 -0500
Message-ID: <3A57FA27.348780BC@mountain.net>
Date: Sun, 07 Jan 2001 00:09:59 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-prerelease i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Johan Groth <jgroth@xpress.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel compile trouble
In-Reply-To: <3A57D935.52C7F2C9@xpress.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Groth wrote:
> 
> Hi,
> I wonder if anyone can help me with compilation of kernel 2.4.0. I've
> run make mrproper; make menuconfig; make dep and then I try to build the
> kernel with make bzImage but that fails utterly. I get the following
> message:
[...]
> /usr/src/linux/include/asm/string.h: In function `__constant_memcpy3d':
> /usr/src/linux/include/asm/string.h:305: `current' undeclared (first use
> in this function)
> /usr/src/linux/include/asm/string.h: In function `__memcpy3d':
> /usr/src/linux/include/asm/string.h:312: `current' undeclared (first use
> in this function)
> make: *** [init/main.o] Error 1
> 

Hello,

You don't show your .config, but I'll make a wild guess you're compiling for
SMP+3DNow (probably by selecting Athlon processor). If so pick one of:
	a) Deselect SMP, make clean make dep, etc.
	b) Downgrade processor selection to i686 or k6
	c) See the patch I posted here Tuesday.

Petr Vandrovec also posted a patch which takes a quite different approach.

Cheers,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
