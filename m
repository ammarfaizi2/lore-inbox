Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbTE0UmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTE0UmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:42:03 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:1942 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S264157AbTE0Ukv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:40:51 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc5
References: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Tue, 27 May 2003 13:53:48 -0700
In-Reply-To: <Pine.LNX.4.55L.0305271640320.9487@freak.distro.conectiva> (message
 from Marcelo Tosatti on Tue, 27 May 2003 16:41:16 -0300 (BRT))
Message-ID: <8765nw2js3.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Mainly due to a IDE DMA problem which would happen on boxes with lots of
> RAM, here is -rc5.
>
> As I always ask, please test.

i get the following error:

make[5]: Entering directory `/usr/src/linux/drivers/ide/pci'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=via82cxxx  -c -o via82cxxx.o via82cxxx.c
via82cxxx.c:77: error: `PCI_DEVICE_ID_VIA_8237' undeclared here (not in a function)
via82cxxx.c:77: error: initializer element is not constant
via82cxxx.c:77: error: (near initialization for `via_isa_bridges[0].id')
via82cxxx.c:77: error: initializer element is not constant
via82cxxx.c:77: error: (near initialization for `via_isa_bridges[0]')
via82cxxx.c:78: error: initializer element is not constant
via82cxxx.c:78: error: (near initialization for `via_isa_bridges[1]')
via82cxxx.c:79: error: initializer element is not constant
via82cxxx.c:79: error: (near initialization for `via_isa_bridges[2]')
via82cxxx.c:80: error: initializer element is not constant
via82cxxx.c:80: error: (near initialization for `via_isa_bridges[3]')
via82cxxx.c:81: error: initializer element is not constant
via82cxxx.c:81: error: (near initialization for `via_isa_bridges[4]')
via82cxxx.c:82: error: initializer element is not constant
via82cxxx.c:82: error: (near initialization for `via_isa_bridges[5]')
via82cxxx.c:83: error: initializer element is not constant
via82cxxx.c:83: error: (near initialization for `via_isa_bridges[6]')
via82cxxx.c:84: error: initializer element is not constant
via82cxxx.c:84: error: (near initialization for `via_isa_bridges[7]')
via82cxxx.c:85: error: initializer element is not constant
via82cxxx.c:85: error: (near initialization for `via_isa_bridges[8]')
via82cxxx.c:86: error: initializer element is not constant
via82cxxx.c:86: error: (near initialization for `via_isa_bridges[9]')
via82cxxx.c:87: error: initializer element is not constant
via82cxxx.c:87: error: (near initialization for `via_isa_bridges[10]')
via82cxxx.c:88: error: initializer element is not constant
via82cxxx.c:88: error: (near initialization for `via_isa_bridges[11]')
via82cxxx.c:89: error: initializer element is not constant
via82cxxx.c:89: error: (near initialization for `via_isa_bridges[12]')
via82cxxx.c:90: error: initializer element is not constant
via82cxxx.c:90: error: (near initialization for `via_isa_bridges[13]')
via82cxxx.c:91: error: initializer element is not constant
via82cxxx.c:91: error: (near initialization for `via_isa_bridges[14]')
via82cxxx.c:92: error: initializer element is not constant
via82cxxx.c:92: error: (near initialization for `via_isa_bridges[15]')
via82cxxx.c:93: error: initializer element is not constant
via82cxxx.c:93: error: (near initialization for `via_isa_bridges[16]')
via82cxxx.c:94: error: initializer element is not constant
via82cxxx.c:94: error: (near initialization for `via_isa_bridges[17]')
via82cxxx.c:95: error: initializer element is not constant
via82cxxx.c:95: error: (near initialization for `via_isa_bridges[18]')
make[5]: *** [via82cxxx.o] Error 1
make[5]: Leaving directory `/usr/src/linux/drivers/ide/pci'
make[4]: *** [first_rule] Error 2
make[4]: Leaving directory `/usr/src/linux/drivers/ide/pci'
make[3]: *** [_subdir_pci] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers/ide'
make[2]: *** [_subdir_ide] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers'
make[1]: *** [_dir_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2

this compiled in -rc4.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
