Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbSJBXYq>; Wed, 2 Oct 2002 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262671AbSJBXYq>; Wed, 2 Oct 2002 19:24:46 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:62961 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262669AbSJBXYp>; Wed, 2 Oct 2002 19:24:45 -0400
Message-ID: <3D9B8182.E0589E4E@eyal.emu.id.au>
Date: Thu, 03 Oct 2002 09:30:10 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre8-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre8aa2 - i8k compile failure
References: <20021002071110.GC1158@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> URL:
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre8aa2.gz


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=i8k  -c -o i8k.o i8k.c
In file included from i8k.c:25:
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/kbd_kern.h: In
function `con_schedule_flip':
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/kbd_kern.h:152:
dereferencing pointer to incomplete type
make[2]: *** [i8k.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/char'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
