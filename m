Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbUC2WYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUC2WYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:24:14 -0500
Received: from dip-202-72-139-108.wa.westnet.com.au ([202.72.139.108]:47621
	"EHLO fw.computerdatasafe.com.au") by vger.kernel.org with ESMTP
	id S263160AbUC2WYD (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:24:03 -0500
From: J <acpi@computerdatasafe.com.au>
To: Linux-Kernel@vger.kernel.org
Subject: 2.6.4 Build problem
Date: Tue, 30 Mar 2004 06:23:51 +0800
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403300623.51990.acpi@computerdatasafe.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did this:
untar ... # unpack 2.2.2
cd linux*
patch ... # patch to 2.6.3
patch ... # patch to 2.6.4
make -s allnoconfig
make -s xconfig
time make -s modules bzImage

and got build errors, so ...
mv .config ..
make -s mrproper
cp ../.config .
make -s oldconfig
time make  modules bzImage  >../build-log 2>&1
and got the same errors. The build terminates thus:
summer@Dolphin:~/pebble/kernel/linux-2.6.4$ tail -30 ../build-log
  CC [M]  lib/zlib_deflate/deflate_syms.o
  LD [M]  lib/zlib_deflate/zlib_deflate.o
  LD      lib/zlib_inflate/built-in.o
  CC [M]  lib/zlib_inflate/infblock.o
  CC [M]  lib/zlib_inflate/infcodes.o
  CC [M]  lib/zlib_inflate/inffast.o
  CC [M]  lib/zlib_inflate/inflate.o
  CC [M]  lib/zlib_inflate/inftrees.o
  CC [M]  lib/zlib_inflate/infutil.o
  CC [M]  lib/zlib_inflate/inflate_syms.o
  LD [M]  lib/zlib_inflate/zlib_inflate.o
  LD      arch/i386/lib/built-in.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x435e1): In function `ibmasm_register_uart':
: undefined reference to `register_serial'
drivers/built-in.o(.text+0x43649): In function `ibmasm_unregister_uart':
: undefined reference to `unregister_serial'
make: *** [.tmp_vmlinux1] Error 1
summer@Dolphin:~/pebble/kernel/linux-2.6.4$


The config file is at http://info.computerdatasafe.com.au/.config
and the build log at http://info.computerdatasafe.com.au/build-log


My real email:
echo summer?computerdatasafe.com.au | tr '?' '@'

Is there a workaround to get this built?

I'll locate and check the list in a day or so.


