Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbRCGRlR>; Wed, 7 Mar 2001 12:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131132AbRCGRlI>; Wed, 7 Mar 2001 12:41:08 -0500
Received: from smtp8.xs4all.nl ([194.109.127.134]:48093 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131127AbRCGRkv>;
	Wed, 7 Mar 2001 12:40:51 -0500
From: thunder7@xs4all.nl
Date: Wed, 7 Mar 2001 12:41:36 +0100
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac13 es1370.o module and verbose bug reporting
Message-ID: <20010307124136.A6651@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -C  arch/i386/lib modules_install
make[1]: Entering directory `/usr/src/linux-2.4.2-ac13/arch/i386/lib'
make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.2-ac13/arch/i386/lib'
cd /lib/modules/2.4.2-ac13; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.2-ac13; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.2-ac13/kernel/drivers/sound/es1370.o
depmod:         do_BUG


CONFIG_SOUND_ES1370=m
CONFIG_DEBUG_BUGVERBOSE=y

If I set

CONFIG_DEBUG_BUGVERBOSE=n

it works as expected.

Good luck,
Jurriaan
-- 
The documentation is in Japanese.  Good luck.
	Rich 
GNU/Linux 2.4.2-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.34 0.08 0.02
