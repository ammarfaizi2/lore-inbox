Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTAIFUn>; Thu, 9 Jan 2003 00:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTAIFUm>; Thu, 9 Jan 2003 00:20:42 -0500
Received: from mta03bw.bigpond.com ([139.134.6.86]:19403 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261624AbTAIFUm>; Thu, 9 Jan 2003 00:20:42 -0500
Message-ID: <3E1D095D.9080101@bigpond.com>
Date: Thu, 09 Jan 2003 16:32:13 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2) Gecko/20021202
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.21pre3-ac2
References: <20030109015006$7068@gated-at.bofh.it>
In-Reply-To: <20030109015006$7068@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
...
> o	Add the fast IRQ path to via 8233/5 audio	(me)
...

'fraid not:

gcc -D__KERNEL__ -I/usr/src/lx-2.4.21-p3-ac2/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 
-march=athlon  -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=via82cxxx_audio  -c -o 
via82cxxx_audio.o via82cxxx_audio.c
via82cxxx_audio.c: In function `via_new_interrupt':
via82cxxx_audio.c:1927: `status32' undeclared (first use in this function)
via82cxxx_audio.c:1927: (Each undeclared identifier is reported only once
via82cxxx_audio.c:1927: for each function it appears in.)
make[2]: *** [via82cxxx_audio.o] Error 1
make[2]: Leaving directory `/usr/src/lx-2.4.21-p3-ac2/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/usr/src/lx-2.4.21-p3-ac2/drivers'
make: *** [_mod_drivers] Error 2

