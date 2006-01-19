Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWASA54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWASA54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWASA54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:57:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45577 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161123AbWASA5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:57:55 -0500
Date: Thu, 19 Jan 2006 01:57:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: defconfig compile errors due to the tty changes
Message-ID: <20060119005754.GQ19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

it seems the following defconfig compile errors [1] are caused by your 
tty changes:


m68knommu:

<--  snip  -->

...
/usr/src/ctest/git/kernel/drivers/serial/mcfserial.c: In function `receive_chars':
/usr/src/ctest/git/kernel/drivers/serial/mcfserial.c:354: error: structure has no member named `flip'
make[3]: *** [drivers/serial/mcfserial.o] Error 1

<--  snip  -->


v850:

<--  snip  -->

...
  CC      arch/v850/kernel/simcons.o
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c: In function `simcons_poll_tty':
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:127: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:130: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:134: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:135: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:136: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/v850/kernel/simcons.c:137: error: structure has no member named `flip'
make[2]: *** [arch/v850/kernel/simcons.o] Error 1

<--   snip  -->


xtensa:

<--  snip  -->

...
  CC      arch/xtensa/platform-iss/console.o
/usr/src/ctest/git/kernel/arch/xtensa/platform-iss/console.c: In function `rs_poll':
/usr/src/ctest/git/kernel/arch/xtensa/platform-iss/console.c:131: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/xtensa/platform-iss/console.c:132: error: structure has no member named `flip'
/usr/src/ctest/git/kernel/arch/xtensa/platform-iss/console.c:133: error: structure has no member named `flip'
make[2]: *** [arch/xtensa/platform-iss/console.o] Error 1

<--  snip  -->


Can you fix them?


TIA
Adrian

[1] http://l4x.org/k/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

