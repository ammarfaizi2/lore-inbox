Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTAPACS>; Wed, 15 Jan 2003 19:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAPACQ>; Wed, 15 Jan 2003 19:02:16 -0500
Received: from fmr06.intel.com ([134.134.136.7]:46312 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261733AbTAPACN>; Wed, 15 Jan 2003 19:02:13 -0500
Message-ID: <34072.10.10.213.14.1042675870.squirrel@linux.intel.com>
Date: Wed, 15 Jan 2003 16:11:10 -0800 (PST)
Subject: Error compiling ieee1394/pcilynx.c (2.5.54)
From: "Tariq Shureih" <tariq@linux.co.intel.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Reply-To: tariq.shureih@intel.com
X-Mailer: SquirrelMail (version 1.2.10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of my work on the Kernel-Janitor project, I am looking at the
use of panic() in driver (char for now).

The pcilynx.c driver will not compile giving the following error.
I enabled I2C bit-bangin options as required by the driver.

Seems that the driver requires porting to 2.5.x since the i2c structures
and implementation has changed in 2.5.x.

Anyone working on this?  I can't proceed with my work not having this
compile.

Thanx

-------------

  gcc -Wp,-MD,drivers/ieee1394/.iso.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
 -DKBUILD_BASENAME=iso -DKBUILD_MODNAME=ieee1394   -c -o
drivers/ieee1394/iso.o drivers/ieee1394/iso.c
  ld -m elf_i386  -r -o drivers/ieee1394/ieee1394.ko
drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_transactions.o drivers/ieee1394/hosts.o
drivers/ieee1394/highlevel.o drivers/ieee1394/csr.o
drivers/ieee1394/nodemgr.o drivers/ieee1394/oui.o drivers/ieee1394/dma.o
drivers/ieee1394/iso.o
  gcc -Wp,-MD,drivers/ieee1394/.pcilynx.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=pentium4
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE
 -DKBUILD_BASENAME=pcilynx -DKBUILD_MODNAME=pcilynx   -c -o
drivers/ieee1394/pcilynx.o drivers/ieee1394/pcilynx.c
drivers/ieee1394/pcilynx.c:139: warning: initialization from
incompatible pointer type
drivers/ieee1394/pcilynx.c:140: warning: missing braces around
initializer drivers/ieee1394/pcilynx.c:140: warning: (near
initialization for
`bit_ops.name')
drivers/ieee1394/pcilynx.c:141: warning: initialization makes integer
from pointer without a cast
drivers/ieee1394/pcilynx.c:142: warning: initialization makes integer
from pointer without a cast
drivers/ieee1394/pcilynx.c:143: warning: initialization makes integer
from pointer without a cast
drivers/ieee1394/pcilynx.c:144: warning: initialization makes integer
from pointer without a cast
drivers/ieee1394/pcilynx.c:145: warning: initialization makes integer
from pointer without a cast
drivers/ieee1394/pcilynx.c:145: initializer element is not computable at
load time
drivers/ieee1394/pcilynx.c:145: (near initialization for
`bit_ops.name[5]') drivers/ieee1394/pcilynx.c:146: warning:
initialization makes integer from pointer without a cast
drivers/ieee1394/pcilynx.c:146: initializer element is not computable at
load time
drivers/ieee1394/pcilynx.c:146: (near initialization for
`bit_ops.name[6]') drivers/ieee1394/pcilynx.c:147: initializer element
is not constant drivers/ieee1394/pcilynx.c:147: (near initialization for
`bit_ops.name') drivers/ieee1394/pcilynx.c: In function `lynx_devctl':
drivers/ieee1394/pcilynx.c:763: warning: `_MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:346)
drivers/ieee1394/pcilynx.c:765: warning: `__MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:321)
make[2]: *** [drivers/ieee1394/pcilynx.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2


-- 
The greatest enemy to knowledge is not ignorance.  It's the illusion of
knowledge.  Thus the devil's greatest achievement was making people
believe he didn't exist!


