Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130586AbQKLMXS>; Sun, 12 Nov 2000 07:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130649AbQKLMXI>; Sun, 12 Nov 2000 07:23:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34575 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130645AbQKLMW7>;
	Sun, 12 Nov 2000 07:22:59 -0500
Message-ID: <3A0E8B99.2EA40AF0@mandrakesoft.com>
Date: Sun, 12 Nov 2000 07:22:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan Filius <iafilius@xs4all.nl>
CC: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.4.0-test11-pre3 doesn't compile (ax25 and md)
In-Reply-To: <Pine.LNX.4.21.0011121308440.5594-100000@sjoerd.sjoerdnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan Filius wrote:
> 
> Hello,
> 
> I noticed also md.c doesn't compile (gcc version 2.95.2 )
> Here is the (stripped) output from a make -i modules:
> 
> make -C md modules
> make[2]: Entering directory `/usr/src/linux-2.4.0-test11-pre3/drivers/md'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c md.c
> In file included from md.c:33:
> /usr/src/linux/include/linux/sysctl.h:35: parse error before `size_t'

Either md.c or sysctl.h needs to include <linux/types.h>.

-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
